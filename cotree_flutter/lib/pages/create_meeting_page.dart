import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateMeetingPage extends StatefulWidget {
  final int memberId;
  final int teamId;
  const CreateMeetingPage(
      {super.key, required this.memberId, required this.teamId});

  @override
  State<CreateMeetingPage> createState() => _CreateMeetingPageState();
}

class _CreateMeetingPageState extends State<CreateMeetingPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  bool selectAll = true;
  List<Member> selectedOptions = [];
  DateTime? selectedDate;
  Duration selectedDuration = const Duration(minutes: 45);
  bool isLoading = true;
  late List<Member> memberViews;

  void getBuildData() async {
    var memview = await client.team.fetchTeamMembers([widget.teamId]);
    setState(() {
      memberViews = memview;
      isLoading = false;
    });
  }

  Future<void> _pickDeadline() async {
    final result = await showBoardDateTimePicker(
      isDismissible: false,
      enableDrag: false,
      options: BoardDateTimeOptions(
          activeColor:
              Provider.of<ThemeProvider>(context, listen: false).headColor),
      context: context,
      pickerType: DateTimePickerType.datetime,
      initialDate: DateTime.now(),
    );
    if (result != null) {
      setState(() {
        selectedDate = result;
      });
    }
  }

  void onSubmit() async {
    if (titleController.text.isNotEmpty &&
        selectedDate != null &&
        (selectAll || selectedOptions.isNotEmpty)) {
      String status = "";
      if (selectedDate!.isAfter(DateTime.now())) {
        status = "scheduled";
      } else {
        status = "";
      }
      // ignore: unused_local_variable
      var createMeeting = await client.team.createMeeting(
          widget.teamId,
          titleController.text,
          urlController.text,
          selectedDate!,
          selectedDuration,
          status,
          widget.memberId,
          selectAll
              ? memberViews.map((member) {
                  return member.id!;
                }).toList()
              : selectedOptions.map((member) {
                  return member.id!;
                }).toList());
      Navigator.pop(context);
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
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AbsText(
                  displayString: "CREATE NEW MEETING",
                  fontSize: 22,
                  headColor: true),
              const SizedBox(height: 20),
              AbsTextfield(hintText: "title", controller: titleController),
              const SizedBox(height: 10),
              AbsTextfield(hintText: "meet link", controller: urlController),
              const SizedBox(height: 10),
              const AbsText(displayString: "Select Date", fontSize: 16),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () async {
                    _pickDeadline();
                  },
                  child: AbsMinimalBox(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AbsText(
                          displayString: selectedDate == null
                              ? "Select Date"
                              : DateFormat('dd-MM-yyyy HH:mm')
                                  .format(selectedDate!),
                          fontSize: 18),
                      const Icon(Icons.calendar_today_outlined)
                    ],
                  ))),
              const SizedBox(height: 10),
              const AbsText(displayString: "Duration", fontSize: 16),
              const SizedBox(height: 10),
              Center(
                child: DurationPicker(
                  duration: selectedDuration,
                  lowerBound: const Duration(minutes: 15),
                  upperBound: const Duration(days: 1),
                  baseUnit: BaseUnit.minute,
                  onChange: (newDuration) {
                    setState(() => selectedDuration = newDuration);
                  },
                ),
              ),
              const SizedBox(height: 10),
              const AbsText(
                  displayString: "Invited Members",
                  fontSize: 18,
                  headColor: true),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AbsText(
                      displayString: "Invite all from team", fontSize: 16),
                  Switch(
                      value: selectAll,
                      onChanged: (val) {
                        setState(() {
                          selectAll = !selectAll;
                        });
                      })
                ],
              ),
              if (!selectAll) ...[
                Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: ListView(
                    children: memberViews.map((option) {
                      return CheckboxListTile(
                        checkColor:
                            Provider.of<ThemeProvider>(context).headColor,
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
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: AbsButtonPrimary(
                          onPressed: onSubmit, text: "Create Task")),
                ],
              )
            ],
          ),
        )));
  }
}
