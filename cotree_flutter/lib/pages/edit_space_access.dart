import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSpaceAccess extends StatefulWidget {
  final List<Member> editMembers;
  final bool editTogether;
  const EditSpaceAccess(
      {super.key, required this.editMembers, required this.editTogether});

  @override
  State<EditSpaceAccess> createState() => _EditSpaceAccessState();
}

class _EditSpaceAccessState extends State<EditSpaceAccess> {
  // Controllers for each member
  Map<int, TextEditingController> designationControllers = {};
  Map<int, String?> selectedGlobalRoles = {};
  Map<int, List<String>> selectedTeams = {};
  Map<int, List<String>> selectedTeamRoles = {};

  // Available options
  List<String> globalRoles = ["Admin", "Member", "Guest"];

  // Loading state
  bool isLoading = true;
  List<Teams> spaceTeams = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    // Initialize controllers and data for each member
    for (var member in widget.editMembers) {
      designationControllers[member.id!] =
          TextEditingController(text: member.designation);
      selectedGlobalRoles[member.id!] = member.globalRole;
      selectedTeams[member.id!] = [];
      selectedTeamRoles[member.id!] = [];
    }

    // Load teams data if needed
    if (widget.editMembers.isNotEmpty) {
      try {
        spaceTeams = await client.space
            .fetchSpaceTeams(widget.editMembers.first.workspaceId);
      } catch (e) {
        // Use default teams if loading fails
        print('Error loading teams: $e');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void _saveChanges() async {
    // Validate required fields
    for (var member in widget.editMembers) {
      if (selectedGlobalRoles[member.id!] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please select a global role for ${member.name}')),
        );
        return;
      }
    }

    try {
      // Here you would implement the API call to update member data
      // This is a placeholder for the actual implementation
      for (var member in widget.editMembers) {
        // Update member designation and global role
        // await client.space.updateMemberRole(
        //   member.id!,
        //   designationControllers[member.id!]!.text,
        //   selectedGlobalRoles[member.id!]!,
        //   selectedTeams[member.id!],
        //   selectedTeamRoles[member.id!],
        // );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Changes saved successfully')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving changes: $e')),
      );
    }
  }

  Widget _buildMemberEditCard(Member member) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Member header
            Row(
              children: [
                AbsAvatar(radius: 25, avatarUrl: member.avatar),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AbsText(
                          displayString: member.name, fontSize: 18, bold: true),
                      AbsText(
                        displayString:
                            "Member since ${member.joinedAt.toString().split(' ')[0]}",
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Designation field
            const AbsText(
                displayString: "Designation", fontSize: 16, headColor: true),
            const SizedBox(height: 8),
            AbsTextfield(
              hintText: "Enter designation",
              controller: designationControllers[member.id!]!,
            ),
            const SizedBox(height: 16),

            // Global Role selection
            const AbsText(
                displayString: "Global Role", fontSize: 16, headColor: true),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: globalRoles.map((role) {
                return ChoiceChip(
                  label: Text(role),
                  selectedColor: Provider.of<ThemeProvider>(context).headColor,
                  selected: selectedGlobalRoles[member.id!] == role,
                  onSelected: (selected) {
                    setState(() {
                      selectedGlobalRoles[member.id!] = selected ? role : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Team assignments
            const AbsText(
                displayString: "Team Assignments",
                fontSize: 16,
                headColor: true),
            const SizedBox(height: 8),
            Column(
              children: spaceTeams.map((team) {
                final index =
                    selectedTeams[member.id!]!.indexOf(team.teamTitle);
                final isSelected = index != -1;
                final role = isSelected
                    ? selectedTeamRoles[member.id!]![index]
                    : "Contributor";

                return ListTile(
                  dense: true,
                  title: Text(team.teamTitle),
                  leading: Checkbox(
                    checkColor: Provider.of<ThemeProvider>(context).headColor,
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedTeams[member.id!]!.add(team.teamTitle);
                          selectedTeamRoles[member.id!]!.add("Contributor");
                        } else {
                          final removeIndex = selectedTeams[member.id!]!
                              .indexOf(team.teamTitle);
                          if (removeIndex != -1) {
                            selectedTeams[member.id!]!.removeAt(removeIndex);
                            selectedTeamRoles[member.id!]!
                                .removeAt(removeIndex);
                          }
                        }
                      });
                    },
                  ),
                  trailing: isSelected
                      ? ToggleButtons(
                          borderRadius: BorderRadius.circular(8),
                          fillColor:
                              Provider.of<ThemeProvider>(context).headColor,
                          isSelected: [role == "Lead", role == "Contributor"],
                          onPressed: (toggleIndex) {
                            setState(() {
                              selectedTeamRoles[member.id!]![index] =
                                  toggleIndex == 0 ? "Lead" : "Contributor";
                            });
                          },
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text("Lead"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text("Contributor"),
                            ),
                          ],
                        )
                      : null,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: AbsText(
          displayString: widget.editTogether
              ? "Edit Multiple Members"
              : "Edit Member Access",
          fontSize: 16,
          bold: true,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: const AbsText(
                displayString: "Save",
                fontSize: 15,
                bold: true,
                headColor: true),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsText(
                    displayString:
                        "Editing ${widget.editMembers.length} member${widget.editMembers.length > 1 ? 's' : ''}",
                    fontSize: 16,
                    bold: true,
                  ),
                  const SizedBox(height: 4),
                  const AbsText(
                    displayString:
                        "Update roles, designations, and team assignments",
                    fontSize: 14,
                  ),
                ],
              ),
            ),

            // Member edit cards
            ...widget.editMembers.map((member) => _buildMemberEditCard(member)),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers
    for (var controller in designationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
