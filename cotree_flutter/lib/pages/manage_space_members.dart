import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_red_button.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/edit_space_access.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageSpaceMembers extends StatefulWidget {
  final List<Member> spaceMembers;
  final int spaceId;
  final Member myMemberData;
  const ManageSpaceMembers({
    super.key,
    required this.spaceMembers,
    required this.spaceId,
    required this.myMemberData,
  });

  @override
  State<ManageSpaceMembers> createState() => _ManageSpaceMembersState();
}

class _ManageSpaceMembersState extends State<ManageSpaceMembers> {
  Map<String, List<Member>> roleMembers = {
    "Owner": [],
    "Admin": [],
    "Member": []
  };
  List<Member> selectedMembers = [];
  bool isSelectMode = false;
  bool isLoading = true;

  void getBuildData() {
    for (var member in widget.spaceMembers) {
      roleMembers[member.globalRole]?.add(member);
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget cardBuild(Member member) {
    bool isSelected = selectedMembers.contains(member);
    bool canSelect = (widget.myMemberData.globalRole == "Owner" &&
            member.globalRole != "Owner") ||
        (widget.myMemberData.globalRole == "Admin" &&
            member.globalRole == "Member");

    return InkWell(
      onTap: () {
        if (!canSelect || !isSelectMode) return;
        setState(() {
          if (isSelected) {
            selectedMembers.remove(member);
            if (selectedMembers.isEmpty) {
              isSelectMode = !isSelectMode;
            }
            roleMembers[member.globalRole]?.add(member);
          } else {
            selectedMembers.add(member);
            roleMembers[member.globalRole]?.remove(member);
          }
        });
      },
      onLongPress: () {
        if (!canSelect) return;
        if (!isSelectMode) {
          setState(() {
            isSelectMode = true;
            selectedMembers.add(member);
            roleMembers[member.globalRole]?.remove(member);
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Provider.of<ThemeProvider>(context).mainColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? Provider.of<ThemeProvider>(context).headColor
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            AbsAvatar(radius: 26, avatarUrl: member.avatar),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsText(
                    displayString: member.name,
                    fontSize: 16,
                    bold: true,
                  ),
                  const SizedBox(height: 4),
                  AbsText(
                    displayString: member.designation,
                    fontSize: 13,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearSelection() {
    for (var member in selectedMembers) {
      roleMembers[member.globalRole]?.add(member);
    }
    selectedMembers.clear();
    isSelectMode = false;
  }

  @override
  void initState() {
    super.initState();
    getBuildData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AbsText(
          displayString: "Members",
          fontSize: 18,
          bold: true,
        ),
        centerTitle: true,
        actions: isSelectMode
            ? [
                IconButton(
                  icon: const Icon(Icons.manage_accounts),
                  tooltip: 'Manage',
                  onPressed: () {
                    // Handle manage action
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditSpaceAccess(
                                editMembers: selectedMembers,
                                editTogether: false)));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Remove',
                  onPressed: () {
                    // Handle remove action
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
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.close))
                                      ]),
                                  Text(
                                      "Remove ${selectedMembers.length} users from the space?",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 20),
                                  const AbsText(
                                    displayString: "This can not reverted",
                                    align: true,
                                    fontSize: 14,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AbsRedButton(
                                            roundedBorder: true,
                                            onPressed: () async {
                                              await client.space.removeMember(
                                                  selectedMembers.map((memb) {
                                                return memb.id!;
                                              }).toList());
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: AbsText(
                                                displayString:
                                                    "Removed selected users",
                                                fontSize: 16,
                                              )));
                                              // To be replaced with go routing later
                                              Navigator.pop(context);
                                              setState(() {
                                                selectedMembers = [];
                                              });
                                            },
                                            text: "Remove"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Cancel',
                  onPressed: () {
                    setState(clearSelection);
                  },
                ),
              ]
            : [],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                if (selectedMembers.isNotEmpty) ...[
                  const AbsText(
                    displayString: "Selected Members",
                    fontSize: 16,
                    bold: true,
                    headColor: true,
                  ),
                  const SizedBox(height: 10),
                  ...selectedMembers.map(cardBuild),
                  const Divider(height: 30),
                ],
                for (var role in roleMembers.keys)
                  if (roleMembers[role]!.isNotEmpty) ...[
                    AbsText(
                      displayString: role,
                      fontSize: 16,
                      bold: true,
                      headColor: true,
                    ),
                    const SizedBox(height: 10),
                    ...roleMembers[role]!.map(cardBuild),
                    const SizedBox(height: 16),
                  ]
              ],
            ),
    );
  }
}
