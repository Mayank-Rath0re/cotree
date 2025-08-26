import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_bottom_nav.dart';
import 'package:cotree_flutter/components/abs_drawer.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/chat_page.dart';
import 'package:cotree_flutter/pages/create_post_page.dart';
import 'package:cotree_flutter/pages/feed_page.dart';
import 'package:cotree_flutter/pages/network_page.dart';
import 'package:cotree_flutter/pages/notifications_page.dart';
import 'package:cotree_flutter/pages/post_offer_page.dart';
import 'package:cotree_flutter/pages/work_notify_page.dart';
import 'package:cotree_flutter/pages/work_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  int selectedPageIndex;
  HomePage({super.key, this.selectedPageIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserView user;
  late bool newSpaceInvites;
  late bool newNotifications;
  bool isLoading = true;

  Future<void> getUserData() async {
    var userInfo = await Constants().getOrSetUserView(context);
    var checkInvites = await client.space.unreadInvites(userInfo.userId);
    var checkNotifications =
        await client.notification.anyUnreadNotifications(userInfo.userId);
    setState(() {
      user = userInfo;
      newSpaceInvites = checkInvites;
      newNotifications = checkNotifications;
      isLoading = false;
    });
  }

  void navigateBottomBar(int index) {
    setState(() {
      widget.selectedPageIndex = index;
    });
  }

  Future<bool> checkNewSpaceInvites() async {
    var check = await client.space.unreadInvites(user.userId);
    return check;
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  /// Dynamically generates bar actions to avoid accessing `user` before initialization
  List<Widget> getBarActions(BuildContext context) {
    if (isLoading) return [];

    return [
      // Home Page AppBar actions
      if (widget.selectedPageIndex == 0) ...[
        IconButton(
          onPressed: () {
            setState(() {
              newNotifications = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsPage(userview: user)));
          },
          icon: newNotifications
              ? Icon(Icons.notifications,
                  color: Provider.of<ThemeProvider>(context).headColor)
              : const Icon(Icons.notifications_outlined),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePostPage(),
            ),
          ),
          icon: const Icon(Icons.add_box_outlined),
        ),
        const SizedBox(width: 14),
        const SizedBox(width: 14),
      ],
      /*
      // Network Page AppBar actions
      if (widget.selectedPageIndex == 1) ...[
        IconButton(
          onPressed: () {},
          icon: newNotifications
              ? Icon(Icons.notifications,
                  color: Provider.of<ThemeProvider>(context).headColor)
              : const Icon(Icons.notifications_outlined),
        ),
        const SizedBox(width: 14),
      ],*/
      // Work Page AppBar actions
      if (widget.selectedPageIndex == 2) ...[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PostOfferPage(),
              ),
            );
          },
          icon: const Icon(Icons.add_box_outlined),
        ),
        const SizedBox(width: 14),
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WorkNotifyPage()));
          },
          icon: newSpaceInvites
              ? Icon(Icons.notifications,
                  color: Provider.of<ThemeProvider>(context).headColor)
              : const Icon(Icons.notifications_outlined),
        ),
        const SizedBox(width: 14),
      ],
      // Chat Page AppBar actions
      if (widget.selectedPageIndex == 3) ...[],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> pages = isLoading
        ? []
        : const [
            FeedPage(),
            NetworkPage(),
            WorkPage(),
            ChatPage(),
          ];
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            title: Image.asset(
              "assets/cotree_logo.png",
              fit: BoxFit.contain,
              height: 50,
              color: Provider.of<ThemeProvider>(context).contrastColor,
            ),
            centerTitle: true,
            actions: getBarActions(context), // Dynamically generate actions
          ),
        ),
        drawer: isLoading
            ? null
            : AbsDrawer(
                userInfo: user,
              ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : pages[widget.selectedPageIndex],
        ),
        bottomNavigationBar: AbsBottomNav(
          selectedIndex: widget.selectedPageIndex,
          onTabChange: (index) => navigateBottomBar(index),
        ));
  }
}
