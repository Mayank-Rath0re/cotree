import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_account_box.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_request_card.dart';
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
  late List<Invitation> sent = [];
  late List<Invitation> received = [];
  late UserView myUserView;
  late List<UserView> userData = [];
  late List<UserView> orgsData = [];
  bool isLoading = true;

  Future<void> getConnectData() async {
    sent = [];
    received = [];
    var user = await Constants().getOrSetUserView(context);

    var data = await client.connection.fetchInvitations(user.userId);
    List<UserView> listData =
        await client.recommendation.recommendUsers(user.userId, limit: 20);
    print("${listData.length} ${userData.length}");
    List<UserView> listOrgData = await client.account.getOrgs();
    if (!mounted) return; // safety against setState after dispose
    setState(() {
      myUserView = user;
      for (var element in data) {
        print("${element.sender} ${element.receiver}");
        if (element.sender == user.userId) {
          sent.add(element);
        } else {
          received.add(element);
        }
      }
      userData = listData;
      orgsData = listOrgData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Run after first frame to avoid dual-build issue
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getConnectData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Provider.of<ThemeProvider>(context).headColor,
      onRefresh: getConnectData,
      child: ListView(
        children: [
          if (isLoading) ...[
            Center(
                child: CircularProgressIndicator(
              color: Provider.of<ThemeProvider>(context).headColor,
            ))
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
                            initialIndex: 0,
                            userId: myUserView.userId,
                          ),
                        ),
                      ).then((_) async {
                        setState(() {
                          isLoading = true;
                        });
                        await getConnectData();
                      });
                    },
                    child: AbsMinimalBox(
                      child: AbsText(
                        displayString: "Sent (${sent.length})",
                        fontSize: 16,
                      ),
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
                            initialIndex: 1,
                            userId: myUserView.userId,
                          ),
                        ),
                      ).then((_) async {
                        setState(() {
                          isLoading = true;
                        });
                        await getConnectData();
                      });
                    },
                    child: AbsMinimalBox(
                      child: AbsText(
                        displayString: "Received (${received.length})",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (received.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: GestureDetector(
                    child: Row(
                  children: [
                    const AbsText(
                        displayString: 'Connection Requests',
                        fontSize: 13,
                        bold: true),
                    const Spacer(),
                    Row(
                      children: [
                        const AbsText(displayString: "See all", fontSize: 12),
                        const Icon(Icons.chevron_right, size: 16)
                      ],
                    )
                  ],
                )),
              ),
              const SizedBox(height: 6),
              AbsRequestCard(
                  key: ValueKey(received[0].id),
                  userId: myUserView.userId,
                  isReceived: true,
                  invitation: received[0],
                  onAccept: () {
                    if (!mounted) return;
                    setState(() {
                      received.remove(received[0]);
                    });
                  },
                  onReject: () {
                    if (!mounted) return;
                    setState(() {
                      received.remove(received[0]);
                    });
                  },
                  onWithdraw: () {}),
              const SizedBox(height: 8),
            ],
            const Divider(),
            const AbsText(
              displayString: "Fellow Coteries",
              fontSize: 16,
              bold: true,
            ),
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
                          headColor: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < userData.length; i++) ...[
                      AbsAccountBox(
                        key: ValueKey(userData[i].userId),
                        profileUserView: userData[i],
                        myUserView: myUserView,
                        buttonText: "Connect",
                        onPress: () async {
                          await client.connection.sendConnectionRequest(
                            myUserView.userId,
                            userData[i].userId,
                            "",
                          );
                          await getConnectData();
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
              displayString: "Organizations",
              fontSize: 16,
              bold: true,
            ),
            SizedBox(
              height: 230,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < orgsData.length; i++) ...[
                    AbsAccountBox(
                      profileUserView: orgsData[i],
                      myUserView: myUserView,
                      buttonText: "Follow",
                      onPress: () async {
                        await client.connection.followOrg(
                          myUserView.userId,
                          orgsData[i].userId,
                        );
                        await getConnectData();
                      },
                    ),
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
