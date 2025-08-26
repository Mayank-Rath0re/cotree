import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_empty_box.dart';
import 'package:cotree_flutter/components/abs_facepile.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_searchbar.dart';
import 'package:cotree_flutter/components/abs_status_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/create_task_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Taskboard2 extends StatefulWidget {
  final Member memberData;
  final List<Project> projectsData;
  final int accessMode;
  const Taskboard2(
      {super.key,
      required this.memberData,
      required this.projectsData,
      this.accessMode = 1});

  @override
  State<Taskboard2> createState() => _Taskboard2State();
}

class _Taskboard2State extends State<Taskboard2>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  late List<Task> tasks = [];
  late List<Member> memViews = [];
  final List<String> statusOptions = ["To Do", "In Progress", "Completed"];
  final List<String> deadlineOptions = [
    "All Time",
    "Today",
    "This week",
    "This month",
    "This year"
  ];
  String selectedDeadline = "All Time";
  List<bool> selectedStatus = [true, true, true];
  List<int> peopleOptions = [];
  bool showStatusOptions = false;
  bool showDeadlineOptions = false;
  bool showPeopleOptions = false;

  void getBuildData() async {
    List<Task> tasksObj = [];
    List<int> projIds = widget.projectsData.map((proj) {
      return proj.id!;
    }).toList();
    List<Teams> teams = await client.project.fetchProjectTeams(projIds);
    List<int> teamIds = teams.map((team) {
      return team.id!;
    }).toList();
    var members = await client.team.fetchTeamMembers(teamIds);
    if (widget.accessMode == 0) {
      tasksObj = await client.project.fetchMemberTasks(widget.memberData.id!);
    } else {
      tasksObj = await client.project.fetchTasks(projIds);
    }

    setState(() {
      memViews = members;
      peopleOptions = memViews.map((m) => m.id!).toList();
      tasks = tasksObj;
      isLoading = false;
    });
  }

  void updateStatus(Task task, String newStatus) async {
    task.status = newStatus;
    // ignore: unused_local_variable
    var updateTask = client.project.updateTask(task);
  }

  String getProjectName(Task task) {
    var project =
        widget.projectsData.where((t) => t.id! == task.projectId).first;
    return project.projectTitle;
  }

  Widget taskCard(final Task taskData, final String projectName) {
    return AbsMinimalBox(
        child: IntrinsicHeight(
            child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AbsText(
                displayString: taskData.taskName,
                fontSize: 18,
                bold: true,
              ),
              const SizedBox(height: 5),
              AbsText(
                  displayString: projectName, fontSize: 16, headColor: true),
              const SizedBox(height: 5),
              Row(
                children: [
                  const AbsText(
                      displayString: "Deadline: ", fontSize: 14, bold: true),
                  AbsText(
                      displayString: DateFormat("dd/MM/yyyy HH:mm")
                          .format(taskData.deadline!),
                      fontSize: 14,
                      bold: true,
                      headColor: true),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const AbsText(displayString: "Assigned to: ", fontSize: 16),
                  const SizedBox(width: 8),
                  AbsFacepile(
                      radius: 20,
                      spacing: 30,
                      images: taskData.assigned!.map((assignee) {
                        var url = memViews
                            .where((t) => t.id == assignee.memberId)
                            .first
                            .avatar;
                        return url;
                      }).toList())
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AbsStatusBox(text: taskData.status),
              const SizedBox(height: 10),
              if (widget.memberData.globalRole != "Member" ||
                  taskData.assigned!.contains(TaskAssigned(
                      taskId: taskData.id!,
                      memberId: widget.memberData.id!))) ...[
                PopupMenuButton(itemBuilder: (context) {
                  return <PopupMenuEntry>[
                    if (widget.memberData.globalRole != "Member") ...[
                      PopupMenuItem(
                          onTap: () {},
                          child: const AbsText(
                              displayString: "Edit Task", fontSize: 14)),
                      PopupMenuItem(
                          onTap: () {},
                          child: const AbsText(
                              displayString: "Delete Task", fontSize: 14)),
                    ],
                    if (taskData.status != "To Do") ...[
                      PopupMenuItem(
                          onTap: () async {
                            setState(() {
                              taskData.status = "To Do";
                            });
                            client.project.updateTask(taskData);
                          },
                          child: const AbsText(
                              displayString: "Mark To Do", fontSize: 14))
                    ],
                    if (taskData.status != "In Progress") ...[
                      PopupMenuItem(
                          onTap: () async {
                            setState(() {
                              taskData.status = "In Progress";
                            });
                            client.project.updateTask(taskData);
                          },
                          child: const AbsText(
                              displayString: "Mark In Progress", fontSize: 14))
                    ],
                    if (taskData.status != "Completed") ...[
                      PopupMenuItem(
                          onTap: () async {
                            setState(() {
                              taskData.status = "Completed";
                            });
                            client.project.updateTask(taskData);
                          },
                          child: const AbsText(
                              displayString: "Mark Completed", fontSize: 14))
                    ]
                  ];
                }),
              ]
            ],
          ),
        )
      ],
    )));
  }

  void navigateToCreate() {
    showModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const AbsText(
                        displayString: "Select Project",
                        fontSize: 20,
                        headColor: true),
                    const SizedBox(
                      height: 10,
                    ),
                    for (int i = 0; i < widget.projectsData.length; i++) ...[],
                    ListView(
                      shrinkWrap: true,
                      children: widget.projectsData.map((project) {
                        return GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            final createdTask = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CreateTaskPage(projectData: project),
                              ),
                            );

                            if (createdTask != null) {
                              setState(() {
                                tasks.add(createdTask);
                              });
                            }
                          },
                          child: Column(
                            children: [
                              AbsMinimalBox(
                                child: AbsText(
                                  displayString: project.projectTitle,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ));
  }

  // Returns the filtered list of tasks based on current filters
  List<Task> getFilteredTasks() {
    // Status filter
    final activeStatuses = [
      for (int i = 0; i < statusOptions.length; i++)
        if (selectedStatus[i]) statusOptions[i]
    ];

    // Deadline filter
    DateTime? deadlineStart;
    DateTime? deadlineEnd;
    final now = DateTime.now();
    switch (selectedDeadline) {
      case "Today":
        deadlineStart = DateTime(now.year, now.month, now.day);
        deadlineEnd = deadlineStart.add(const Duration(days: 1));
        break;
      case "This week":
        final weekDay = now.weekday;
        deadlineStart = now.subtract(Duration(days: weekDay - 1));
        deadlineEnd = deadlineStart.add(const Duration(days: 7));
        break;
      case "This month":
        deadlineStart = DateTime(now.year, now.month, 1);
        deadlineEnd = DateTime(now.year, now.month + 1, 1);
        break;
      case "This year":
        deadlineStart = DateTime(now.year, 1, 1);
        deadlineEnd = DateTime(now.year + 1, 1, 1);
        break;
      case "All Time":
      default:
        deadlineStart = null;
        deadlineEnd = null;
    }

    // People filter
    final selectedPeople = peopleOptions;
    // If no people are selected, show no tasks
    if (showPeopleOptions && selectedPeople.isEmpty) {
      return [];
    }

    // Search filter
    final search = searchController.text.trim().toLowerCase();

    return tasks.where((task) {
      // Status
      if (!activeStatuses.contains(task.status)) return false;
      // Deadline
      if (deadlineStart != null && deadlineEnd != null) {
        if (task.deadline == null ||
            task.deadline!.isBefore(deadlineStart) ||
            task.deadline!
                .isAfter(deadlineEnd.subtract(const Duration(seconds: 1)))) {
          return false;
        }
      }
      // People
      if (selectedPeople.isNotEmpty) {
        final assignedIds =
            task.assigned?.map((a) => a.memberId).toList() ?? [];
        if (!assignedIds.any((id) => selectedPeople.contains(id))) {
          return false;
        }
      }
      // Search
      if (search.isNotEmpty) {
        final taskName = task.taskName.toLowerCase();
        final projectName = getProjectName(task).toLowerCase();
        if (!taskName.contains(search) && !projectName.contains(search)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  @override
  void initState() {
    getBuildData();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AbsText(
            displayString: widget.accessMode == 0
                ? "My Taskboard"
                : widget.projectsData[0].projectTitle,
            fontSize: 20,
            bold: true),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: navigateToCreate,
              icon: Icon(Icons.add,
                  color: Provider.of<ThemeProvider>(context).headColor))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
              ? const AbsEmptyBox()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AbsSearchbar(
                            controller: searchController,
                            onChanged: (val) {
                              setState(
                                  () {}); // This will rebuild and apply filter
                            },
                            onSubmitted: (val) {
                              setState(() {}); // Also rebuild on submit
                            }),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: AbsButtonSecondary(
                              onPressed: () {
                                setState(() {
                                  showStatusOptions = !showStatusOptions;
                                });
                              },
                              text: "Status",
                              fontSize: 16,
                            )),
                            const SizedBox(width: 5),
                            Expanded(
                                child: AbsButtonSecondary(
                              onPressed: () {
                                setState(() {
                                  showDeadlineOptions = !showDeadlineOptions;
                                });
                              },
                              text: "Deadline",
                              fontSize: 16,
                            )),
                            const SizedBox(width: 5),
                            Expanded(
                                child: AbsButtonSecondary(
                              onPressed: () {
                                print(memViews);
                                setState(() {
                                  showPeopleOptions = !showPeopleOptions;
                                });
                              },
                              text: "People",
                              fontSize: 16,
                            )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (showStatusOptions) ...[
                          AbsMinimalBox(
                              roundedBorder: true,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (int i = 0;
                                      i < statusOptions.length;
                                      i++) ...[
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedStatus[i] =
                                                !selectedStatus[i];
                                          });
                                        },
                                        child: AbsText(
                                          displayString: statusOptions[i],
                                          fontSize: 14,
                                          headColor:
                                              selectedStatus[i] ? true : false,
                                        )),
                                  ]
                                ],
                              )),
                          const SizedBox(height: 5)
                        ],
                        if (showDeadlineOptions) ...[
                          AbsMinimalBox(
                              roundedBorder: true,
                              child: Wrap(
                                spacing: 5,
                                runSpacing: 10,
                                alignment: WrapAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < deadlineOptions.length;
                                      i++) ...[
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedDeadline =
                                                deadlineOptions[i];
                                          });
                                        },
                                        child: AbsText(
                                          displayString: deadlineOptions[i],
                                          fontSize: 14,
                                          headColor: selectedDeadline ==
                                                  deadlineOptions[i]
                                              ? true
                                              : false,
                                        )),
                                  ]
                                ],
                              )),
                          const SizedBox(height: 5)
                        ],
                        if (showPeopleOptions) ...[
                          AbsMinimalBox(
                            roundedBorder: true,
                            child: Builder(
                              builder: (context) {
                                final memList = memViews
                                    .toList(); // Convert Set to List once
                                return Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 5,
                                  runSpacing: 10,
                                  children:
                                      List.generate(memList.length, (index) {
                                    final mem = memList[index];
                                    final isSelected =
                                        peopleOptions.contains(mem.id);

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            peopleOptions.remove(mem.id);
                                          } else {
                                            peopleOptions.add(mem.id!);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? Provider.of<ThemeProvider>(
                                                      context)
                                                  .headColor
                                              : Provider.of<ThemeProvider>(
                                                      context)
                                                  .secondaryColor,
                                        ),
                                        child: AbsAvatar(
                                          radius: 24,
                                          avatarUrl: mem.avatar,
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                        const Divider(),
                        const SizedBox(height: 10),
                        for (final task in getFilteredTasks()) ...[
                          taskCard(task, getProjectName(task)),
                          const SizedBox(height: 6),
                        ]
                      ],
                    ),
                  ),
                ),
    );
  }
}
