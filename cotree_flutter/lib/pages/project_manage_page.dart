import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_iconbutton_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_status_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectManagePage extends StatefulWidget {
  final Project projectData;
  const ProjectManagePage({super.key, required this.projectData});

  @override
  State<ProjectManagePage> createState() => _ProjectManagePageState();
}

class _ProjectManagePageState extends State<ProjectManagePage> {
  bool isLoading = true;
  List<Teams> allTeams = [];
  List<Teams> assignedTeams = [];
  List<int> deletedTeams = [];
  List<Teams> addedTeams = [];
  late String status;
  bool delDocs = false;
  bool isLoadingTeams = true;

  void getBuildData() async {
    var projTeams =
        await client.project.fetchProjectTeams([widget.projectData.id!]);
    setState(() {
      assignedTeams = projTeams;
      status = widget.projectData.status;
      isLoading = false;
    });
  }

  Future<void> fetchTeams() async {
    var teams =
        await client.project.fetchExcludedProjectTeams(widget.projectData.id!);
    setState(() {
      allTeams = teams;
      isLoadingTeams = false;
    });
  }

  void confirmChanges() {
    if (assignedTeams.length == deletedTeams.length && addedTeams.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AbsText(
                        displayString: "Error",
                        fontSize: 18,
                        bold: true,
                        headColor: true),
                    SizedBox(height: 10),
                    AbsText(
                        displayString:
                            "Project needs to be assigned to at least 1 team",
                        fontSize: 14,
                        align: true,
                        bold: true),
                  ],
                ),
              ));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AbsText(
                      displayString: "Review Changes",
                      fontSize: 18,
                      headColor: true,
                      bold: true,
                    ),
                    const SizedBox(height: 30),
                    if (status != widget.projectData.status) ...[
                      const AbsText(
                          displayString: "Status",
                          fontSize: 16,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AbsStatusBox(text: widget.projectData.status),
                          const Icon(Icons.arrow_forward),
                          AbsStatusBox(text: status)
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (addedTeams.isNotEmpty) ...[
                      const AbsText(
                          displayString: "New Teams",
                          fontSize: 16,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 10),
                      AbsText(
                        displayString:
                            "Assigning ${addedTeams.length} new teams to the project.",
                        fontSize: 15,
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (deletedTeams.isNotEmpty) ...[
                      const AbsText(
                          displayString: "Team Removal",
                          fontSize: 16,
                          bold: true,
                          headColor: true),
                      const SizedBox(height: 10),
                      Text(
                        "ALERT: You are removing ${deletedTeams.length} teams from this project.",
                        style: const TextStyle(color: Colors.red, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      const AbsText(
                          displayString:
                              "This change cannot be reversed and would remove all tasks from members of these teams.",
                          fontSize: 14,
                          align: true),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AbsText(
                              displayString: "Remove Documents",
                              fontSize: 16,
                              bold: true,
                              headColor: true),
                          Switch(
                            value: delDocs,
                            onChanged: (val) {
                              setState(() {
                                delDocs = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const AbsText(displayString: "Cancel", fontSize: 15),
                  ),
                  AbsButtonPrimary(
                      onPressed: () {
                        Navigator.pop(context);
                        if (widget.projectData.status != status) {
                          client.project.changeProjectStatus(
                              widget.projectData.id!, status);
                        }
                        if (deletedTeams.isNotEmpty || addedTeams.isNotEmpty) {
                          client.project.updateAssignedTeams(
                              widget.projectData.id!,
                              deletedTeams,
                              addedTeams.map((team) {
                                return team.id!;
                              }).toList(),
                              delDocs);
                        }
                        // navigate to project page
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: AbsText(
                          displayString: "Updating Project Details",
                          fontSize: 16,
                          bold: true,
                        )));
                      },
                      text: "Proceed"),
                ],
              );
            },
          );
        },
      );
    }
  }

  Widget statusContainer(String text, Widget icon, Color colors) {
    return GestureDetector(
        onTap: () {
          if (status != text) {
            setState(() {
              status = text;
            });
          }
        },
        child: Container(
          width: 130,
          decoration: BoxDecoration(
              border: Border.all(
                  color: status == text ? colors : Colors.transparent),
              color: status == text
                  ? Provider.of<ThemeProvider>(context).secondaryColor
                  : Provider.of<ThemeProvider>(context).mainColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                icon,
                const SizedBox(height: 25),
                AbsStatusBox(text: text),
              ],
            ),
          ),
        ));
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
                displayString: "Manage Project", fontSize: 18, bold: true),
            centerTitle: true),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AbsText(
                        displayString: "Change Project Status",
                        fontSize: 18,
                        bold: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          statusContainer(
                              "Halted",
                              const Icon(
                                Icons.error_outline,
                                color: Colors.orange,
                                size: 60,
                              ),
                              Colors.orange),
                          statusContainer(
                              "Ongoing",
                              const Icon(
                                Icons.run_circle_outlined,
                                color: Colors.green,
                                size: 60,
                              ),
                              Colors.green),
                          statusContainer(
                              "Completed",
                              const Icon(
                                Icons.check_circle_outline,
                                color: Colors.blue,
                                size: 60,
                              ),
                              Colors.blue),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const AbsText(
                          displayString: "Teams", fontSize: 18, bold: true),
                      const SizedBox(height: 20),
                      for (int i = 0; i < assignedTeams.length; i++) ...[
                        Row(
                          children: [
                            Expanded(
                              child: AbsMinimalBox(
                                  child: Text(
                                assignedTeams[i].teamTitle,
                                style: TextStyle(
                                    decoration: deletedTeams
                                            .contains(assignedTeams[i].id!)
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationColor: Colors.red,
                                    decorationThickness: 3,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            const SizedBox(width: 10),
                            AbsIconButtonPrimary(
                                onPressed: () {
                                  if (deletedTeams
                                      .contains(assignedTeams[i].id!)) {
                                    setState(() {
                                      deletedTeams.remove(assignedTeams[i].id!);
                                    });
                                  } else {
                                    setState(() {
                                      deletedTeams.add(assignedTeams[i].id!);
                                    });
                                  }
                                },
                                icon: Icon(
                                  deletedTeams.contains(assignedTeams[i].id!)
                                      ? Icons.add
                                      : Icons.delete,
                                ))
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                      if (addedTeams.isNotEmpty) ...[
                        for (int i = 0; i < addedTeams.length; i++) ...[
                          Row(
                            children: [
                              Expanded(
                                child: AbsMinimalBox(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AbsText(
                                        displayString: addedTeams[i].teamTitle,
                                        fontSize: 16,
                                        bold: true),
                                    const Icon(
                                      Icons.fiber_new,
                                      color: Colors.blue,
                                      size: 28,
                                    ),
                                  ],
                                )),
                              ),
                              const SizedBox(width: 10),
                              AbsIconButtonPrimary(
                                  onPressed: () {
                                    setState(() {
                                      addedTeams.removeAt(i);
                                    });
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                          const SizedBox(height: 8),
                        ]
                      ],
                      Center(
                        child: AbsButtonSecondary(
                          roundedBorder: true,
                          onPressed: () async {
                            if (isLoadingTeams) {
                              await fetchTeams();
                            }

                            bool? saved = await showModalBottomSheet<bool>(
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder: (context) => StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        height: 300,
                                        width: double.maxFinite,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: allTeams.length,
                                          itemBuilder: (context, index) {
                                            var team = allTeams[index];
                                            bool contains =
                                                addedTeams.contains(team);
                                            return CheckboxListTile(
                                              activeColor:
                                                  Provider.of<ThemeProvider>(
                                                          context)
                                                      .headColor,
                                              title: AbsText(
                                                displayString: team.teamTitle,
                                                fontSize: 16,
                                                bold: true,
                                              ),
                                              value: contains,
                                              onChanged: (val) {
                                                setState(() {
                                                  if (contains) {
                                                    addedTeams.remove(team);
                                                  } else {
                                                    addedTeams.add(team);
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AbsButtonPrimary(
                                              onPressed: () {
                                                Navigator.pop(context,
                                                    true); // << Return value
                                              },
                                              text: "Save",
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  );
                                },
                              ),
                            );

                            if (saved == true) {
                              setState(
                                  () {}); // << Trigger rebuild of parent widget
                            }
                          },
                          text: "Assign New Team",
                          icon: const Icon(
                            Icons.add,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: AbsButtonPrimary(
                                  onPressed: confirmChanges,
                                  text: "Confirm Changes"))
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }
}
