import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_request_card.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestsPage extends StatefulWidget {
  final int userId;
  final int initialIndex;
  const RequestsPage({super.key, required this.userId, this.initialIndex = 0});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  List<Invitation> sent = [];
  List<Invitation> received = [];
  int _groupValue = 0;
  bool isLoading = true;

  void getBuildData() async {
    var data = await client.connection.fetchInvitations(widget.userId);
    if (!mounted) return; // safety against setState after dispose
    setState(() {
      if (widget.initialIndex == 1) {
        _groupValue = 1;
      }
      for (var element in data) {
        if (element.sender == widget.userId) {
          sent.add(element);
        } else {
          received.add(element);
        }
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Run after first frame to avoid dual-build issue
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBuildData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AbsText(
              displayString: "Connection Requests", fontSize: 16, bold: true),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                isLoading = true;
                sent = [];
                received = [];
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                getBuildData();
              });
            },
            child: SafeArea(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CupertinoSlidingSegmentedControl<int>(
                                    // The animation for the sliding selection is built-in here.
                                    children: const <int, Widget>{
                                      0: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: AbsText(
                                            displayString: "Sent",
                                            fontSize: 16,
                                            bold: true),
                                      ),
                                      1: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: AbsText(
                                            displayString: "Received",
                                            fontSize: 16,
                                            bold: true),
                                      ),
                                    },
                                    groupValue: _groupValue,
                                    onValueChanged: (int? value) {
                                      setState(() {
                                        _groupValue = value!;
                                      });
                                    },
                                    backgroundColor:
                                        Provider.of<ThemeProvider>(context)
                                            .mainColor,
                                    thumbColor:
                                        Provider.of<ThemeProvider>(context)
                                            .headColor,
                                    padding: const EdgeInsets.all(
                                        12), // Adjust padding around the thumb
                                  ),
                                ),
                              ],
                            ),
                            if (_groupValue == 0) ...[
                              const SizedBox(height: 10),
                              if (sent.isEmpty) ...[
                                // empty state handler
                              ] else ...[
                                for (int i = 0; i < sent.length; i++) ...[
                                  AbsRequestCard(
                                    userId: widget.userId,
                                    invitation: sent[i],
                                    isReceived: false,
                                    onWithdraw: () async {
                                      if (!mounted) return;
                                      setState(() {
                                        sent.removeAt(i);
                                      });
                                    },
                                    onAccept: () {},
                                    onReject: () {},
                                  ),
                                  const SizedBox(height: 6),
                                ]
                              ]
                            ] else ...[
                              const SizedBox(height: 10),
                              if (received.isEmpty) ...[
                                // empty state handler
                              ] else ...[
                                for (int i = 0; i < received.length; i++) ...[
                                  AbsRequestCard(
                                    userId: widget.userId,
                                    invitation: received[i],
                                    isReceived: true,
                                    onAccept: () async {
                                      if (!mounted) return;
                                      setState(() {
                                        received.removeAt(i);
                                      });
                                    },
                                    onReject: () async {
                                      if (!mounted) return;
                                      setState(() {
                                        received.removeAt(i);
                                      });
                                    },
                                    onWithdraw: () {},
                                  ),
                                  const SizedBox(height: 6),
                                ]
                              ]
                            ]
                          ],
                        ),
                      ),
                    ),
            )));
  }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:cotree_flutter/main.dart';

/// Compact, easier-to-read rewrite of the original RequestsPage.
/// Functionality preserved: shows Sent/Received, pull-to-refresh,
/// withdraw / accept / reject, swipe to act, and open profile.
class RequestsPage extends StatefulWidget {
  final int userId;
  final int index;

  const RequestsPage({
    Key? key,
    required this.userId,
    this.index = 0,
  }) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestRow {
  final UserView user;
  final dynamic entry;
  _RequestRow(this.user, this.entry);
}

class _RequestsPageState extends State<RequestsPage> {
  final List<_RequestRow> _sent = [];
  final List<_RequestRow> _received = [];
  int _selected = 0;
  bool _loading = true;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.index;
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    setState(() => _loading = true);
    try {
      final sentEntries = widget.connectData.sentPending ?? [];
      final recvEntries = widget.connectData.receivedPending ?? [];

      final sentFutures =
          sentEntries.map((e) => client.account.getUserView(e.user));
      final recvFutures =
          recvEntries.map((e) => client.account.getUserView(e.user));

      final sentUsers = await Future.wait(sentFutures);
      final recvUsers = await Future.wait(recvFutures);

      if (!mounted) return;
      _sent
        ..clear()
        ..addAll(List.generate(sentUsers.length,
            (i) => _RequestRow(sentUsers[i], sentEntries[i])));
      _received
        ..clear()
        ..addAll(List.generate(recvUsers.length,
            (i) => _RequestRow(recvUsers[i], recvEntries[i])));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load requests: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _refresh() async {
    setState(() => _refreshing = true);
    await _loadRequests();
    if (mounted) setState(() => _refreshing = false);
  }

  Future<void> _withdrawAt(int idx) async {
    final row = _sent[idx];
    try {
      await client.connection.withdrawConnection(widget.userId, row.entry);
      if (!mounted) return;
      setState(() => _sent.removeAt(idx));
      widget.connectData.sentPending?.remove(row.entry);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(displayString: 'Withdrawn request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not withdraw: $e')));
    }
  }

  Future<void> _acceptAt(int idx) async {
    final row = _received[idx];
    try {
      await client.connection
          .confirmConnection(sessionManager.signedInUser!.id, row.entry);
      if (!mounted) return;
      setState(() => _received.removeAt(idx));
      widget.connectData.receivedPending?.remove(row.entry);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(
                displayString: 'Accepted connection request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not accept: $e')));
    }
  }

  Future<void> _rejectAt(int idx) async {
    final row = _received[idx];
    try {
      await client.connection
          .rejectConnection(sessionManager.signedInUser!.id, row.entry);
      if (!mounted) return;
      setState(() => _received.removeAt(idx));
      widget.connectData.receivedPending?.remove(row.entry);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(
                displayString: 'Rejected connection request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not reject: $e')));
    }
  }

  void _openProfile(int id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ProfilePage(profileId: id)));
  }

  Widget _buildCard(_RequestRow row, Widget trailing, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AbsMinimalBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: (row.user.avatar.isNotEmpty)
                  ? CachedNetworkImageProvider(row.user.avatar)
                  : null,
              child: (row.user.avatar.isEmpty)
                  ? const Icon(Icons.person, color: Colors.white70)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsText(
                      displayString: row.user.name, fontSize: 15, bold: true),
                  if (row.user.headline.isNotEmpty)
                    AbsText(displayString: row.user.headline, fontSize: 12),
                  const SizedBox(height: 8),
                  Align(alignment: Alignment.centerLeft, child: trailing),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _empty(String label) => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 64.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.inbox, size: 56),
            const SizedBox(height: 12),
            AbsText(displayString: label, fontSize: 16)
          ]),
        ),
      );

  Widget _loadingList() => ListView.separated(
        itemCount: 6,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, __) => Container(
          height: 72,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Container(
                height: 44,
                width: 44,
                decoration: const BoxDecoration(
                    color: Colors.black12, shape: BoxShape.circle)),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(height: 12, width: 140, color: Colors.black12),
                  const SizedBox(height: 8),
                  Container(height: 10, width: 90, color: Colors.black12)
                ])),
            const SizedBox(width: 12),
            Container(height: 36, width: 88, color: Colors.black12),
          ]),
        ),
      );

  Widget _listFor(List<_RequestRow> rows, {required bool isSent}) {
    if (rows.isEmpty)
      return _empty(isSent ? 'No sent requests' : 'No received requests');

    return ListView.separated(
      itemCount: rows.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final row = rows[i];
        final tp = Provider.of<ThemeProvider>(context);

        final trailing = isSent
            ? OutlinedButton.icon(
                onPressed: () => _withdrawAt(i),
                icon: Icon(Icons.undo, color: tp.headColor, size: 18),
                label: const AbsText(displayString: 'Withdraw', fontSize: 14),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              )
            : Row(mainAxisSize: MainAxisSize.min, children: [
                ElevatedButton.icon(
                  onPressed: () => _acceptAt(i),
                  icon: Icon(Icons.check, color: tp.headColor, size: 18),
                  label: const AbsText(displayString: 'Accept', fontSize: 14),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => _rejectAt(i),
                  icon: Icon(Icons.close, color: tp.headColor, size: 18),
                  label: const AbsText(displayString: 'Ignore', fontSize: 14),
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ]);

        return Dismissible(
          key: ValueKey('req-${row.user.userId}-$i'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.blue.withOpacity(0.15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.swipe, size: 18),
                  SizedBox(width: 6),
                  Text('')
                ]),
          ),
          onDismissed: (_) => isSent ? _withdrawAt(i) : _acceptAt(i),
          child: _buildCard(row, trailing, () => _openProfile(row.user.userId)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context);
    final bg = tp.mainColor;

    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
            displayString: 'Manage Requests', fontSize: 16, bold: true),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: bg, borderRadius: BorderRadius.circular(12)),
              child: CupertinoSlidingSegmentedControl<int>(
                children: {
                  0: _segTab(Icons.send, 'Sent', _sent.length),
                  1: _segTab(Icons.inbox, 'Received', _received.length),
                },
                groupValue: _selected,
                onValueChanged: (v) => setState(() => _selected = v ?? 0),
                backgroundColor: bg,
                thumbColor: tp.headColor,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _loading
                    ? _loadingList()
                    : (_selected == 0
                        ? _listFor(_sent, isSent: true)
                        : _listFor(_received, isSent: false)),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _segTab(IconData icon, String label, int count) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          AbsText(displayString: label, fontSize: 15, bold: true),
          const SizedBox(width: 8),
          _countChip(count: count)
        ]),
      );

  Widget _countChip({required int count}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      child: AbsText(displayString: '$count', fontSize: 12));
}
*/
