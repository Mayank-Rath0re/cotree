import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_status_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/document_page.dart';
import 'package:cotree_flutter/pages/project_manage_page.dart';
import 'package:cotree_flutter/pages/taskboard_2.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatefulWidget {
  final int spaceId;
  final int projectId;
  final Member memberData;
  const ProjectPage(
      {super.key,
      required this.spaceId,
      required this.projectId,
      required this.memberData});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  late Project projectData;
  late List<Teams> teams;
  late List<Task> tasks;
  late List<Documents> documents;
  List<int> statusCount = [0, 0, 0];
  bool isLoading = true;

  void getBuildData() async {
    var projectInfo = await client.project.fetchProject(widget.projectId);
    var teamsData = await client.project.fetchProjectTeams([widget.projectId]);
    var taskData = await client.project.fetchTasks([widget.projectId]);
    var docData = await client.project.fetchDocuments(widget.projectId);
    setState(() {
      projectData = projectInfo;
      teams = teamsData;
      tasks = taskData;
      documents = docData;
      isLoading = false;
      statusCount[0] = taskData.where((t) => t.status == "To Do").length;
      statusCount[1] = taskData.where((t) => t.status == "In Progress").length;
      statusCount[2] = taskData.where((t) => t.status == "Completed").length;
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
        actions: [
          const SizedBox(width: 20),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProjectManagePage(projectData: projectData)));
              },
              icon: const Icon(Icons.manage_accounts))
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 45),
              GestureDetector(
                  /*
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Taskboard2(memberData: memberData, projectData: projectData)));
                  },*/
                  child: const AbsMinimalBox(
                      child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.task),
                  SizedBox(width: 10),
                  AbsText(displayString: "Taskboard", fontSize: 18)
                ],
              ))),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DocumentPage(
                                spaceId: widget.spaceId,
                                projectId: widget.projectId,
                                memberData: widget.memberData)));
                  },
                  child: const AbsMinimalBox(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.pages),
                      SizedBox(width: 10),
                      AbsText(displayString: "Documents", fontSize: 18)
                    ],
                  ))),
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AbsText(
                        displayString: "Project: ${projectData.projectTitle}",
                        fontSize: 20,
                        headColor: true,
                        bold: true,
                      ),
                      AbsStatusBox(text: projectData.status)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    projectData.projectOverview,
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const AbsText(
                      displayString: "Teams", fontSize: 18, bold: true),
                  const SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (int i = 0; i < teams.length; i++) ...[
                        AbsMinimalBox(
                            child: AbsText(
                                displayString: teams[i].teamTitle,
                                fontSize: 16,
                                bold: true))
                      ]
                    ],
                  ),
                  const SizedBox(height: 20),
                  const AbsText(
                    displayString: "Taskboard",
                    fontSize: 18,
                    bold: true,
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                          child: AbsMinimalBox(
                              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AbsText(
                              displayString: "In Progress",
                              fontSize: 16,
                              bold: true),
                          const SizedBox(height: 5),
                          AbsText(
                              displayString: "${statusCount[1]}",
                              fontSize: 20,
                              bold: true,
                              headColor: true)
                        ],
                      ))),
                      const SizedBox(width: 8),
                      Expanded(
                          child: AbsMinimalBox(
                              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AbsText(
                              displayString: "To Do", fontSize: 16, bold: true),
                          const SizedBox(height: 5),
                          AbsText(
                              displayString: "${statusCount[0]}",
                              fontSize: 20,
                              bold: true,
                              headColor: true)
                        ],
                      ))),
                      const SizedBox(width: 8),
                      Expanded(
                          child: AbsMinimalBox(
                              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AbsText(
                              displayString: "Completed",
                              fontSize: 16,
                              bold: true),
                          const SizedBox(height: 5),
                          AbsText(
                              displayString: "${statusCount[2]}",
                              fontSize: 20,
                              bold: true,
                              headColor: true)
                        ],
                      )))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: AbsButtonSecondary(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskboard2(
                                        memberData: widget.memberData,
                                        projectsData: [projectData],
                                      )));
                        },
                        text: "Go To Taskboard",
                        fontSize: 18,
                      ))
                    ],
                  ),
                  const AbsText(
                      displayString: "Documents", fontSize: 18, bold: true),
                  const SizedBox(height: 10),
                  if (documents.isEmpty) ...[
                    const AbsMinimalBox(
                        child: SizedBox(
                            height: 80,
                            child: Center(
                                child: AbsText(
                                    displayString: "No Documents Uploaded",
                                    fontSize: 18))))
                  ] else ...[
                    for (int i = 0; i < documents.length; i++) ...[
                      Row(
                        children: [
                          Expanded(
                            child: AbsMinimalBox(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AbsText(
                                  displayString: documents[i].title,
                                  fontSize: 14,
                                  bold: true,
                                ),
                                const SizedBox(height: 5),
                                AbsText(
                                    displayString:
                                        DateFormat("dd-MM-yyyy HH:mm")
                                            .format(documents[i].uploadedAt),
                                    fontSize: 12)
                              ],
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ]
                  ],
                  const SizedBox(height: 10),
                  const AbsText(
                      displayString: "Progress", fontSize: 18, bold: true),
                  const SizedBox(height: 10),
                  if (tasks.isEmpty) ...[
                    const AbsMinimalBox(
                        child: SizedBox(
                            height: 80,
                            child: Center(
                                child: AbsText(
                                    displayString: "No Tasks Created",
                                    fontSize: 18))))
                  ] else ...[
                    AbsText(
                        displayString:
                            "${tasks.where((t) => t.status == "Completed").length} of ${tasks.length} Tasks Completed",
                        fontSize: 15),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                        color: Provider.of<ThemeProvider>(context).headColor,
                        minHeight: 15,
                        value: statusCount[2] / tasks.length),
                  ]
                ],
              ),
            )),
    );
  }
}
