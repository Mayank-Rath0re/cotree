import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  final UserView userview;
  const NotificationsPage({super.key, required this.userview});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotifItem {
  final Notification notif;
  final UserView user;
  _NotifItem({required this.notif, required this.user});
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<_NotifItem> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getBuildData();
  }

  Future<void> getBuildData() async {
    setState(() => isLoading = true);
    try {
      final fetched = await client.notification
          .fetchUserNotifications(widget.userview.userId);

      // Mark them read in the backend (but don't mutate local objects)
      client.notification.markRead(fetched);

      final loaded = await Future.wait(fetched.map((n) async {
        final u = await client.account.getUserView(n.referencedUser);
        return _NotifItem(notif: n, user: u);
      }));

      // Sort so that "new" stays on top, then by time
      loaded.sort((a, b) {
        if (a.notif.unread && !b.notif.unread) return -1;
        if (!a.notif.unread && b.notif.unread) return 1;
        return b.notif.triggeredAt.compareTo(a.notif.triggeredAt);
      });

      setState(() {
        items = loaded;
        isLoading = false;
      });
    } catch (_) {
      setState(() {
        items = [];
        isLoading = false;
      });
    }
  }

  List<_NotifItem> get unreadItems =>
      items.where((i) => i.notif.unread == true).toList();
  List<_NotifItem> get readItems =>
      items.where((i) => i.notif.unread == false).toList();

  Future<void> _markAsRead(_NotifItem item) async {
    try {
      await client.notification.markRead([item.notif]);
      setState(() => item.notif.unread = false);
    } catch (_) {}
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: AbsText(
            displayString: "You're all caught up!", fontSize: 16, bold: true),
      ),
    );
  }

  Widget _notificationTile(_NotifItem item) {
    final notif = item.notif;
    final user = item.user;

    return AbsMinimalBox(
      layer: notif.unread ? 3 : 1,
      child: InkWell(
        onTap: () => _markAsRead(item),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              AbsAvatar(radius: 26, avatarUrl: user.avatar),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AbsText(
                              displayString: user.name,
                              fontSize: 14,
                              bold: true),
                        ),
                        Row(
                          children: [
                            AbsText(
                                displayString:
                                    GetTimeAgo.parse(notif.triggeredAt),
                                fontSize: 12),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    AbsText(displayString: notif.content, fontSize: 13),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
            displayString: 'Notifications', fontSize: 16, bold: true),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              color: Provider.of<ThemeProvider>(context).headColor,
              onRefresh: getBuildData,
              child: items.isEmpty
                  ? ListView(children: [_buildEmptyState()])
                  : ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        if (unreadItems.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: AbsText(
                                displayString: 'New', fontSize: 13, bold: true),
                          ),
                          for (var it in unreadItems) ...[
                            _notificationTile(it),
                            const SizedBox(height: 8),
                          ]
                        ],
                        if (readItems.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: AbsText(
                                displayString: 'Earlier',
                                fontSize: 13,
                                bold: true),
                          ),
                          for (var it in readItems) ...[
                            _notificationTile(it),
                            const SizedBox(height: 8),
                          ]
                        ]
                      ],
                    ),
            ),
    );
  }
}
