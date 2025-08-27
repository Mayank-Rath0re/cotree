import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_feedpost.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Post> feed = [];
  late UserView myUserView;
  bool isLoading = true;

  void getFeed() async {
    var userview = await Constants().getOrSetUserView(context);
    List<Post> feedPosts =
        await client.recommendation.recommendPosts(userview.userId);
    // List<Post> feedPosts = await client.post.retrieveAllPosts();

    if (!mounted) return;
    setState(() {
      myUserView = userview;
      feed = feedPosts;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getFeed();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (feed.isEmpty) {
      return const SizedBox(
        height: 250,
        child: Center(
          child: AbsText(displayString: "No Posts Available!", fontSize: 28),
        ),
      );
    }

    return RefreshIndicator(
      color: Provider.of<ThemeProvider>(context).headColor,
      onRefresh: () async {
        getFeed();
      },
      child: ListView.builder(
        key: const PageStorageKey("feed-list"), // ✅ preserves scroll position
        itemCount: feed.length,
        itemBuilder: (context, index) {
          final post = feed[index];
          return Column(
            children: [
              AbsFeedpost(
                key: ValueKey(post.id), // ✅ stable key prevents rebuild jitter
                postData: post,
                myUserView: myUserView,
                onRemoved: () {
                  setState(() {
                    feed.removeAt(index);
                  });
                },
              ),
              const SizedBox(height: 2),
            ],
          );
        },
      ),
    );
  }
}
