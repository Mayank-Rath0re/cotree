import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/pages/profile_page_org.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsAccountBox extends StatefulWidget {
  final UserView profileUserView;
  final UserView myUserView;
  final String buttonText;
  final Function()? onPress;
  const AbsAccountBox(
      {super.key,
      required this.profileUserView,
      required this.myUserView,
      required this.buttonText,
      this.onPress});

  @override
  State<AbsAccountBox> createState() => _AbsAccountBoxState();
}

class _AbsAccountBoxState extends State<AbsAccountBox> {
  bool isSent = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            if (widget.profileUserView.accountType == "Individual") {
              return ProfilePage(
                profileId: widget.profileUserView.userId,
              );
            }
            return ProfilePageOrg(
                profileId: widget.profileUserView.userId,
                userview: widget.myUserView);
          }));
        },
        child: SizedBox(
            width: 150,
            child: AbsMinimalBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AbsAvatar(
                  radius: 30,
                  avatarUrl: widget.profileUserView.avatar,
                ),
                const SizedBox(height: 15),
                Text(
                  widget.profileUserView.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Provider.of<ThemeProvider>(context).contrastColor),
                ),
                AbsText(
                    displayString: widget.profileUserView.name,
                    fontSize: 14,
                    bold: true),
                const SizedBox(height: 6),
                Text(
                  widget.profileUserView.headline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 15,
                ),
                isSent
                    ? AbsButtonSecondary(
                        onPressed: () {},
                        text: "Sent",
                        icon: Icon(
                          FluentIcons.checkmark_16_filled,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                      )
                    : AbsButtonPrimary(
                        onPressed: () {
                          if (widget.buttonText == "Connect") {
                            setState(() {
                              isSent = true;
                            });
                          }
                          widget.onPress!();
                        },
                        text: widget.buttonText)
              ],
            ))));
  }
}
