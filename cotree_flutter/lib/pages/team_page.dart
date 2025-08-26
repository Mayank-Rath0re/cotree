import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_status_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/meetings_page.dart';
import 'package:cotree_flutter/pages/project_page.dart';
import 'package:cotree_flutter/pages/team_chat_page.dart';
import 'package:cotree_flutter/pages/team_manage_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  final int spaceId;
  final Member memberData;
  final Teams teamData;
  const TeamPage(
      {super.key,
      required this.spaceId,
      required this.memberData,
      required this.teamData});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  late List<Member> teamMembers;
  late List<Meetings> teamMeetings;
  late List<Project> teamProjects;

  void getBuildData() async {
    var members = await client.team.fetchTeamMembers([widget.teamData.id!]);
    var meetings = await client.team.fetchMeetings([widget.teamData.id!]);
    var projects = await client.team.fetchTeamProjects([widget.teamData.id!]);
    setState(() {
      teamMembers = members;
      teamMeetings = meetings;
      teamProjects = projects;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          const SizedBox(width: 20),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeamManagePage(
                              memberData: teamMembers.firstWhere(
                                  (t) => t.id! == widget.memberData.id!),
                              teamData: widget.teamData,
                              teamMembs: teamMembers,
                            )));
              },
              icon: const Icon(Icons.manage_accounts)),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: isLoading
          ? const Drawer()
          : Drawer(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 45),
                    const AbsText(
                      displayString: "Team Members",
                      fontSize: 18,
                      headColor: true,
                    ),
                    const SizedBox(height: 10),
                    for (int i = 0; i < teamMembers.length; i++) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: AbsAvatar(
                                  radius: 24,
                                  avatarUrl: teamMembers[i].avatar)),
                          const SizedBox(width: 4),
                          Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AbsText(
                                    displayString: teamMembers[i].name,
                                    fontSize: 17,
                                    headColor: true,
                                  ),
                                  const SizedBox(height: 5),
                                  AbsText(
                                      displayString: teamMembers[i].designation,
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
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    AbsText(
                      displayString: widget.teamData.teamTitle,
                      fontSize: 20,
                      headColor: true,
                      bold: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamChatPage(
                                    teamData: widget.teamData,
                                    memberData: teamMembers
                                        .where(
                                            (t) => t.id == widget.memberData.id)
                                        .first)));
                      },
                      child: const AbsMinimalBox(
                          child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AbsText(
                              displayString: "Go to Team Chat",
                              fontSize: 18,
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      )),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AbsText(
                            displayString: "Meetings",
                            fontSize: 18,
                            bold: true),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MeetingsPage(
                                          spaceId: widget.spaceId,
                                          memberId: widget.memberData.id!,
                                          teamId: widget.teamData.id!)));
                            },
                            child: Row(
                              children: [
                                const AbsText(
                                    displayString: "See all", fontSize: 14),
                                Icon(Icons.arrow_forward_ios,
                                    color: Provider.of<ThemeProvider>(context)
                                        .contrastColor)
                              ],
                            ))
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (teamMeetings.isEmpty) ...[
                      Row(
                        children: [
                          Expanded(
                            child: AbsMinimalBox(
                                child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const AbsText(
                                    displayString: "No meetings scheduled",
                                    fontSize: 16),
                                const SizedBox(height: 10),
                                AbsButtonPrimary(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MeetingsPage(
                                                      spaceId: widget.spaceId,
                                                      memberId:
                                                          widget.memberData.id!,
                                                      teamId: widget
                                                          .teamData.id!)));
                                    },
                                    text: "Schedule Meet")
                              ],
                            )),
                          ),
                        ],
                      )
                    ] else ...[
                      for (int i = 0; i < teamMeetings.length; i++) ...[
                        AbsMinimalBox(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AbsText(
                                      displayString: teamMeetings[i].agenda,
                                      fontSize: 15,
                                      bold: true),
                                  AbsText(
                                      displayString: DateFormat(
                                              'yyyy-MM-dd - kk:mm')
                                          .format(
                                              teamMeetings[i].time.toLocal()),
                                      fontSize: 14)
                                ],
                              ),
                            ),
                            AbsButtonSecondary(onPressed: () {}, text: "Join")
                          ],
                        )),
                        const SizedBox(height: 8),
                      ]
                    ],
                    const SizedBox(height: 20),
                    const AbsText(
                        displayString: "Projects", fontSize: 18, bold: true),
                    const SizedBox(height: 10),
                    if (teamProjects.isEmpty) ...[
                      Row(
                        children: [
                          Expanded(
                            child: AbsMinimalBox(
                                child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const AbsText(
                                    displayString: "No Projects Assigned",
                                    fontSize: 16),
                                const SizedBox(height: 10),
                                AbsButtonPrimary(
                                    onPressed: () {}, text: "Select Project")
                              ],
                            )),
                          ),
                        ],
                      )
                    ] else ...[
                      for (int i = 0; i < teamProjects.length; i++) ...[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProjectPage(
                                          spaceId: widget.spaceId,
                                          projectId: teamProjects[i].id!,
                                          memberData: widget.memberData)));
                            },
                            child: AbsMinimalBox(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AbsText(
                                          displayString:
                                              teamProjects[i].projectTitle,
                                          fontSize: 16,
                                          bold: true),
                                      Text(
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                          teamProjects[i].projectOverview,
                                          style: const TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AbsStatusBox(text: teamProjects[i].status)
                              ],
                            ))),
                        const SizedBox(height: 6)
                      ],
                    ]
                  ],
                ),
              ),
      ),
    );
  }
}
