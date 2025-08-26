import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/pages/profile_page_org.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsAccountBox extends StatefulWidget {
  final int accountId;
  final UserView myUserView;
  final String buttonText;
  final Function()? onPress;
  const AbsAccountBox(
      {super.key,
      required this.accountId,
      required this.myUserView,
      required this.buttonText,
      this.onPress});

  @override
  State<AbsAccountBox> createState() => _AbsAccountBoxState();
}

class _AbsAccountBoxState extends State<AbsAccountBox> {
  late UserView userData;
  bool isLoading = true;
  bool isSent = false;
  Future<void> getUserView() async {
    var userInfo = await client.account.getUserView(widget.accountId);
    setState(() {
      userData = userInfo;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            constraints: const BoxConstraints(
                minWidth: 150, minHeight: 200, maxWidth: 150, maxHeight: 230),
          )
        : GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if (userData.accountType == "Individual") {
                  return ProfilePage(
                    profileId: widget.accountId,
                  );
                }
                return ProfilePageOrg(
                    profileId: widget.accountId, userview: widget.myUserView);
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
                      avatarUrl: userData.avatar,
                    ),
                    const SizedBox(height: 15),
                    AbsText(
                        displayString: userData.name, fontSize: 14, bold: true),
                    const SizedBox(height: 6),
                    Text(
                      userData.headline,
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
                              Icons.check_circle_outline,
                              color:
                                  Provider.of<ThemeProvider>(context).headColor,
                            ),
                          )
                        : AbsButtonPrimary(
                            onPressed: () {
                              if (widget.buttonText == "Connect") {
                                client.connection.sendConnectionRequest(
                                    sessionManager.signedInUser!.id,
                                    userData.userId,
                                    "");
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
