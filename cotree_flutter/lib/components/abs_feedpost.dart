import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_feedimagebuild.dart';
import 'package:cotree_flutter/components/abs_org_avatar.dart';
import 'package:cotree_flutter/components/abs_richtext.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/pages/post_detailed_page.dart';
import 'package:cotree_flutter/pages/profile_page.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';

class AbsFeedpost extends StatefulWidget {
  final Post postData;
  final UserView myUserView;
  final bool showInteractionOptions;
  final bool goToDetailed;
  final Function()? onRemoved;
  const AbsFeedpost({
    super.key,
    required this.postData,
    required this.myUserView,
    this.onRemoved,
    this.showInteractionOptions = true,
    this.goToDetailed = true,
  });

  @override
  State<AbsFeedpost> createState() => _AbsFeedpostState();
}

class _AbsFeedpostState extends State<AbsFeedpost> {
  late UserView userData;
  late List<String> Urls;
  late int reactionCount;
  bool originallyLiked = false;
  bool isLiked = false;
  bool isLoading = true;
  Future<void> getAuthorData() async {
    UserView userInfo =
        await client.account.getUserView(widget.postData.authorId);
    var reactionInfo = await client.post
        .fetchReaction("P", widget.postData.id!, widget.myUserView.userId);
    var totalReaction =
        await client.post.fetchReactionCount(widget.postData.id!, "P");
    List<String> decodedUrls =
        widget.postData.media!.map((e) => Uri.decodeFull(e)).toList();

    if (mounted) {
      setState(() {
        userData = userInfo;
        Urls = decodedUrls;
        reactionCount = totalReaction;
        isLiked = reactionInfo != null ? true : false;
        originallyLiked = isLiked;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getAuthorData();
    super.initState();
  }

  @override
  void dispose() {
    if (isLiked != originallyLiked) {
      client.post.updateReaction(widget.postData.id!, widget.postData.authorId,
          "P", widget.myUserView.userId, widget.postData.id,
          type: 0);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (isLoading) ...[
        Container(
            constraints: const BoxConstraints(minHeight: 120),
            child: const Center(child: CircularProgressIndicator()))
      ] else ...[
        Expanded(
          flex: 7,
          child: GestureDetector(
              onTap: () {
                if (widget.goToDetailed) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostDetailedPage(
                              postId: widget.postData.id!,
                              userData: widget.myUserView,
                              onLiked: (val) {
                                setState(() {
                                  isLiked = val;
                                });
                              })));
                }
              },
              child: Container(
                  constraints: const BoxConstraints(
                      minHeight: 140, maxHeight: double.infinity),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Provider.of<ThemeProvider>(context).mainColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage(
                                              profileId:
                                                  widget.postData.authorId,
                                            )));
                              },
                              child: userData.accountType == "Individual"
                                  ? AbsAvatar(
                                      radius: 20,
                                      avatarUrl: userData.avatar,
                                    )
                                  : AbsOrgAvatar(
                                      radius: 18, avatarUrl: userData.avatar),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AbsText(
                                    displayString: userData.name,
                                    fontSize: 14,
                                    bold: true,
                                  ),
                                  Text(
                                    userData.headline,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(fontSize: 11),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            AbsText(
                                displayString:
                                    GetTimeAgo.parse(widget.postData.createdAt),
                                fontSize: 12),
                            if (widget.myUserView.userId ==
                                userData.userId) ...[
                              PopupMenuButton(
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                            onTap: () {
                                              client.post.deletePost(
                                                  widget.postData.id);
                                              widget.onRemoved!();
                                            },
                                            child: const AbsText(
                                                displayString: "Remove Post",
                                                fontSize: 14))
                                      ])
                            ]
                          ],
                        ),
                        const SizedBox(height: 10),
                        AbsRichtext(
                            displayString: widget.postData.text, fontSize: 13),
                        //AbsText(
                        //    displayString: widget.postData.text, fontSize: 13),
                        const SizedBox(height: 5),
                        if (widget.postData.media!.isNotEmpty) ...[
                          SizedBox(
                              height: widget.showInteractionOptions ? 320 : 400,
                              child: AbsFeedimagebuild(
                                  imageUrls: widget.postData.media!))
                        ],
                        Divider(
                          thickness: 0.5,
                          color: Provider.of<ThemeProvider>(context)
                              .secondaryColor,
                        ),
                        Row(children: [
                          AbsText(
                            displayString: "$reactionCount",
                            fontSize: 13,
                            headColor: true,
                            bold: true,
                          ),
                          const AbsText(displayString: "  Likes", fontSize: 13)
                        ])
                      ],
                    ),
                  ))),
        ),
        if (widget.showInteractionOptions) ...[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                      if (isLiked) {
                        reactionCount += 1;
                      } else {
                        reactionCount -= 1;
                      }
                    });
                  },
                  icon: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Provider.of<ThemeProvider>(context).mainColor),
                      child: Icon(Icons.thumb_up_rounded,
                          size: 18,
                          color: isLiked
                              ? Colors.blue
                              : Provider.of<ThemeProvider>(context)
                                  .contrastColor))),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostDetailedPage(
                                postId: widget.postData.id!,
                                userData: userData,
                                onLiked: (val) {
                                  setState(() {
                                    isLiked = val;
                                  });
                                },
                              )));
                },
                icon: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Provider.of<ThemeProvider>(context).mainColor),
                    child: const Icon(Icons.mode_comment, size: 18)),
              ),
              //const SizedBox(height: 5),
              IconButton(
                  onPressed: () {},
                  icon: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Provider.of<ThemeProvider>(context).mainColor),
                      child: const Icon(Icons.send_rounded, size: 18)))
            ],
          ),
        ],
      ],
    ]));
  }
}
