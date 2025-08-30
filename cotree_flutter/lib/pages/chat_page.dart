import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_chat_tile.dart';
import 'package:cotree_flutter/components/abs_searchbar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/dm_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatItem {
  final Chat chat;
  final String? lastMessage;
  _ChatItem({required this.chat, required this.lastMessage});
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController searchController = TextEditingController();
  late List<_ChatItem> chatData;
  late UserView userview;
  List<User> searchResult = [];
  OverlayEntry? overlayEntry;
  LayerLink _layerLink = LayerLink();
  Stream<User>? searchStream;
  bool isLoading = true;

  Future<void> initializePage() async {
    List<_ChatItem> buildData = [];
    final userCache = context.read<UserCacheService>();
    // Get or set user
    final user = await userCache.getOrSetUserView(context);
    List<Chat> chats =
        await client.chat.retrieveDmChats(sessionManager.signedInUser!.id!);
    for (var chat in chats) {
      var lastMessage = await client.chat.fetchLastMessage(chat.id!);
      buildData.add(_ChatItem(chat: chat, lastMessage: lastMessage));
    }
    setState(() {
      userview = user;
      chatData = buildData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    initializePage();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    overlayEntry?.remove();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      searchResult = [];
      _removeOverlay();
      return;
    }

    searchStream =
        client.chat.chatUserSearch(sessionManager.signedInUser!.id, query);
    searchResult = [];
    searchStream!.listen((results) {
      setState(() {
        searchResult.add(results);
        _showOverlay();
      });
    });
  }

  Future<Chat> getChatData(User user) async {
    Chat data = await client.chat
        .getOrCreateChat(sessionManager.signedInUser!.id!, user.id!);
    return data;
  }

  void _showOverlay() {
    _removeOverlay();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 40,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, 50), // Position below the text field
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: searchResult.map((user) {
                return ListTile(
                  title: Text(user.name),
                  onTap: () async {
                    searchController.text = user.name;
                    Chat chatData = await client.chat
                        .getOrCreateChat(userview.userId, user.id!);
                    _removeOverlay();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DmPage(
                                chat: chatData,
                                userId: user.id!,
                                user: userview)));
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: AbsSearchbar(
              onChanged: _onSearchChanged, controller: searchController),
        ),
        const SizedBox(height: 8),
        if (isLoading || chatData.isEmpty) ...[
          const SizedBox(height: 100),
          const Center(
              child: AbsText(displayString: "No Previous Chats!", fontSize: 24))
        ] else ...[
          for (int i = 0; i < chatData.length; i++) ...[
            AbsChatTile(
              chat: chatData[i].chat,
              myUserView: userview,
              lastMessage: chatData[i].lastMessage,
              onBack: () {
                setState(() {
                  isLoading = true;
                });
                initializePage();
              },
            ),
            const SizedBox(height: 5),
          ],
        ]
      ],
    );
  }
}
