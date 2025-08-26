import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/create_meeting_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MeetingsPage extends StatefulWidget {
  final int spaceId;
  final int memberId;
  final int teamId;
  const MeetingsPage(
      {super.key,
      required this.spaceId,
      required this.memberId,
      required this.teamId});

  @override
  State<MeetingsPage> createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> {
  bool isLoading = true;
  late List<Meetings> teamMeetings;

  void getBuildData() async {
    var meetings = await client.team.fetchMeetings([widget.teamId]);
    setState(() {
      teamMeetings = meetings;
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
        actions: [
          const SizedBox(width: 20),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateMeetingPage(
                            memberId: widget.memberId, teamId: widget.teamId)));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AbsText(
                      displayString: "Meetings", fontSize: 22, headColor: true),
                  const SizedBox(height: 10),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                        color: Provider.of<ThemeProvider>(context).mainColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.meeting_room,
                            size: 50,
                            color:
                                Provider.of<ThemeProvider>(context).headColor),
                        const SizedBox(height: 10),
                        const AbsText(
                            displayString: "No Meeting Live Right Now!",
                            fontSize: 18),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AbsButtonPrimary(
                                onPressed: () {}, text: "Start Meeting"),
                            AbsButtonSecondary(
                                onPressed: () {}, text: "Schedule Meeting")
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AbsText(
                      displayString: "Upcoming Meetings",
                      fontSize: 20,
                      headColor: true),
                  const SizedBox(height: 10),
                  if (teamMeetings.isEmpty) ...[
                    const Center(
                      child:
                          AbsText(displayString: "No Meetings", fontSize: 18),
                    )
                  ] else ...[
                    for (int i = 0; i < teamMeetings.length; i++) ...[
                      AbsMinimalBox(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AbsText(
                                    displayString: teamMeetings[i].agenda,
                                    fontSize: 18,
                                    bold: true),
                                const SizedBox(height: 5),
                                AbsText(
                                    displayString:
                                        DateFormat('dd-MM-yyyy HH:mm').format(
                                            teamMeetings[i].time.toLocal()),
                                    fontSize: 14),
                                const SizedBox(height: 5),
                                AbsText(
                                    displayString:
                                        "${teamMeetings[i].duration.inMinutes} min",
                                    fontSize: 14,
                                    headColor: true)
                              ],
                            ),
                          ),
                          AbsButtonSecondary(onPressed: () {}, text: "Join")
                        ],
                      )),
                      const SizedBox(height: 6)
                    ]
                  ],
                ],
              ),
      ),
    );
  }
}
