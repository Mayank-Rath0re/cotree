import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/dm_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AbsChatTile extends StatefulWidget {
  final Chat chat;
  final UserView myUserView;
  AbsChatTile({super.key, required this.chat, required this.myUserView});

  @override
  State<AbsChatTile> createState() => _AbsChatTileState();
}

class _AbsChatTileState extends State<AbsChatTile> {
  late UserView userData;
  bool isLoading = true;

  void getBuildData() async {
    var viewData = await client.chat.fetchChatUserViews(widget.chat.id!);
    setState(() {
      userData = viewData.first.userId == widget.myUserView.userId
          ? viewData[1]
          : viewData.first;
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DmPage(
                    chat: widget.chat,
                    userId: userData.userId,
                    user: widget.myUserView)));
      },
      child: AbsMinimalBox(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  AbsAvatar(radius: 25, avatarUrl: userData.avatar),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AbsText(
                          displayString: userData.name,
                          fontSize: 18,
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton(
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                child: const AbsText(
                                    displayString: "Delete Chat", fontSize: 14))
                          ])
                ],
              ),
      ),
    );
  }
}
