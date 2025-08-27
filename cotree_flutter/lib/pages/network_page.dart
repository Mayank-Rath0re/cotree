import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_account_box.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/requests_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  late Connect userConnectData;
  late UserView myUserView;
  late List<UserView> userData;
  late List<UserView> orgsData;
  bool isLoading = true;

  Future<void> getConnectData() async {
    var user = await Constants().getOrSetUserView(context);
    Connect data = await client.connection
        .fetchConnectData(sessionManager.signedInUser!.id);
    List<UserView> listData =
        await client.recommendation.recommendUsers(user.userId, limit: 20);
    List<UserView> listOrgData = await client.account.getOrgs();
    setState(() {
      myUserView = user;
      userConnectData = data;
      userData = listData;
      orgsData = listOrgData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getConnectData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Provider.of<ThemeProvider>(context).headColor,
      onRefresh: () async {
        await getConnectData();
      },
      child: ListView(
        children: [
          if (isLoading) ...[
            const Center(child: CircularProgressIndicator())
          ] else ...[
            const AbsText(
              displayString: "Invitations",
              fontSize: 16,
              headColor: true,
              bold: true,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestsPage(
                                    connectData: userConnectData,
                                    index: 0,
                                    userId: myUserView.userId,
                                  )));
                    },
                    child: AbsMinimalBox(
                      child: AbsText(
                          displayString:
                              "Sent (${userConnectData.sentPending!.length})",
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestsPage(
                                    connectData: userConnectData,
                                    index: 1,
                                    userId: myUserView.userId,
                                  )));
                    },
                    child: AbsMinimalBox(
                        child: AbsText(
                            displayString:
                                "Received (${userConnectData.receivedPending!.length})",
                            fontSize: 16)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            const AbsText(
                displayString: "Fellow Coteries", fontSize: 16, bold: true),
            const SizedBox(height: 15),
            if (userData.isEmpty) ...[
              SizedBox(
                  height: 200,
                  child: AbsMinimalBox(
                      child: Center(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.new_label, size: 50),
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "No new users to show",
                          fontSize: 16,
                          bold: true,
                          headColor: true)
                    ],
                  )))),
            ] else ...[
              SizedBox(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < userData.length; i++) ...[
                      AbsAccountBox(
                        accountId: userData[i].userId,
                        myUserView: myUserView,
                        buttonText: "Connect",
                        onPress: () {
                          setState(() {
                            userConnectData.sentPending!.add(Invitation(
                                user: userData[i].userId, type: 'Sent'));
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                  ],
                ),
              ),
            ],
            const SizedBox(height: 15),
            const Divider(),
            const AbsText(
                displayString: "Organizations", fontSize: 16, bold: true),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < orgsData.length; i++) ...[
                    AbsAccountBox(
                        accountId: orgsData[i].userId,
                        myUserView: myUserView,
                        buttonText: "Follow"),
                    const SizedBox(width: 10),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
