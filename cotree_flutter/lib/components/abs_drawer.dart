import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/pages/profile_page_org.dart';
import 'package:cotree_flutter/pages/settings_page.dart';
import 'package:cotree_flutter/pages/space_land_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsDrawer extends StatefulWidget {
  final UserView userInfo;
  const AbsDrawer({super.key, required this.userInfo});

  @override
  State<AbsDrawer> createState() => _AbsDrawerState();
}

class _AbsDrawerState extends State<AbsDrawer> {
  bool isLoggingOut = false;
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
            GestureDetector(
                onTap: () => Navigator.push(context,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AbsAvatar(
                      radius: 50,
                      avatarUrl: widget.userInfo.avatar,
                    ),
                    const SizedBox(height: 10),
                    AbsText(
                        displayString: widget.userInfo.name,
                        fontSize: 20,
                        headColor: true),
                    if (widget.userInfo.headline.isNotEmpty) ...[
                      AbsText(
                        displayString: widget.userInfo.headline,
                        fontSize: 14,
                        align: true,
                      )
                    ]
                  ],
                )),
            const Divider(),
            ListTile(
              leading: const Icon(FluentIcons.cube_20_filled),
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
              leading: const Icon(FluentIcons.settings_20_filled),
              title: const AbsText(
                displayString: "Settings",
                fontSize: 16,
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(
                            userview: widget.userInfo,
                          ))),
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
              leading: const Icon(FluentIcons.arrow_exit_20_regular),
              title: const AbsText(
                displayString: "Logout",
                fontSize: 16,
              ),
              onTap: () async {
                if (!isLoggingOut) {
                  setState(() {
                    isLoggingOut = true;
                  });
                  Navigator.pop(context);

                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  color: Provider.of<ThemeProvider>(context)
                                      .headColor,
                                ),
                                const SizedBox(height: 20),
                                AbsText(
                                  displayString: "Logging out...",
                                  fontSize: 16,
                                  headColor: true,
                                )
                              ],
                            ),
                          ));
                  await sessionManager.signOutDevice();
                  await Constants().clearUserView(context);
                }
              },
            ),
            const SizedBox(height: 25)
          ],
        ));
  }
}
