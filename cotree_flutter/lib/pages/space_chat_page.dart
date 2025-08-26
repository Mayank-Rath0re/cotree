import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/pages/team_chat_page.dart';
import 'package:flutter/material.dart';

class SpaceChatPage extends StatefulWidget {
  final List<Teams> teams;
  final Member memberData;
  const SpaceChatPage(
      {super.key, required this.teams, required this.memberData});

  @override
  State<SpaceChatPage> createState() => _SpaceChatPageState();
}

class _SpaceChatPageState extends State<SpaceChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AbsText(
                  displayString: "Inbox",
                  fontSize: 20,
                  headColor: true,
                  bold: true,
                ),
                const SizedBox(height: 20),
                for (int i = 0; i < widget.teams.length; i++) ...[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeamChatPage(
                                    teamData: widget.teams[i],
                                    memberData: widget.memberData)));
                      },
                      child: AbsMinimalBox(
                          child: Row(
                        children: [
                          AbsText(
                              displayString: widget.teams[i].teamTitle,
                              fontSize: 18,
                              bold: true)
                        ],
                      ))),
                  const SizedBox(height: 6),
                ]
              ],
            ),
          ),
        ));
  }
}
