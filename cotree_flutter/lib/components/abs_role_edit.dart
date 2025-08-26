import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsRoleEdit extends StatefulWidget {
  final UserView user;
  final int editingUserId;
  final int spaceId;
  final List<String> teams;
  final List<String> projects;

  const AbsRoleEdit(
      {super.key,
      required this.user,
      required this.editingUserId,
      required this.spaceId,
      required this.teams,
      required this.projects});

  @override
  AbsRoleEditState createState() => AbsRoleEditState();
}

class AbsRoleEditState extends State<AbsRoleEdit> {
  TextEditingController designation = TextEditingController();
  List<String> globalRoles = ["Admin", "Member"];
  List<List<String>> teamRoles = [
    ["Team Lead", "Can manage team, assign roles, create/edit docs/tasks"],
    ["Member", "Can edit tasks and docs within Team"],
  ];
  List<String> selectedTeams = [];
  List<String> selectedTeamRoles = [];
  String? selectedGlobalRole;

  void sendInvite() async {
    List<List<String>> teamsAndRoles = [];
    for (int i = 0; i < selectedTeams.length; i++) {
      teamsAndRoles.add([selectedTeams[i], selectedTeamRoles[i]]);
    }
    // write code for null safety dialogs
    // ignore: unused_local_variable
    var invite = await client.space.createSpaceInvite(
        widget.user.id!,
        widget.spaceId,
        designation.text,
        teamsAndRoles,
        selectedGlobalRole!,
        widget.editingUserId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AbsAvatar(radius: 20, avatarUrl: widget.user.avatar),
              const SizedBox(width: 10),
              AbsText(displayString: widget.user.name, fontSize: 20)
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          AbsTextfield(hintText: "Designation", controller: designation),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 7),
          const SizedBox(height: 7),
          const AbsText(
              displayString: "Global Role", fontSize: 18, headColor: true),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(globalRoles.length, (i) {
              return ChoiceChip(
                label: Text(globalRoles[i]),
                selectedColor: Provider.of<ThemeProvider>(context).headColor,
                selected: selectedGlobalRole == globalRoles[i],
                onSelected: (selected) {
                  setState(() {
                    selectedGlobalRole = selected ? globalRoles[i] : null;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          const AbsText(displayString: "Team", fontSize: 18, headColor: true),
          Column(
            children: widget.teams.map((team) {
              final index = selectedTeams.indexOf(team);
              final isSelected = index != -1;
              final role =
                  isSelected ? selectedTeamRoles[index] : "Contributor";

              return ListTile(
                title: Text(
                  team,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: Checkbox(
                  checkColor: Provider.of<ThemeProvider>(context).headColor,
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        selectedTeams.add(team);
                        selectedTeamRoles.add("Contributor"); // default role
                      } else {
                        final removeIndex = selectedTeams.indexOf(team);
                        if (removeIndex != -1) {
                          selectedTeams.removeAt(removeIndex);
                          selectedTeamRoles.removeAt(removeIndex);
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
                            selectedTeamRoles[index] =
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
    );
  }
}
