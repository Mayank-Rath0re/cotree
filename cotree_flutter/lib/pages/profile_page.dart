import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_feedpost.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_profile_tile.dart';
import 'package:cotree_flutter/components/abs_red_button.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/pages/add_profile_info.dart';
import 'package:cotree_flutter/pages/dm_page.dart';
import 'package:cotree_flutter/pages/invite_to_space.dart';
import 'package:cotree_flutter/pages/profile_edit_page.dart';
import 'package:cotree_flutter/pages/see_all_posts.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  final int? profileId;
  const ProfilePage({super.key, required this.profileId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserView myUserview;
  late UserView userData;
  late Individual profileData;
  late int profileViewType;
  late Post? userPosts;
  late int connectionsCount;
  late int spaceCount;
  late bool isMyAccount;
  List<ProfessionalData> academics = [];
  List<ProfessionalData> experience = [];
  List<ProfessionalData> projects = [];
  List<ProfessionalData> certifications = [];
  bool isLoading = true;

  Future<void> getProfileData() async {
    var user = await Constants().getOrSetUserView(context);
    Individual accountData =
        await client.account.getIndividualData(widget.profileId);
    UserView userDetails = await client.account.getUserView(widget.profileId);
    var profData =
        await client.account.fetchUserProfessionalData(widget.profileId!);
    int connectInfo =
        await client.account.fetchUserConnectionCount(widget.profileId!);
    int totalSpaces =
        await client.account.fetchUserSpaceCount(widget.profileId!);
    Post? posts = await client.post.fetchLastUserPost(widget.profileId!);
    int viewType =
        await client.connection.isConnection(user.userId, widget.profileId!);

    setState(() {
      myUserview = user;
      userData = userDetails;
      profileData = accountData;
      profileViewType = viewType;
      userPosts = posts;
      connectionsCount = connectInfo;
      spaceCount = totalSpaces;
      academics = profData.where((t) => t.type == "Education").toList();
      experience = profData.where((t) => t.type == "Experience").toList();
      projects = profData.where((t) => t.type == "Project").toList();
      certifications =
          profData.where((t) => t.type == "Certification").toList();
      isMyAccount = widget.profileId! == user.userId;
      isLoading = false;
    });
  }

  Future<int> isConnected() async {
    var viewType = await client.connection
        .isConnection(myUserview.userId, widget.profileId!);
    return viewType;
  }

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: isLoading
            ? AppBar()
            : AppBar(
                toolbarHeight: 50,
                leading: GestureDetector(
                    child: const Icon(Icons.arrow_back_ios_new_outlined),
                    onTap: () => Navigator.pop(context)),
                actions: isMyAccount
                    ? [
                        IconButton(
                            onPressed: () async {
                              print("Here to push to edit page");
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileEditPage(
                                          userView: myUserview,
                                          individualData: profileData)));
                              if (result == "saved") {
                                setState(() {
                                  isLoading = true;
                                });
                                getProfileData();
                              }
                            },
                            icon: const Icon(Icons.edit)),
                        const SizedBox(width: 15),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddProfileInfo(
                                          profileId: widget.profileId!)));
                            },
                            icon: const Icon(Icons.add)),
                        const SizedBox(width: 15),
                      ]
                    : [],
              ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.zero,
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pop(context), // close on tap
                                child: InteractiveViewer(
                                  // allows pinch-to-zoom
                                  child: Center(
                                    child: Image.network(userData.avatar),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Center(
                            child: AbsAvatar(
                                radius: 45, avatarUrl: userData.avatar)),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              AbsText(
                                  displayString: userData.name,
                                  fontSize: 22,
                                  headColor: true,
                                  bold: true),
                              const SizedBox(height: 5),
                              AbsText(
                                  displayString: userData.headline,
                                  fontSize: 16),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AbsMinimalBox(
                              roundedBorder: true,
                              child: Row(children: [
                                AbsText(
                                  displayString: "$connectionsCount",
                                  fontSize: 16,
                                  headColor: true,
                                ),
                                const AbsText(
                                    displayString: "  Connections",
                                    fontSize: 16)
                              ])),
                          AbsMinimalBox(
                              roundedBorder: true,
                              child: Row(children: [
                                AbsText(
                                  displayString: "$spaceCount",
                                  fontSize: 16,
                                  headColor: true,
                                ),
                                const AbsText(
                                    displayString: "  Spaces Owned",
                                    fontSize: 16)
                              ])),
                        ],
                      ),
                      if (widget.profileId != myUserview.userId) ...[
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (profileViewType == 0) ...[
                              GestureDetector(
                                  onTap: () async {
                                    await client.connection
                                        .sendConnectionRequest(
                                            myUserview.userId,
                                            widget.profileId!,
                                            "");
                                    setState(() {
                                      profileViewType = 2;
                                    });
                                  },
                                  child: AbsMinimalBox(
                                      roundedBorder: true,
                                      child: Row(children: [
                                        Icon(Icons.handshake,
                                            color: Provider.of<ThemeProvider>(
                                                    context)
                                                .headColor),
                                        const AbsText(
                                            displayString: "  Connect",
                                            fontSize: 16)
                                      ]))),
                            ] else if (profileViewType == 1) ...[
                              GestureDetector(
                                  onTap: () async {
                                    var chatData = await client.chat
                                        .getOrCreateChat(myUserview.userId,
                                            widget.profileId!);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DmPage(
                                                chat: chatData,
                                                userId: widget.profileId!,
                                                user: myUserview)));
                                  },
                                  child: AbsMinimalBox(
                                      roundedBorder: true,
                                      child: Row(children: [
                                        Icon(Icons.send_rounded,
                                            color: Provider.of<ThemeProvider>(
                                                    context)
                                                .headColor),
                                        const AbsText(
                                            displayString: "  Message",
                                            fontSize: 16)
                                      ]))),
                              GestureDetector(
                                onTap: () {
                                  print("Tapping this");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InviteToSpace(
                                                  membersToInvite: [
                                                    widget.profileId!
                                                  ])));
                                },
                                child: AbsMinimalBox(
                                    roundedBorder: true,
                                    child: Row(children: [
                                      Icon(Icons.join_full,
                                          color: Provider.of<ThemeProvider>(
                                                  context)
                                              .headColor),
                                      const AbsText(
                                          displayString: "  Invite to Space",
                                          fontSize: 16)
                                    ])),
                              ),
                              PopupMenuButton(
                                  color: Provider.of<ThemeProvider>(context)
                                      .mainColor,
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                            onTap: () async {
                                              var result = await showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const AbsText(
                                                                displayString:
                                                                    "Remove Connection?",
                                                                fontSize: 15,
                                                                bold: true),
                                                            const SizedBox(
                                                                height: 10),
                                                          ],
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const AbsText(
                                                                  displayString:
                                                                      "Cancel",
                                                                  fontSize:
                                                                      13)),
                                                          AbsRedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    true);
                                                              },
                                                              text: "Remove")
                                                        ],
                                                      ));
                                              if (result == true) {
                                                // remove connection
                                                client.connection
                                                    .removeConnection(
                                                        myUserview.userId,
                                                        widget.profileId!);
                                                // set state
                                                setState(() {
                                                  profileViewType = 0;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: const AbsText(
                                                            displayString:
                                                                "Removed Connection",
                                                            fontSize: 16,
                                                            bold: true)));
                                              }
                                            },
                                            child: const AbsText(
                                                displayString:
                                                    "Remove Connection",
                                                fontSize: 14))
                                      ])
                            ] else if (profileViewType == 2) ...[
                              AbsMinimalBox(
                                  roundedBorder: true,
                                  child: Row(children: [
                                    Icon(Icons.pending,
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                .headColor),
                                    const AbsText(
                                        displayString: "  Pending",
                                        fontSize: 16)
                                  ])),
                            ] else if (profileViewType == 3) ...[
                              GestureDetector(
                                  onTap: () async {
                                    var inviteData = await client.connection
                                        .getInviteData(myUserview.userId,
                                            widget.profileId!);
                                    if (inviteData != null) {
                                      client.connection.confirmConnection(
                                          myUserview.userId, inviteData);
                                      setState(() {
                                        profileViewType = 1;
                                      });
                                    }
                                  },
                                  child: AbsMinimalBox(
                                      roundedBorder: true,
                                      child: Row(children: [
                                        Icon(Icons.check,
                                            color: Provider.of<ThemeProvider>(
                                                    context)
                                                .headColor),
                                        const AbsText(
                                            displayString: "  Accept",
                                            fontSize: 16)
                                      ]))),
                              GestureDetector(
                                  onTap: () async {
                                    var inviteData = await client.connection
                                        .getInviteData(myUserview.userId,
                                            widget.profileId!);
                                    if (inviteData != null) {
                                      client.connection.rejectConnection(
                                          myUserview.userId, inviteData);
                                      setState(() {
                                        profileViewType = 0;
                                      });
                                    }
                                  },
                                  child: AbsMinimalBox(
                                      roundedBorder: true,
                                      child: Row(children: [
                                        Icon(Icons.close,
                                            color: Provider.of<ThemeProvider>(
                                                    context)
                                                .headColor),
                                        const AbsText(
                                            displayString: "  Reject",
                                            fontSize: 16)
                                      ]))),
                            ],
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "About me",
                          fontSize: 16,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 10),
                      AbsText(displayString: profileData.bio, fontSize: 13),
                      const SizedBox(height: 20),
                      if (userPosts != null) ...[
                        const AbsText(
                            displayString: "Posts",
                            fontSize: 16,
                            headColor: true,
                            bold: true),
                        const SizedBox(height: 10),
                        AbsFeedpost(
                          postData: userPosts!,
                          myUserView: myUserview,
                          showInteractionOptions: false,
                          onRemoved: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: AbsText(
                                    displayString:
                                        "Post Deleted. Refresh the page to see changes",
                                    fontSize: 14)));
                          },
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                                child: AbsButtonSecondary(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SeeAllPosts(
                                                  userview: myUserview)));
                                    },
                                    text: "See all posts"))
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                      const AbsText(
                          displayString: "Experience",
                          fontSize: 16,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 10),
                      for (int i = 0; i < experience.length; i++) ...[
                        AbsProfileTile(
                          profileId: widget.profileId!,
                          data: experience[i],
                          isMyAccount: isMyAccount,
                        ),
                        const SizedBox(height: 5),
                      ],
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "Education",
                          fontSize: 16,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 10),
                      for (int i = 0; i < academics.length; i++) ...[
                        AbsProfileTile(
                          profileId: widget.profileId!,
                          data: academics[i],
                          isMyAccount: isMyAccount,
                        ),
                        const SizedBox(height: 5),
                      ],
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "Projects",
                          fontSize: 16,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 10),
                      for (int i = 0; i < projects.length; i++) ...[
                        AbsProfileTile(
                          profileId: widget.profileId!,
                          data: projects[i],
                          isMyAccount: isMyAccount,
                        ),
                        const SizedBox(height: 5),
                      ],
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "Certifications",
                          fontSize: 16,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 10),
                      for (int i = 0; i < certifications.length; i++) ...[
                        AbsProfileTile(
                          profileId: widget.profileId!,
                          data: certifications[i],
                          isMyAccount: isMyAccount,
                        ),
                        const SizedBox(height: 5),
                      ],
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ));
  }
}
