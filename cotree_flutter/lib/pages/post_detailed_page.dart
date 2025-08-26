import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_secondary.dart';
import 'package:cotree_flutter/components/abs_comment_box.dart';
import 'package:cotree_flutter/components/abs_feedpost.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PostDetailedPage extends StatefulWidget {
  final int postId;
  bool isLiked;
  final UserView userData;
  final Function(bool)? onLiked;
  PostDetailedPage(
      {super.key,
      required this.postId,
      required this.userData,
      required this.isLiked,
      required this.onLiked});

  @override
  State<PostDetailedPage> createState() => _PostDetailedPageState();
}

class _PostDetailedPageState extends State<PostDetailedPage> {
  TextEditingController commentController = TextEditingController();
  late Post postData;
  late List<Comment> comments;
  late List<UserView> commentUsers;
  late Reaction? reaction;
  late int reactionCount;
  bool isLoading = true;

  Future<void> getPostData() async {
    List<UserView> commenters = [];
    Post postInfo = await client.post.retrievePost(widget.postId);
    var reactionInfo = await client.post
        .fetchReaction("P", widget.postId, widget.userData.userId);
    var commentsInfo = await client.post.fetchComments(widget.postId);
    var totalReaction =
        await client.post.fetchReactionCount(widget.postId, "P");
    for (int i = 0; i < commentsInfo.length; i++) {
      UserView userData =
          await client.account.getUserView(commentsInfo[i].author);
      commenters.add(userData);
    }
    setState(() {
      postData = postInfo;
      commentUsers = commenters;
      comments = commentsInfo;
      reactionCount = totalReaction;
      reaction = reactionInfo;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getPostData();
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
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              if (isLoading) ...[
                Center(
                    child: CircularProgressIndicator(
                  color: Provider.of<ThemeProvider>(context).contrastColor,
                ))
              ] else ...[
                AbsFeedpost(
                  postData: postData,
                  myUserView: widget.userData,
                  showInteractionOptions: false,
                  goToDetailed: false,
                  onRemoved: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const AbsText(
                            displayString:
                                "Post Deleted. Refresh to see changes.",
                            fontSize: 14,
                            bold: true)));
                  },
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          client.post.updateReaction(postData.id!,
                              postData.authorId, "P", widget.userData.userId,
                              type: 1);
                          setState(() {
                            widget.isLiked = !widget.isLiked;
                            if (widget.isLiked) {
                              reactionCount += 1;
                            } else {
                              reactionCount -= 1;
                            }
                          });
                          widget.onLiked!(widget.isLiked);
                        },
                        icon: AbsMinimalBox(
                            child: Icon(Icons.thumb_up_rounded,
                                size: 18,
                                color: widget.isLiked
                                    ? Colors.blue
                                    : Provider.of<ThemeProvider>(context)
                                        .contrastColor))),
                  ],
                ),
                const SizedBox(height: 10),
                const AbsText(displayString: "  Comments", fontSize: 16),
                const SizedBox(height: 10),
                AbsMultilineTextfield(
                  hintText: "write something...",
                  controller: commentController,
                  minLines: 1,
                  maxLines: 4,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AbsButtonSecondary(
                      onPressed: () async {
                        var comment = await client.post.uploadComment(
                            postData.id,
                            widget.userData.userId,
                            commentController.text,
                            "");
                        setState(() {
                          comments.add(comment);
                          commentUsers.add(widget.userData);
                          commentController.clear();
                        });
                      },
                      fontSize: 18,
                      text: "Post",
                    )
                  ],
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < comments.length; i++) ...[
                  AbsCommentBox(
                    comment: comments[i],
                    commentUser: commentUsers[i],
                    myUserId: widget.userData.userId,
                    onLike: () {
                      setState(() {});
                    },
                  ),
                ]
              ]
            ],
          ),
        ));
  }
}
