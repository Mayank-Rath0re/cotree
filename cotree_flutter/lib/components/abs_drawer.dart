import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/pages/profile_page_org.dart';
import 'package:cotree_flutter/pages/settings_page.dart';
import 'package:cotree_flutter/pages/space_land_page.dart';
import 'package:flutter/material.dart';

class AbsDrawer extends StatefulWidget {
  final UserView userInfo;
  const AbsDrawer({super.key, required this.userInfo});

  @override
  State<AbsDrawer> createState() => _AbsDrawerState();
}

class _AbsDrawerState extends State<AbsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 45,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AbsAvatar(
                  radius: 50,
                  avatarUrl: widget.userInfo.avatar,
                ),
                const SizedBox(height: 10),
                IconButton(
                    onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          if (widget.userInfo.accountType == "Individual") {
                            return ProfilePage(
                              profileId: widget.userInfo.userId,
                            );
                          }
                          return ProfilePageOrg(
                              profileId: widget.userInfo.userId,
                              userview: widget.userInfo);
                        })),
                    icon: AbsText(
                        displayString: widget.userInfo.name,
                        fontSize: 20,
                        headColor: true)),
                if (widget.userInfo.headline.isNotEmpty) ...[
                  AbsText(
                    displayString: widget.userInfo.headline,
                    fontSize: 14,
                    align: true,
                  )
                ]
              ],
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.workspace_premium_outlined),
              title: const AbsText(
                displayString: "Switch to Workspace",
                fontSize: 16,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpaceLandPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const AbsText(
                displayString: "Settings",
                fontSize: 16,
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage())),
            ),
            /*
            ListTile(
              leading: const Icon(Icons.monetization_on_outlined),
              title: const AbsText(
                displayString: "Upgrade plan",
                fontSize: 16,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpgradePricingPage(),
                ),
              ),
            ),*/
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const AbsText(
                displayString: "Logout",
                fontSize: 16,
              ),
              onTap: () async {
                await Constants().clearUserView(context);
                await sessionManager.signOutDevice();
              },
            ),
            const SizedBox(height: 25)
          ],
        ));
  }
}
