import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_status_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/project_page.dart';
import 'package:cotree_flutter/pages/space_chat_page.dart';
import 'package:cotree_flutter/pages/space_settings.dart';
import 'package:cotree_flutter/pages/taskboard_2.dart';
import 'package:cotree_flutter/pages/team_page.dart';
import 'package:cotree_flutter/pages/space_land_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainSpacePage extends StatefulWidget {
  final int spaceId;
  final int userId;
  const MainSpacePage({super.key, required this.spaceId, required this.userId});

  @override
  State<MainSpacePage> createState() => _MainSpacePageState();
}

class _MainSpacePageState extends State<MainSpacePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  late Space spaceData;
  late UserView userData;
  late List<Teams> userTeams;
  late Member memberData;
  late List<Project> projectData;
  late List<Member> spaceMembers;
  bool isLoading = true;

  void getSpaceData() async {
    var spaceInfo = await client.space.fetchSpace(widget.spaceId);
    var userInfo = await client.account.getUserView(widget.userId);
    var memberInfo =
        await client.space.fetchMemberByUserId(widget.spaceId, widget.userId);
    var spaceMemb = await client.space.fetchSpaceMembers(widget.spaceId);
    var memberTeams = await client.space.fetchMemberTeams(memberInfo!.id!);
    var projectsInfo =
        await client.space.fetchProjectsByUser(memberTeams.map((team) {
      return team.id!;
    }).toList());
    // More to load
    // Role, Teams, Projects, Meetings
    setState(() {
      spaceData = spaceInfo!;
      userData = userInfo;
      memberData = memberInfo;
      spaceMembers = spaceMemb;
      userTeams = memberTeams;
      projectData = projectsInfo;
      isLoading = false;
    });
  }

  Widget pageBuild() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLoading) ...[
            const Center(child: CircularProgressIndicator())
          ] else ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AbsOrgAvatar(radius: 35, avatarUrl: spaceData.avatar),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AbsText(
                          displayString: spaceData.title,
                          fontSize: 22,
                          headColor: true),
                      const SizedBox(height: 10),
                      AbsText(
                          displayString: spaceData.description, fontSize: 16)
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 10),
            const AbsText(
                displayString: "Your Teams", fontSize: 20, headColor: true),
            const SizedBox(height: 8),
            // Need to be debugged a lot
            for (int i = 0; i < userTeams.length; i++) ...[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamPage(
                        spaceId: widget.spaceId,
                        memberData: memberData,
                        teamData: userTeams[i],
                      ),
                    ),
                  );
                },
                child: AbsMinimalBox(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.group,
                            color:
                                Provider.of<ThemeProvider>(context).headColor),
                        const SizedBox(width: 10),
                        AbsText(
                          displayString: userTeams[i].teamTitle,
                          fontSize: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8)
            ],
            const SizedBox(height: 20),
            const AbsText(
                displayString: "Your Projects", fontSize: 20, headColor: true),
            const SizedBox(height: 12),
            if (projectData.isEmpty) ...[
              const Center(
                child: AbsText(
                    displayString: "No Projects Assigned Right Now",
                    fontSize: 17),
              )
            ] else ...[
              const SizedBox(height: 8),
              // Need to be debugged a lot
              for (int i = 0; i < projectData.length; i++) ...[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectPage(
                          spaceId: widget.spaceId,
                          projectId: projectData[i].id!,
                          memberData: memberData,
                        ),
                      ),
                    );
                  },
                  child: AbsMinimalBox(
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AbsStatusBox(text: projectData[i].status),
                          const SizedBox(width: 10),
                          AbsText(
                            displayString: projectData[i].projectTitle,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8)
              ],

              const SizedBox(height: 20),
              const AbsText(
                  displayString: "Recent Activity",
                  fontSize: 20,
                  headColor: true)
            ],
          ]
        ],
      )),
    );
  }

  @override
  void initState() {
    getSpaceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: isLoading
            ? const Drawer()
            : Drawer(
                child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AbsAvatar(radius: 35, avatarUrl: userData.avatar)
                      ],
                    ),
                    const SizedBox(height: 8),
                    const AbsText(displayString: "Welcome Back,", fontSize: 16),
                    const SizedBox(height: 3),
                    AbsText(
                        displayString: "${userData.name}.",
                        fontSize: 16,
                        bold: true,
                        headColor: true),
                    const SizedBox(height: 6),
                    AbsText(
                        displayString: memberData.designation, fontSize: 14),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 6),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpaceChatPage(
                                        teams: userTeams,
                                        memberData: memberData,
                                      )));
                        },
                        child: const AbsMinimalBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.inbox),
                            SizedBox(width: 10),
                            AbsText(displayString: "Inbox", fontSize: 14)
                          ],
                        ))),
                    const SizedBox(height: 8),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskboard2(
                                        memberData: memberData,
                                        projectsData: projectData,
                                        accessMode: 0,
                                      )));
                        },
                        child: const AbsMinimalBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.task_alt_sharp),
                            SizedBox(width: 10),
                            AbsText(displayString: "Taskboard", fontSize: 14)
                          ],
                        ))),
                    const SizedBox(height: 8),
                    const AbsMinimalBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.meeting_room),
                        SizedBox(width: 10),
                        AbsText(displayString: "Meetings", fontSize: 14)
                      ],
                    )),
                    const SizedBox(height: 8),
                    const Spacer(),
                    if (memberData.globalRole == "Admin" ||
                        memberData.globalRole == "Owner") ...[
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Provider.of<ThemeProvider>(context).headColor,
                          size: 30,
                        ),
                        title: const AbsText(
                            displayString: "Space Settings",
                            fontSize: 16,
                            bold: true),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpaceSettings(
                                      spaceId: widget.spaceId,
                                      activeMember: memberData,
                                      spaceMembers: spaceMembers)));
                        },
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                            child: AbsButtonPrimary(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SpaceLandPage()));
                                },
                                fontSize: 16,
                                text: "Switch Space"))
                      ],
                    )
                  ],
                ),
              )),
        endDrawer: isLoading
            ? const Drawer()
            : Drawer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 45),
                      const AbsText(
                        displayString: "Online",
                        fontSize: 18,
                        headColor: true,
                      ),
                      const SizedBox(height: 10),
                      for (int i = 0; i < spaceMembers.length; i++) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: AbsAvatar(
                                    radius: 24,
                                    avatarUrl: spaceMembers[i].avatar)),
                            const SizedBox(width: 4),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AbsText(
                                      displayString: spaceMembers[i].name,
                                      fontSize: 17,
                                      headColor: true,
                                    ),
                                    const SizedBox(height: 5),
                                    AbsText(
                                        displayString:
                                            spaceMembers[i].designation,
                                        fontSize: 15)
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(height: 8),
                      ]
                    ],
                  ),
                ),
              ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ],
        ),
        body: pageBuild());
  }
}
