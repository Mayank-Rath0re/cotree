import 'package:cached_network_image/cached_network_image.dart';
import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';

class RequestsPage extends StatefulWidget {
  final int userId;
  final Connect connectData;
  final int index;
  const RequestsPage({
    super.key,
    required this.userId,
    required this.connectData,
    required this.index,
  });

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestRow {
  final UserView user;
  final dynamic entry; // underlying connect entry from connectData.*Pending
  _RequestRow(this.user, this.entry);
}

class _RequestsPageState extends State<RequestsPage>
    with SingleTickerProviderStateMixin {
  List<_RequestRow> _sentRows = [];
  List<_RequestRow> _receivedRows = [];
  int selectedIndex = 0;
  bool isLoading = true;
  // ignore: unused_field
  bool _refreshing = false;

  Future<void> getUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      final sentEntries = widget.connectData.sentPending ?? [];
      final receivedEntries = widget.connectData.receivedPending ?? [];

      final sentFutures =
          sentEntries.map((e) => client.account.getUserView(e.user)).toList();
      final receivedFutures = receivedEntries
          .map((e) => client.account.getUserView(e.user))
          .toList();

      final sentUsers = await Future.wait(sentFutures);
      final receivedUsers = await Future.wait(receivedFutures);

      if (!mounted) return;
      setState(() {
        _sentRows = List.generate(
          sentUsers.length,
          (i) => _RequestRow(sentUsers[i], sentEntries[i]),
        );
        _receivedRows = List.generate(
          receivedUsers.length,
          (i) => _RequestRow(receivedUsers[i], receivedEntries[i]),
        );
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load requests: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
    getUser();
  }

  Future<void> _onRefresh() async {
    setState(() => _refreshing = true);
    await getUser();
    if (!mounted) return;
    setState(() => _refreshing = false);
  }

  Future<void> _withdraw(int index) async {
    final row = _sentRows[index];
    try {
      await client.connection.withdrawConnection(widget.userId, row.entry);
      if (!mounted) return;
      setState(() {
        _sentRows.removeAt(index);
        widget.connectData.sentPending?.remove(row.entry);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(displayString: 'Withdrawn request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not withdraw: $e')),
      );
    }
  }

  Future<void> _accept(int index) async {
    final row = _receivedRows[index];
    try {
      await client.connection.confirmConnection(
        sessionManager.signedInUser!.id,
        row.entry,
      );
      if (!mounted) return;
      setState(() {
        _receivedRows.removeAt(index);
        widget.connectData.receivedPending?.remove(row.entry);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(
                displayString: 'Accepted connection request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not accept: $e')),
      );
    }
  }

  Future<void> _reject(int index) async {
    final row = _receivedRows[index];
    try {
      await client.connection.rejectConnection(
        sessionManager.signedInUser!.id,
        row.entry,
      );
      if (!mounted) return;
      setState(() {
        _receivedRows.removeAt(index);
        widget.connectData.receivedPending?.remove(row.entry);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: AbsText(
                displayString: 'Rejected connection request', fontSize: 16)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not reject: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context);
    final bg = tp.mainColor;

    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
          displayString: 'Manage Requests',
          fontSize: 16,
          bold: true,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CupertinoSlidingSegmentedControl<int>(
                  children: <int, Widget>{
                    0: _SegmentTab(
                      icon: HeroIcons.arrowUpOnSquare,
                      label: 'Sent',
                      count: _sentRows.length,
                    ),
                    1: _SegmentTab(
                      icon: HeroIcons.arrowDownOnSquare,
                      label: 'Received',
                      count: _receivedRows.length,
                    ),
                  },
                  groupValue: selectedIndex,
                  onValueChanged: (int? v) =>
                      setState(() => selectedIndex = v ?? 0),
                  backgroundColor: bg,
                  thumbColor: tp.headColor,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: isLoading
                      ? const _LoadingList()
                      : selectedIndex == 0
                          ? _RequestsList(
                              key: const PageStorageKey('requests-sent'),
                              rows: _sentRows,
                              emptyLabel: 'No sent requests',
                              actionBuilder: (ctx, index) => _WithdrawButton(
                                onPressed: () => _withdraw(index),
                              ),
                              onTapUser: (i) =>
                                  _openProfile(_sentRows[i].user.userId),
                              onDismissed: (i) => _withdraw(i),
                              dismissLabel: 'Withdraw',
                            )
                          : _RequestsList(
                              key: const PageStorageKey('requests-received'),
                              rows: _receivedRows,
                              emptyLabel: 'No received requests',
                              actionBuilder: (ctx, index) =>
                                  _AcceptRejectButtons(
                                onAccept: () => _accept(index),
                                onReject: () => _reject(index),
                              ),
                              onTapUser: (i) =>
                                  _openProfile(_receivedRows[i].user.userId),
                              onDismissed: (i) => _accept(i),
                              // swipe to accept as a shortcut
                              dismissLabel: 'Accept',
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openProfile(int userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(profileId: userId),
      ),
    );
  }
}

/// ----------------------- Widgets -----------------------

class _SegmentTab extends StatelessWidget {
  final HeroIcons icon;
  final String label;
  final int count;
  const _SegmentTab({
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeroIcon(icon, size: 18),
          const SizedBox(width: 6),
          AbsText(displayString: label, fontSize: 15, bold: true),
          const SizedBox(width: 8),
          _CountChip(count: count),
        ],
      ),
    );
  }
}

class _CountChip extends StatelessWidget {
  final int count;
  const _CountChip({required this.count});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: AbsText(displayString: '$count', fontSize: 12),
    );
  }
}

class _RequestsList extends StatelessWidget {
  final List<_RequestRow> rows;
  final String emptyLabel;
  final Widget Function(BuildContext, int) actionBuilder;
  final void Function(int index) onTapUser;
  final Future<void> Function(int index) onDismissed;
  final String dismissLabel;

  const _RequestsList({
    super.key,
    required this.rows,
    required this.emptyLabel,
    required this.actionBuilder,
    required this.onTapUser,
    required this.onDismissed,
    required this.dismissLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return _EmptyState(label: emptyLabel);
    }

    return ListView.separated(
      itemCount: rows.length,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final row = rows[index];
        return Dismissible(
          key: ValueKey('req-${row.user.userId}-$index'),
          direction: DismissDirection.endToStart,
          background: _DismissBg(label: dismissLabel, alignEnd: true),
          onDismissed: (_) => onDismissed(index),
          child: _RequestCard(
            user: row.user,
            onTap: () => onTapUser(index),
            trailing: actionBuilder(context, index),
          ),
        );
      },
    );
  }
}

class _DismissBg extends StatelessWidget {
  final String label;
  final bool alignEnd;
  const _DismissBg({required this.label, this.alignEnd = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.blue.withOpacity(0.15),
      child: Row(
        mainAxisAlignment:
            alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          const Icon(Icons.swipe, size: 18),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final UserView user;
  final VoidCallback onTap;
  final Widget trailing;
  const _RequestCard(
      {required this.user, required this.onTap, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(profileId: user.userId)));
        },
        child: AbsMinimalBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: (user.avatar.isNotEmpty)
                    ? CachedNetworkImageProvider(user.avatar)
                    : null,
                child: (user.avatar.isEmpty)
                    ? const Icon(Icons.person, color: Colors.white70)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AbsText(displayString: user.name, fontSize: 15, bold: true),
                    if ((user.headline).isNotEmpty)
                      AbsText(displayString: user.headline, fontSize: 12),
                    trailing,
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _WithdrawButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _WithdrawButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.undo,
          color: Provider.of<ThemeProvider>(context).headColor, size: 18),
      label: const AbsText(displayString: "Withdraw", fontSize: 14),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 36),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _AcceptRejectButtons extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;
  const _AcceptRejectButtons({required this.onAccept, required this.onReject});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: onAccept,
          icon: Icon(Icons.check,
              color: Provider.of<ThemeProvider>(context).headColor, size: 18),
          label: const AbsText(displayString: "Accept", fontSize: 14),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 36),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: onReject,
          icon: Icon(Icons.close,
              color: Provider.of<ThemeProvider>(context).headColor, size: 18),
          label: const AbsText(displayString: "Ignore", fontSize: 14),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 36),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String label;
  const _EmptyState({required this.label});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 64.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox, size: 56),
            const SizedBox(height: 12),
            AbsText(displayString: label, fontSize: 16),
          ],
        ),
      ),
    );
  }
}

class _LoadingList extends StatelessWidget {
  const _LoadingList();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return Container(
          height: 72,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 12, width: 140, color: Colors.black12),
                    const SizedBox(height: 8),
                    Container(height: 10, width: 90, color: Colors.black12),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(height: 36, width: 88, color: Colors.black12),
            ],
          ),
        );
      },
    );
  }
}
