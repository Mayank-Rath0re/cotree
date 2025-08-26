import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_feedpost.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:flutter/material.dart';

class SeeAllPosts extends StatefulWidget {
  final UserView userview;
  const SeeAllPosts({super.key, required this.userview});

  @override
  State<SeeAllPosts> createState() => _SeeAllPostsState();
}

class _SeeAllPostsState extends State<SeeAllPosts> {
  bool isLoading = true;
  late List<Post> userPosts = [];

  void getBuildData() async {
    var posts = await client.post.fetchUserPosts(widget.userview.userId);
    setState(() {
      userPosts = posts;
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
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                for (var post in userPosts) ...[
                  AbsFeedpost(
                    postData: post,
                    myUserView: widget.userview,
                    onRemoved: () {
                      setState(() {
                        userPosts.remove(post);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: AbsText(
                              displayString: "Post Removed Successfully",
                              fontSize: 14)));
                    },
                  ),
                  const SizedBox(height: 6),
                ]
              ],
            ),
    );
  }
}
