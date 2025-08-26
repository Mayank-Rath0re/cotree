import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_datepicker.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatefulWidget {
  final Project projectData;
  const CreateTaskPage({super.key, required this.projectData});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  List<Member> selectedOptions = [];
  Task task = Task(projectId: 0, taskName: "", status: "To Do");
  bool isLoading = true;
  List<Member> memberViews = [];

  void getBuildData() async {
    var memViews =
        await client.project.fetchProjectMembers(widget.projectData.id!);
    setState(() {
      memberViews = memViews;
      isLoading = false;
    });
  }

  void onSubmit() async {
    task.taskName = _titleController.text;
    task.projectId = widget.projectData.id!;
    task.deadline = _selectedDate;

    if (task.taskName.isNotEmpty &&
        task.projectId != 0 &&
        task.deadline != null) {
      var createdTask = client.project.createTask(
          task,
          selectedOptions.map((member) {
            return member.id!;
          }).toList());
      Navigator.pop(context, createdTask);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
    }
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const AbsText(
                displayString: "CREATE TASK", fontSize: 22, headColor: true),
            const SizedBox(height: 20),
            Row(
              children: [
                const AbsText(displayString: "Project: ", fontSize: 18),
                AbsText(
                    displayString: widget.projectData.projectTitle,
                    fontSize: 18,
                    bold: true),
              ],
            ),
            const SizedBox(height: 20),
            AbsTextfield(hintText: "Task Title", controller: _titleController),
            const SizedBox(height: 10),
            const AbsText(
                displayString: "Status", fontSize: 18, headColor: true),
            const SizedBox(height: 7),
            Wrap(
              spacing: 12,
              children: ['To Do', 'In Progress', 'Completed'].map((status) {
                final isSelected = task.status == status;
                return ChoiceChip(
                  label: Text(status),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      task.status = status;
                    });
                  },
                  selectedColor: Provider.of<ThemeProvider>(context).headColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            const AbsText(
                displayString: "Deadline", fontSize: 18, headColor: true),
            const SizedBox(height: 7),
            AbsDatepicker(onDatePicked: (date) {
              setState(() {
                task.deadline = date;
              });
            }),
            const SizedBox(height: 10),
            const AbsText(
                displayString: "Assigned Members",
                fontSize: 18,
                headColor: true),
            const SizedBox(height: 7),
            Container(
              constraints: const BoxConstraints(maxHeight: 350),
              child: ListView(
                children: memberViews.map((option) {
                  return CheckboxListTile(
                    checkColor: Provider.of<ThemeProvider>(context).headColor,
                    title: Row(
                      children: [
                        AbsAvatar(radius: 20, avatarUrl: option.avatar),
                        const SizedBox(width: 10),
                        AbsText(displayString: option.name, fontSize: 18),
                      ],
                    ),
                    value: selectedOptions.contains(option),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedOptions.add(option);
                        } else {
                          selectedOptions.remove(option);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            AbsButtonPrimary(onPressed: onSubmit, text: "Create Task")
          ],
        ),
      ),
    );
  }
}
