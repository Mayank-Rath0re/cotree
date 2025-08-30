import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/add_members_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InviteToSpace extends StatefulWidget {
  final List<int> membersToInvite;
  const InviteToSpace({super.key, required this.membersToInvite});

  @override
  State<InviteToSpace> createState() => _InviteToSpaceState();
}

class _InviteToSpaceState extends State<InviteToSpace> {
  late UserView userview;
  late List<Space> userSpaces;
  late List<UserView> inviteViews;
  bool isLoading = true;
  int scaffoldIndex = 0;

  void getBuildData() async {
    List<UserView> memberViews = [];
    final userCache = context.read<UserCacheService>();
    // Get or set user
    final user = await userCache.getOrSetUserView(context);

    var spaces = await client.space.fetchSpacesByUser(user.userId);
    for (int i = 0; i < widget.membersToInvite.length; i++) {
      var view = await client.account.getUserView(widget.membersToInvite[i]);
      memberViews.add(view);
    }
    setState(() {
      userview = user;
      userSpaces = spaces;
      inviteViews = memberViews;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  Widget spaceBuild(Space spaceData) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddMembersPage(
                        spaceId: spaceData.id!,
                        membersToAdd: inviteViews,
                      )));
        },
        child: SizedBox(
            height: 150,
            width: 120,
            child: AbsMinimalBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AbsAvatar(
                  radius: 30,
                  avatarUrl: spaceData.avatar,
                ),
                const SizedBox(height: 15),
                AbsText(displayString: spaceData.title, fontSize: 14),
              ],
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AbsText(
            displayString: "Inviting to Space",
            fontSize: 16,
            bold: true,
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AbsText(
                        displayString: "Selected Users",
                        fontSize: 16,
                        bold: true,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int i = 0; i < inviteViews.length; i++) ...[
                              AbsMinimalBox(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AbsAvatar(
                                    radius: 30,
                                    avatarUrl: inviteViews[i].avatar,
                                  ),
                                  const SizedBox(height: 15),
                                  AbsText(
                                      displayString: inviteViews[i].name,
                                      fontSize: 14),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AbsButtonSecondary(
                                      onPressed: () {
                                        setState(() {
                                          inviteViews.removeAt(i);
                                        });
                                        if (inviteViews.isEmpty) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      text: "Remove")
                                ],
                              )),
                              const SizedBox(width: 8),
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "Available Spaces",
                          fontSize: 16,
                          bold: true),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: [
                          for (int i = 0; i < userSpaces.length; i++) ...[
                            spaceBuild(userSpaces[i])
                          ],
                          GestureDetector(
                              onTap: () {
                                // Creating new space functionality
                                // then coming back here
                              },
                              child: SizedBox(
                                  height: 150,
                                  width: 120,
                                  child: AbsMinimalBox(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        size: 50,
                                      ),
                                      const SizedBox(height: 30),
                                      AbsText(
                                          displayString: "Create New",
                                          fontSize: 15,
                                          bold: true),
                                    ],
                                  ))))
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }
}
