import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_role_edit.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:flutter/material.dart';

class AddMembersPage extends StatefulWidget {
  final int spaceId;
  final List<UserView> membersToAdd;
  const AddMembersPage(
      {super.key, required this.spaceId, required this.membersToAdd});

  @override
  State<AddMembersPage> createState() => _AddMembersPageState();
}

class _AddMembersPageState extends State<AddMembersPage> {
  late List<String> teams;
  late List<String> projects;
  bool isLoading = true;
  List<GlobalKey<AbsRoleEditState>> roleEditKeys = [];

  void fetchBuildData() async {
    var fetchedData = await client.space.fetchTitles(widget.spaceId);
    setState(() {
      teams = fetchedData[0];
      projects = fetchedData[1];
      roleEditKeys = List.generate(
        widget.membersToAdd.length,
        (_) => GlobalKey<AbsRoleEditState>(),
      );

      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchBuildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const AbsText(displayString: "Team & Roles", fontSize: 16),
            centerTitle: true),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    for (int i = 0; i < widget.membersToAdd.length; i++) ...[
                      AbsMinimalBox(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AbsRoleEdit(
                            key: roleEditKeys[i],
                            user: widget.membersToAdd[i],
                            editingUserId: sessionManager.signedInUser!.id!,
                            spaceId: widget.spaceId,
                            teams: teams,
                            projects: projects),
                      )),
                      const SizedBox(height: 10),
                    ],
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: AbsButtonPrimary(
                            onPressed: () {
                              for (var key in roleEditKeys) {
                                key.currentState?.sendInvite();
                              }
                              // Go to Space Manage Page
                              Navigator.pop(context);
                              // Go to Page Before That
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: const AbsText(
                                          displayString:
                                              "Invite Sent Successfully",
                                          fontSize: 16)));
                            },
                            fontSize: 18,
                            text: "Invite Users",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
  }
}
