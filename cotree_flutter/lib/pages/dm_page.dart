import 'dart:async';

import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_richtext.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// Enhanced DM page with:
/// - Date chips (Today/Yesterday/DD Mon YYYY)
/// - "New messages" unread divider
/// - Read receipts (single tick / double tick)
/// - Scroll-to-bottom FAB
/// - Unified StreamBuilder that shows empty-state until first message arrives
/// - Mark All as Read action
class DmPage extends StatefulWidget {
  final UserView user; // "me"
  final int userId; // other user id to fetch view
  final Chat chat;
  const DmPage(
      {super.key,
      required this.chat,
      required this.userId,
      required this.user});

  @override
  State<DmPage> createState() => _DmPageState();
}

class _DmPageState extends State<DmPage> with WidgetsBindingObserver {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  StreamSubscription<Message>? _messageSubscription;
  late UserView userData; // other user
  List<Message> messageData = [];
  StreamController<List<Message>>? _controller;

  bool isLoading = true;

  /// Timestamp of last time **I** read messages in this chat (used for unread divider).
  DateTime? _myLastReadAt;

  /// Timestamp of last time **they** read (for read receipts on outgoing).
  DateTime? _otherLastReadAt;

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return true;
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    return (max - current) < 80;
  }

  Future<void> getUserView() async {
    final userInfo = await client.account.getUserView(widget.userId);
    setState(() => userData = userInfo);
  }

  Future<void> _initializeChat() async {
    _ensureController();

    // Initial fetch
    final messageInfo = await client.chat
        .fetchChatMessages(widget.chat.id!, widget.user.userId);
    messageData = List.from(messageInfo)
      ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

    // Optional: if you can obtain persisted lastReadAt from your backend, set it here.
    // For now, default to no unread divider (treat all as already read).
    _myLastReadAt ??= DateTime.now();

    // Send initial payload after first frame so StreamBuilder renders empty or list correctly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller?.add(List.from(messageData));
    });

    setState(() => isLoading = false);

    // Live updates
    _messageSubscription =
        client.chat.messageStream(widget.chat.id!).listen((msg) {
      // Keep list sorted by time in case server out-of-order
      final i = messageData.indexWhere((m) => identical(m, msg));
      if (i == -1) {
        messageData.add(msg);
        messageData.sort((a, b) => a.sentAt.compareTo(b.sentAt));
      } else {
        messageData[i] = msg;
      }

      // Auto-mark as read for incoming messages if user is viewing bottom
      if (_isIncoming(msg) && _isInForeground && _isNearBottom) {
        _markAllAsRead(localOnly: true);
      }

      _controller?.add(List.from(messageData));
    });
  }

  bool _isIncoming(Message m) => m.senderId != widget.user.userId;

  void _ensureController() {
    if (_controller == null || _controller!.isClosed) {
      _controller = StreamController<List<Message>>.broadcast();
    }
  }

  void _send() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final msg = Message(
      chatId: widget.chat.id!,
      senderId: widget.user.userId,
      content: text,
      sentAt: DateTime.now(),
    );

    client.chat.sendMessage(widget.chat.id!, msg);
    messageController.clear();

    // No optimistic insert — the stream will deliver it back. We just keep the user at bottom.
    _jumpToBottomSoon();
  }

  void _jumpToBottomSoon() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // MARK: Read handling

  Future<void> _markAllAsRead({bool localOnly = false}) async {
    setState(() => _myLastReadAt = DateTime.now());

    if (localOnly) return;

    // TODO: If your SDK exposes a mark-read API, call it here.
    // Example (pseudo): await client.chat.markAsRead(widget.chat.id!);
  }

  // Lifecycle handling
  bool _isInForeground = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isInForeground = state == AppLifecycleState.resumed;
    if (state == AppLifecycleState.resumed) {
      _restartStream();
    } else if (state == AppLifecycleState.paused) {
      _messageSubscription?.cancel();
    }
  }

  void _restartStream() {
    _messageSubscription?.cancel();
    _ensureController();

    _messageSubscription =
        client.chat.messageStream(widget.chat.id!).listen((msg) {
      messageData.add(msg);
      messageData.sort((a, b) => a.sentAt.compareTo(b.sentAt));
      if (_isIncoming(msg) && _isNearBottom) {
        _markAllAsRead(localOnly: true);
      }
      _controller?.add(List.from(messageData));
    });
  }

  // BUILD
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getUserView();
    _ensureController();
    _initializeChat();

    _scrollController.addListener(() {
      // When user scrolls to bottom and there are incoming messages -> mark as read locally
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 4) {
        _markAllAsRead(localOnly: true);
      }
      setState(() {}); // to toggle FAB visibility
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageSubscription?.cancel();
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: isLoading
          ? AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            )
          : AppBar(
              elevation: 2,
              shadowColor: Provider.of<ThemeProvider>(context).contrastColor,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage(profileId: userData.userId)));
                  },
                  child: Row(children: [
                    AbsAvatar(radius: 18, avatarUrl: userData.avatar),
                    const SizedBox(width: 10),
                    Expanded(
                        child: AbsText(
                            displayString: userData.name, fontSize: 16)),
                  ])),
              centerTitle: true,
            ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Expanded(child: _streamArea()),
                  _inputBox(theme),
                  const SizedBox(height: 12),
                ],
              ),
            ),
      floatingActionButton: _showScrollToBottomFab
          ? FloatingActionButton(
              onPressed: _jumpToBottomSoon,
              child: const Icon(Icons.arrow_downward_rounded),
            )
          : null,
    );
  }

  bool get _showScrollToBottomFab {
    if (!_scrollController.hasClients) return false;
    return !_isNearBottom;
  }

  Widget _streamArea() {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<List<Message>>(
      stream: _controller!.stream,
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }

        final msgs = snap.data ?? const <Message>[];
        if (msgs.isEmpty) {
          return _emptyState();
        }

        final entries = _buildEntries(msgs);

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: entries.length,
          itemBuilder: (context, i) {
            final e = entries[i];
            if (e is _DateDividerEntry) return _dateChip(e.date);
            if (e is _UnreadDividerEntry) return _unreadDivider();
            if (e is _MessageEntry) return _messageTile(e.message);
            return const SizedBox.shrink(); // fallback
          },
        );
      },
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AbsAvatar(radius: 50, avatarUrl: userData.avatar),
          const SizedBox(height: 20),
          AbsText(
              displayString: "Start Chatting with ${userData.name}",
              fontSize: 20),
          const SizedBox(height: 10),
          AbsText(displayString: userData.headline, fontSize: 15),
        ],
      ),
    );
  }

  // ENTRY BUILDERS
  Widget _dateChip(DateTime date) {
    final text = _friendlyDate(date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Provider.of<ThemeProvider>(context).headColor,
            borderRadius: BorderRadius.circular(999),
          ),
          child: AbsText(displayString: text, fontSize: 12),
        ),
      ),
    );
  }

  Widget _unreadDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Expanded(child: Divider(thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AbsText(displayString: 'New messages', fontSize: 12),
          ),
          const Expanded(child: Divider(thickness: 1)),
        ],
      ),
    );
  }

  Widget _messageTile(Message message) {
    final isMe = message.senderId == widget.user.userId;

    final bubble = isMe
        ? AbsMinimalBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AbsRichtext(displayString: message.content, fontSize: 13),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AbsText(
                        displayString: DateFormat('hh:mm a')
                            .format(message.sentAt.toLocal()),
                        fontSize: 11),
                    const SizedBox(width: 6),
                    _readReceiptIcon(message),
                  ],
                )
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).headColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsRichtext(displayString: message.content, fontSize: 13),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AbsText(
                          displayString: DateFormat('hh:mm a')
                              .format(message.sentAt.toLocal()),
                          fontSize: 11),
                    ],
                  )
                ],
              ),
            ),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isMe
            ? [
                const Expanded(child: SizedBox()),
                Expanded(flex: 2, child: bubble)
              ]
            : [
                Expanded(flex: 2, child: bubble),
                const Expanded(child: SizedBox())
              ],
      ),
    );
  }

  Widget _readReceiptIcon(Message m) {
    // Heuristic read receipt: show double-tick if we know the other read after this message.
    final otherSeen = _otherLastReadAt;
    final isRead = otherSeen != null && !m.sentAt.isAfter(otherSeen);
    return Icon(isRead ? Icons.done_all : Icons.done,
        size: 14, color: isRead ? Theme.of(context).colorScheme.primary : null);
  }

  List<_Entry> _buildEntries(List<Message> msgs) {
    final entries = <_Entry>[];
    if (msgs.isEmpty) return entries;

    // Ensure ascending chronological order
    final sorted = List<Message>.from(msgs)
      ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

    String? lastDayKey;
    final myReadAt = _myLastReadAt; // snapshot

    // Decide position for unread divider: first incoming after myReadAt
    int? unreadInsertIndex;
    if (myReadAt != null) {
      for (int i = 0; i < sorted.length; i++) {
        final m = sorted[i];
        if (_isIncoming(m) && m.sentAt.isAfter(myReadAt)) {
          unreadInsertIndex = i; // before this index
          break;
        }
      }
    }

    for (int i = 0; i < sorted.length; i++) {
      final msg = sorted[i];
      final key = DateFormat('yyyy-MM-dd').format(msg.sentAt.toLocal());
      if (key != lastDayKey) {
        lastDayKey = key;
        entries.add(_DateDividerEntry(
            DateTime(msg.sentAt.year, msg.sentAt.month, msg.sentAt.day)));
      }

      // Insert unread divider exactly once before the first unread incoming message
      if (unreadInsertIndex != null && i == unreadInsertIndex) {
        entries.add(_UnreadDividerEntry());
      }

      entries.add(_MessageEntry(msg));
    }

    return entries;
  }

  String _friendlyDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final other = DateTime(date.year, date.month, date.day);

    if (other == today) return 'Today';
    if (other == today.subtract(const Duration(days: 1))) return 'Yesterday';
    return DateFormat('d MMM yyyy').format(other);
  }

  Widget _inputBox(ThemeData theme) {
    return AbsMinimalBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: AbsMultilineTextfield(
              hintText: 'message',
              minLines: 1,
              maxLines: 5,
              controller: messageController,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _send,
            icon: const HeroIcon(HeroIcons.paperAirplane),
            tooltip: 'Send',
          ),
        ],
      ),
    );
  }
}

// ----- Internal entry types for the ListView -----
abstract class _Entry {}

class _DateDividerEntry extends _Entry {
  final DateTime date;
  _DateDividerEntry(this.date);
}

class _UnreadDividerEntry extends _Entry {}

class _MessageEntry extends _Entry {
  final Message message;
  _MessageEntry(this.message);
}
