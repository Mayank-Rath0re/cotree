import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_red_button.dart';
import 'package:cotree_flutter/components/abs_searchbar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/add_team_members_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamManagePage extends StatefulWidget {
  final Teams teamData;
  final Member memberData;
  final List<Member>? teamMembs;
  const TeamManagePage({
    super.key,
    required this.memberData,
    required this.teamData,
    this.teamMembs,
  });

  @override
  State<TeamManagePage> createState() => _TeamManagePageState();
}

class _TeamManagePageState extends State<TeamManagePage> {
  TextEditingController searchController = TextEditingController();
  late List<Member> teamMembers = [];
  List<Member> searchMembers = [];
  List<Member> selectedMembers = [];
  List<int> leadIds = [];
  Map<String, List<Member>> roleWiseMember = {"Lead": [], "Contributor": []};
  bool selectMode = false;
  bool delTasks = false;
  bool delDocs = false;
  bool isLoading = false;

  void _toggleMemberSelection(Member member) {
    if (!selectMode) return;

    bool isSelected = selectedMembers.contains(member);
    String role = leadIds.contains(member.id) ? "Lead" : "Contributor";

    setState(() {
      if (isSelected) {
        roleWiseMember[role]!.add(member);
        selectedMembers.remove(member);
        if (selectedMembers.isEmpty) selectMode = false;
      } else {
        if (searchMembers.isNotEmpty) searchMembers.remove(member);
        roleWiseMember[role]!.remove(member);
        selectedMembers.add(member);
      }
    });
  }

  void _enterSelectMode(Member member) {
    if (selectMode) return;

    setState(() {
      selectMode = true;
      _toggleMemberSelection(member);
    });
  }

  Widget memberViewBuild(Member member) {
    bool isSelected = selectedMembers.contains(member);
    return GestureDetector(
        onTap: () => _toggleMemberSelection(member),
        onLongPress: () => _enterSelectMode(member),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected
                        ? Provider.of<ThemeProvider>(context).headColor
                        : Colors.transparent),
                color: Provider.of<ThemeProvider>(context).mainColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  AbsAvatar(radius: 22, avatarUrl: member.avatar),
                  const SizedBox(width: 20),
                  AbsText(displayString: member.name, fontSize: 16, bold: true),
                  const Spacer(),
                  PopupMenuButton(itemBuilder: (context) {
                    bool isLead = leadIds.contains(member.id);
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        onTap: () => _showRoleChangeDialog(
                            member, isLead ? "Contributor" : "Lead"),
                        child: AbsText(
                            displayString:
                                isLead ? "Make Contributor" : "Make Lead",
                            fontSize: 14),
                      ),
                      PopupMenuItem(
                        onTap: () => _showRemoveDialog(member),
                        child: const Text(
                          "Remove",
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ),
                    ];
                  })
                ],
              ),
            )));
  }

  void _showRoleChangeDialog(Member member, String newRole) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(height: 10),
                  AbsAvatar(radius: 22, avatarUrl: member.avatar),
                  const SizedBox(height: 10),
                  AbsText(
                      displayString: "Make ${member.name} a $newRole?",
                      fontSize: 15),
                  const SizedBox(height: 10),
                  newRole == "Lead"
                      ? AbsButtonPrimary(
                          roundedBorder: true,
                          onPressed: () => _changeMemberRole(member, newRole),
                          text: "Make Lead",
                        )
                      : AbsButtonSecondary(
                          roundedBorder: true,
                          onPressed: () => _changeMemberRole(member, newRole),
                          text: "Make Contributor",
                          fontSize: 16)
                ],
              ),
            ));
  }

  void _showRemoveDialog(Member member) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(height: 10),
                  AbsAvatar(radius: 22, avatarUrl: member.avatar),
                  const SizedBox(height: 10),
                  AbsText(
                      displayString: "Remove ${member.name} from the team?",
                      fontSize: 15),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _removeMember(member),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const AbsText(displayString: "Remove", fontSize: 16),
                  )
                ],
              ),
            ));
  }

  Future<void> _changeMemberRole(Member member, String newRole) async {
    await client.team.editTeamRole(member.id!, widget.teamData.id!, newRole);
    Navigator.pop(context);
    getBuildData();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: AbsText(
            displayString: "Made ${member.name} a $newRole", fontSize: 14)));
  }

  Future<void> _removeMember(Member member) async {
    await client.team
        .removeTeamMember([member.id!], widget.teamData.id!, false, false);
    Navigator.pop(context);
    getBuildData();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: AbsText(
            displayString:
                "Removed ${member.name} from ${widget.teamData.teamTitle}",
            fontSize: 14)));
  }

  void _showBulkRemoveDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Remove ${selectedMembers.length} members from the team?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const AbsText(
                  displayString:
                      "This step cannot be reversed and would also effect any related projects",
                  fontSize: 13,
                  align: true),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AbsText(displayString: "Delete Tasks", fontSize: 15),
                  Switch(
                      value: delTasks,
                      onChanged: (val) => setState(() => delTasks = !delTasks))
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AbsText(
                      displayString: "Delete Documents", fontSize: 15),
                  Switch(
                      value: delDocs,
                      onChanged: (val) => setState(() => delDocs = !delDocs))
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: AbsRedButton(
                      roundedBorder: true,
                      onPressed: () => _bulkRemoveMembers(),
                      text: "Remove",
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Future<void> _bulkRemoveMembers() async {
    await client.team.removeTeamMember(
        selectedMembers.map((member) => member.id!).toList(),
        widget.teamData.id!,
        delTasks,
        delDocs);
    Navigator.pop(context);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: AbsText(
            displayString:
                "Removed ${selectedMembers.length} from ${widget.teamData.teamTitle}",
            fontSize: 14)));
  }

  void getBuildData() async {
    var roleInfo = await client.team.fetchTeamRoles(widget.teamData.id!);
    var leads =
        roleInfo.where((t) => t.role == "Lead").map((t) => t.memberId).toSet();
    var contributors = roleInfo
        .where((t) => t.role == "Contributor")
        .map((t) => t.memberId)
        .toSet();
    List<Member> members = [];
    if (widget.teamMembs == null) {
      members = await client.team.fetchTeamMembers([widget.teamData.id!]);
    } else {
      members = widget.teamMembs!;
    }

    setState(() {
      leadIds = leads.toList();
      roleWiseMember["Lead"]!
          .addAll(members.where((memb) => leads.contains(memb.id)).toList());
      roleWiseMember["Contributor"]!.addAll(
          members.where((memb) => contributors.contains(memb.id)).toList());
      teamMembers = members;
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
        appBar: AppBar(
            title: const AbsText(
                displayString: "Manage Team", fontSize: 16, bold: true),
            centerTitle: true),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(children: [
                  SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AbsSearchbar(
                          controller: searchController,
                          onChanged: (val) {
                            if (val.isEmpty) {
                              setState(() {
                                searchMembers = [];
                              });
                            } else {
                              setState(() {
                                // Search both role lists
                                searchMembers = [
                                  ...roleWiseMember["Lead"]!
                                      .where((t) => t.name.contains(val)),
                                  ...roleWiseMember["Contributor"]!
                                      .where((t) => t.name.contains(val)),
                                ];
                              });
                            }
                          }),
                      const SizedBox(height: 20),
                      if (selectedMembers.isNotEmpty) ...[
                        const AbsText(
                            displayString: "Selected Members",
                            fontSize: 16,
                            bold: true,
                            headColor: true),
                        const SizedBox(height: 10),
                        for (int i = 0; i < selectedMembers.length; i++) ...[
                          memberViewBuild(selectedMembers[i]),
                          const SizedBox(height: 5),
                        ],
                        const SizedBox(height: 10),
                      ],
                      const AbsText(
                        displayString: "Team Leads",
                        fontSize: 16,
                        bold: true,
                      ),
                      const SizedBox(height: 10),
                      if (searchMembers.isEmpty &&
                          searchController.text.isEmpty) ...[
                        for (int i = 0;
                            i < roleWiseMember["Lead"]!.length;
                            i++) ...[
                          memberViewBuild(roleWiseMember["Lead"]![i]),
                          const SizedBox(height: 5),
                        ]
                      ] else if (searchMembers.isNotEmpty) ...[
                        for (int i = 0; i < searchMembers.length; i++) ...[
                          if (leadIds.contains(searchMembers[i].id)) ...[
                            memberViewBuild(searchMembers[i]),
                            const SizedBox(height: 5),
                          ]
                        ]
                      ],
                      const SizedBox(height: 20),
                      const AbsText(
                        displayString: "Contributors",
                        fontSize: 16,
                        bold: true,
                      ),
                      const SizedBox(height: 10),
                      if (searchMembers.isEmpty &&
                          searchController.text.isEmpty) ...[
                        for (int i = 0;
                            i < roleWiseMember["Contributor"]!.length;
                            i++) ...[
                          memberViewBuild(roleWiseMember["Contributor"]![i]),
                          const SizedBox(height: 5),
                        ]
                      ] else if (searchMembers.isNotEmpty) ...[
                        for (int i = 0; i < searchMembers.length; i++) ...[
                          if (!leadIds.contains(searchMembers[i].id)) ...[
                            memberViewBuild(searchMembers[i]),
                            const SizedBox(height: 5),
                          ]
                        ]
                      ],
                      const SizedBox(height: 50)
                    ],
                  )),
                  if (selectedMembers.isNotEmpty) ...[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: AbsRedButton(
                                roundedBorder: true,
                                onPressed: () => _showBulkRemoveDialog(),
                                text: "Remove",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    )
                  ] else ...[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AbsButtonPrimary(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddTeamMembersPage(
                                          teamData: widget.teamData),
                                    ),
                                  );
                                  if (result == true) {
                                    getBuildData(); // Refresh data if members were added
                                  }
                                },
                                text: "Add members to team",
                                icon: const Icon(Icons.person_add_alt),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ])));
  }
}
