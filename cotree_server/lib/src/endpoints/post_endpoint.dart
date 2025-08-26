import 'dart:async';
import 'dart:typed_data';
import 'package:cotree_server/src/endpoints/notification_endpoint.dart';
import 'package:cotree_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PostEndpoint extends Endpoint {
  var notifyObj = NotificationEndpoint();
  // Create Post Functionality
  Future<void> createPost(Session session, int? authorId, String text,
      List<String> mediaList) async {
    // Create post object
    var postObject = Post(
        authorId: authorId!,
        text: text,
        media: mediaList,
        createdAt: DateTime.now());

    // Insert post object
    // ignore: unused_local_variable
    var postInsert = await Post.db.insertRow(session, postObject);
    // Notify connected users
    String slice = text.length > 50 ? "${text.substring(0, 50)}..." : text;
    // ignore: unawaited_futures
    notifyObj.notifyMyConnections(
        session, authorId, "posted: $slice", postInsert.id!, "post");
  }

  // Delete Post Functionality
  Future<void> deletePost(Session session, int? postId) async {
    // Find the post
    var postEntry = await Post.db.findById(session, postId!);
    // Delete the related comments & reactions
    // ignore: unused_local_variable
    var postReactions = await Reaction.db.deleteWhere(session,
        where: (t) =>
            t.reactableType.equals('P') & t.reactableId.equals(postId));
    var comments = await Comment.db
        .deleteWhere(session, where: (t) => t.responseToPost.equals(postId));
    // ignore: unused_local_variable
    var commentReactions = await Reaction.db.deleteWhere(session,
        where: (t) =>
            t.reactableType.equals('C') &
            t.reactableId.inSet(comments.map((comm) {
              return comm.id!;
            }).toSet()));
    // Delete the post
    // ignore: unused_local_variable
    var delete = await Post.db.deleteRow(session, postEntry!);
  }

  // Retrieve Posts Functionality
  // Retrieve all function for now (will be deleted in later stages)

  Future<List<Post>> retrieveAllPosts(Session session) async {
    // Get list of all posts
    List<Post> postsData = await Post.db.find(session);
    // Return postData
    return postsData;
  }

  // Retrieve Single Post Data
  Future<Post> retrievePost(Session session, int postId) async {
    Post? postData = await Post.db.findById(session, postId);
    return postData!;
  }

  Future<Post?> fetchLastUserPost(Session session, int userId) async {
    var posts = await Post.db.findFirstRow(session,
        where: (t) => t.authorId.equals(userId),
        orderBy: (t) => t.createdAt,
        orderDescending: true);
    return posts;
  }

  Future<List<Post>> fetchUserPosts(Session session, int userId) async {
    var posts = await Post.db.find(session,
        where: (t) => t.authorId.equals(userId),
        orderBy: (t) => t.createdAt,
        orderDescending: true);
    return posts;
  }

  // Comment on Post
  Future<Comment> uploadComment(Session session, int? postId, int? authorId,
      String text, String? media) async {
    // Create comment object
    var commentObj = Comment(
        responseToPost: postId!,
        author: authorId!,
        text: text,
        time: DateTime.now());
    // ignore: unused_local_variable
    var commentIns = await Comment.db.insertRow(session, commentObj);
    return commentIns;
  }

  // React to post
  // Two types: Reacting and unreacting
  // Front-end passes count of 1 for incrementing reaction by 1
  // count for -1 refers to unreacting updation

  Future<Reaction?> fetchReaction(
      Session session, String objectType, int objectId, int userId) async {
    var reaction = Reaction.db.findFirstRow(session,
        where: (t) =>
            t.reactableType.equals(objectType) &
            t.reactableId.equals(objectId) &
            t.userId.equals(userId));
    return reaction;
  }

  Future<int> fetchReactionCount(
      Session session, int objectId, String objectType) async {
    var reactionCount = await Reaction.db.count(session,
        where: (t) =>
            t.reactableType.equals(objectType) &
            t.reactableId.equals(objectId));
    return reactionCount;
  }

  Future<void> updateReaction(Session session, int objectId, int authorId,
      String reactablTtype, int? userId,
      {int type = 0}) async {
    var reactionType = reactablTtype == "P" ? "post" : "comment";
    var reactionObj =
        await fetchReaction(session, reactablTtype, objectId, userId!);
    if (reactionObj == null) {
      reactionObj = Reaction(
          userId: userId,
          reactableId: objectId,
          reactableType: reactablTtype,
          type: type);
      // ignore: unused_local_variable
      var reactionIns = await Reaction.db.insertRow(session, reactionObj);
      await notifyObj.createNotification(session, authorId,
          "Liked your $reactionType.", userId, objectId, reactionType);
    } else {
      // ignore: unused_local_variable
      var delReaction = Reaction.db.deleteRow(session, reactionObj);
    }
  }

  Future<List<Comment>> fetchComments(Session session, int postId) async {
    var comments = await Comment.db
        .find(session, where: (t) => t.responseToPost.equals(postId));
    return comments;
  }

  // delete post comment
  Future<void> deleteComment(Session session, int? commentId) async {
    // Find the comment
    var commentObj = await Comment.db.findById(session, commentId!);
    // Delete the comment
    // ignore: unused_local_variable
    var delComment = await Comment.db.deleteRow(session, commentObj!);
    // might need to be removed from the post object separately
    // otherwise, this can be left as-is.
  }

  // Filtering Options
  // To be created later.

  // File Upload
  Future<String> uploadFile(
      Session session, int userId, ByteData imageData, String filename) async {
    String path = "/user_files/${userId}_$filename";
    // ignore: unused_local_variable
    final file = await session.storage
        .storeFile(storageId: "public", path: path, byteData: imageData);
    final verify =
        await session.storage.fileExists(storageId: "public", path: path);
    if (verify) {
      print("File Uploaded Successfully");
      var uri =
          await session.storage.getPublicUrl(storageId: "public", path: path);
      return uri.toString();
    }
    return "";
  }
}
