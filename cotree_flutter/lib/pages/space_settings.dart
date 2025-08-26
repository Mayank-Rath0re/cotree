import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/create_project_page.dart';
import 'package:cotree_flutter/pages/create_team_page.dart';
import 'package:cotree_flutter/pages/find_members_page.dart';
import 'package:cotree_flutter/pages/manage_space_members.dart';
import 'package:cotree_flutter/pages/project_manage_page.dart';
import 'package:cotree_flutter/pages/team_manage_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpaceSettings extends StatefulWidget {
  final int spaceId;
  final Member activeMember;
  final List<Member> spaceMembers;
  const SpaceSettings(
      {super.key,
      required this.spaceId,
      required this.activeMember,
      required this.spaceMembers});

  @override
  State<SpaceSettings> createState() => _SpaceSettingsState();
}

class _SpaceSettingsState extends State<SpaceSettings> {
  late List<Teams> spaceTeams = [];
  late List<Project> spaceProjects = [];
  int pageIndex = 0;
  int editOrDelete = 0;
  bool isLoading = true;

  void getBuildData() async {
    var teams = await client.space.fetchSpaceTeams(widget.spaceId);
    var projects = await client.space.fetchSpaceProjects(widget.spaceId);
    setState(() {
      spaceTeams = teams;
      spaceProjects = projects;
      isLoading = false;
    });
  }

  Widget settingsTile(Function()? onTap, Icon icon, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: AbsMinimalBox(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 10),
                Expanded(
                  child: AbsText(displayString: text, fontSize: 15),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  Scaffold selectTeams(int teamOrProject) {
    return Scaffold(
        appBar: AppBar(
          title: AbsText(
              displayString:
                  "Select ${teamOrProject == 0 ? "Team" : "Project"}",
              fontSize: 16,
              bold: true),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (teamOrProject == 0) ...[
                for (int i = 0; i < spaceTeams.length; i++) ...[
                  settingsTile(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeamManagePage(
                                  memberData: widget.activeMember,
                                  teamData: spaceTeams[i],
                                )));
                  },
                      Icon(
                        Icons.group,
                        color: Provider.of<ThemeProvider>(context).headColor,
                      ),
                      spaceTeams[i].teamTitle),
                  const SizedBox(height: 6),
                ]
              ] else ...[
                for (int i = 0; i < spaceProjects.length; i++) ...[
                  settingsTile(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectManagePage(
                                projectData: spaceProjects[i])));
                  },
                      Icon(
                        Icons.workspaces,
                        color: Provider.of<ThemeProvider>(context).headColor,
                      ),
                      spaceProjects[i].projectTitle),
                  const SizedBox(height: 6),
                ]
              ]
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
            displayString: "Space Settings", fontSize: 16, bold: true),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AbsText(
                        displayString: "Member", fontSize: 18, bold: true),
                    const SizedBox(height: 5),
                    settingsTile(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FindMembersPage(spaceId: widget.spaceId)),
                      );
                    },
                        Icon(
                          Icons.send_rounded,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                        "Invite Members"),
                    const SizedBox(height: 5),
                    settingsTile(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageSpaceMembers(
                                spaceMembers: widget.spaceMembers,
                                spaceId: widget.spaceId,
                                myMemberData: widget.activeMember)),
                      );
                    },
                        Icon(
                          Icons.manage_accounts,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                        "Manage Members"),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 6),
                    const AbsText(
                        displayString: "Teams", fontSize: 18, bold: true),
                    const SizedBox(height: 5),
                    settingsTile(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTeamPage(
                            spaceId: widget.spaceId,
                            spaceMembers: widget.spaceMembers,
                          ),
                        ),
                      );
                    },
                        Icon(
                          Icons.groups_rounded,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                        "Create New Team"),
                    const SizedBox(height: 5),
                    settingsTile(() {
                      setState(() {
                        editOrDelete = 0;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => selectTeams(0)));
                    },
                        Icon(
                          Icons.group_work,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                        "Manage Team"),
                    const SizedBox(height: 5),
                    settingsTile(() {
                      setState(() {
                        editOrDelete = 1;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => selectTeams(0)));
                    },
                        Icon(
                          Icons.group_remove,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                        "Remove Team"),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 6),
                    const AbsText(
                        displayString: "Projects", fontSize: 18, bold: true),
                    const SizedBox(height: 5),
                    settingsTile(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateProjectPage(
                            spaceId: widget.spaceId,
                          ),
                        ),
                      );
                    },
                        Icon(
                          Icons.note_add,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                        "Create New Project"),
                    const SizedBox(height: 5),
                    settingsTile(() {
                      setState(() {
                        editOrDelete = 0;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => selectTeams(1)));
                    },
                        Icon(
                          Icons.task,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                        "Manage Project"),
                    const SizedBox(height: 5),
                    settingsTile(() {
                      setState(() {
                        editOrDelete = 1;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => selectTeams(1)));
                    },
                        Icon(
                          Icons.playlist_remove,
                          color: Provider.of<ThemeProvider>(context).headColor,
                        ),
                        "Remove Project"),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 6),
                    const AbsText(
                        displayString: "Space", fontSize: 18, bold: true),
                    const SizedBox(height: 5),
                    settingsTile(
                        () {},
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        "Delete Workspace"),
                    const SizedBox(height: 5),
                    settingsTile(
                        () {},
                        Icon(
                          Icons.directions_run,
                          color: Colors.red,
                        ),
                        "Leave Workspace"),
                  ],
                ),
              ),
            ),
    );
  }
}
