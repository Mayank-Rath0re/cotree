import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_avatar.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';

class AbsCommentBox extends StatefulWidget {
  final Comment comment;
  final UserView commentUser;
  final int myUserId;
  final Function()? onLike;
  const AbsCommentBox(
      {super.key,
      required this.comment,
      required this.commentUser,
      required this.myUserId,
      required this.onLike});

  @override
  State<AbsCommentBox> createState() => _AbsCommentBoxState();
}

class _AbsCommentBoxState extends State<AbsCommentBox>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  bool _processing = false;
  double _likeScale = 1.0;

  void checkLiked() async {
    try {
      var reaction = await client.post
          .fetchReaction("C", widget.comment.id!, widget.commentUser.userId);
      if (!mounted) return;
      setState(() {
        isLiked = reaction != null ? true : false;
      });
    } catch (e) {
      // ignore - keep previous state if network fails
    }
  }

  @override
  void initState() {
    super.initState();
    checkLiked();
  }

  Future<void> _handleLike() async {
    if (_processing) return;
    setState(() {
      _processing = true;
      _likeScale = 1.2; // quick pop animation
    });

    // small animation pause for UX
    await Future.delayed(const Duration(milliseconds: 120));

    try {
      // Keep same API call as original code (type: 1). Backend controls idempotency.
      await client.post.updateReaction(
          widget.comment.id!, widget.comment.author, "C", widget.myUserId,
          type: 1);

      // refresh liked state from server
      checkLiked();

      // optional callback to parent
      widget.onLike?.call();
    } catch (e) {
      // swallow - you can add error handling / snackbar here
    }

    if (!mounted) return;
    setState(() {
      _likeScale = 1.0;
      _processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tp = Provider.of<ThemeProvider>(context);

    // Colors - use theme when available, fall back to provider where used previously
    final surfaceColor = theme.cardColor;
    final subtleBg = theme.brightness == Brightness.dark
        ? Colors.white10
        : Colors.grey.shade100;
    final contrastColor = tp.contrastColor;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: contrastColor.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          AbsAvatar(
            radius: 24,
            avatarUrl: widget.commentUser.avatar,
          ),

          const SizedBox(width: 12),

          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name, optional "you" badge and timestamp row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AbsText(
                            displayString: widget.commentUser.name,
                            fontSize: 15,
                            bold: true,
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),

                    // Timestamp (right aligned)
                    AbsText(
                      displayString: GetTimeAgo.parse(widget.comment.time),
                      fontSize: 12,
                    ),
                  ],
                ),

                // Comment bubble
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: subtleBg,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: AbsText(
                    displayString: widget.comment.text,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 8),

                // Action row: Like (animated), Reply placeholder, More menu
                Row(
                  children: [
                    // Animated Like icon
                    GestureDetector(
                      onTap: _handleLike,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: _likeScale),
                        duration: const Duration(milliseconds: 180),
                        builder: (context, scale, child) => Transform.scale(
                          scale: scale,
                          child: child,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isLiked
                                ? Colors.blue.withOpacity(0.12)
                                : Colors.transparent,
                          ),
                          child: Icon(
                            Icons.thumb_up,
                            size: 18,
                            color: isLiked ? Colors.blue : contrastColor,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Like label (small) - mirrors icon
                    AbsText(
                      displayString: isLiked ? 'Liked' : 'Like',
                      fontSize: 12,
                    ),

                    const SizedBox(width: 16),

                    // Reply button (visual only - hook into your reply flow as needed)
                    InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () {
                        // no-op: parent can wrap this widget and add reply handling
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 8.0),
                        child: Row(
                          children: const [
                            Icon(Icons.reply, size: 16),
                            SizedBox(width: 6),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Overflow menu (edit/delete when current user's comment)
                    PopupMenuButton<int>(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context) {
                        final items = <PopupMenuEntry<int>>[];
                        if (widget.commentUser.userId == widget.myUserId) {
                          items.add(const PopupMenuItem<int>(
                            value: 1,
                            child: Text('Edit'),
                          ));
                          items.add(const PopupMenuItem<int>(
                            value: 2,
                            child: Text('Delete'),
                          ));
                        } else {
                          items.add(const PopupMenuItem<int>(
                            value: 3,
                            child: Text('Report'),
                          ));
                        }
                        return items;
                      },
                      onSelected: (val) {
                        // parent can intercept via callback wiring - placeholder
                        if (val == 2) {
                          // delete
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.more_horiz, size: 18),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
