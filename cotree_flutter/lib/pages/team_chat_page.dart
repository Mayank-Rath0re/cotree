import 'dart:async';

import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

class TeamChatPage extends StatefulWidget {
  final Teams teamData;
  final Member memberData;
  const TeamChatPage(
      {super.key, required this.teamData, required this.memberData});

  @override
  State<TeamChatPage> createState() => _TeamChatPageState();
}

class _TeamChatPageState extends State<TeamChatPage> {
  TextEditingController messageController = TextEditingController();
  late List<Member> chatMembers;
  late List<Message> messageData;
  bool isLoading = true;

  Stream<List<Message>> get _chatMessages {
    final controller = StreamController<List<Message>>();
    final buffer = <Message>[];

    client.chat.messageStream(widget.teamData.chatId).listen(
      (msg) {
        buffer.add(msg);
        controller.add(List.from(buffer));
      },
      onError: controller.addError,
    );

    return controller.stream;
  }

  void _send() {
    var msg = Message(
      chatId: widget.teamData.chatId,
      senderId: widget.memberData.id!,
      content: messageController.text,
      sentAt: DateTime.now(),
    );
    setState(() {
      messageData.add(msg);
    });

    client.chat.sendMessage(widget.teamData.chatId, msg);
    messageController.clear();
  }

  Widget messageBuild(Message message) {
    if (message.senderId == widget.memberData.id) {
      //
      return Row(
        children: [
          const Expanded(child: Center()),
          Expanded(
              flex: 2,
              child: AbsMinimalBox(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsText(displayString: message.content, fontSize: 13),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AbsText(
                        displayString:
                            DateFormat("HH:mm").format(message.sentAt),
                        fontSize: 10,
                      )
                    ],
                  )
                ],
              ))),
        ],
      );
    } else {
      //
      var memview = chatMembers.where((t) => t.id == message.senderId).first;
      return Row(
        children: [
          Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbsAvatar(radius: 14, avatarUrl: memview.avatar),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: AbsMinimalBox(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AbsText(
                            displayString: memview.name,
                            fontSize: 14,
                            headColor: true),
                        const SizedBox(height: 3),
                        AbsText(displayString: message.content, fontSize: 13),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AbsText(
                              displayString:
                                  DateFormat("HH:mm").format(message.sentAt),
                              fontSize: 10,
                            )
                          ],
                        )
                      ],
                    )),
                  ),
                ],
              )),
          const Expanded(child: Center()),
        ],
      );
    }
  }

  Widget streamData() {
    return StreamBuilder<List<Message>>(
        stream: _chatMessages,
        builder: (c, snap) {
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final msgs = snap.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (_, i) {
              final m = msgs[i];
              return messageBuild(m);
            },
          );
        });
  }

  void getBuildData() async {
    var teamMembers = await client.team.fetchTeamMembers([widget.teamData.id!]);
    var messages = await client.chat
        .fetchChatMessages(widget.teamData.chatId, widget.memberData.userId);
    setState(() {
      messageData = messages;
      chatMembers = teamMembers;
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
        title: AbsText(
            displayString: widget.teamData.teamTitle, fontSize: 16, bold: true),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: messageData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        messageBuild(messageData[index]),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AbsMinimalBox(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 4,
                          child: AbsMultilineTextfield(
                              hintText: "message",
                              minLines: 1,
                              maxLines: 5,
                              controller: messageController)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              _send();
                            },
                            icon: const HeroIcon(HeroIcons.paperAirplane)),
                      )
                    ],
                  )),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
