import 'package:cotree_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class RecommendationEndpoint extends Endpoint {
  // 1. Recommended Posts
  Future<List<Post>> recommendPosts(Session session, int userId) async {
    final posts = await Post.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 50,
    );

    // Add recency boost
    posts.sort(
        (a, b) => _timeDecay(b.createdAt).compareTo(_timeDecay(a.createdAt)));
    return posts;
  }

  // 2. Recommended Offers
  Future<List<Offers>> recommendOffers(Session session, int userId) async {
    final user = await User.db.findById(session, userId);
    if (user == null) return [];

    final accountType = user.accountType.toLowerCase();
    final offers = await Offers.db.find(
      session,
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: 50,
    );

    // Score based on account type
    offers.sort((a, b) {
      final aScore = (accountType == "individual" ? 5 : 1) + _randomBoost();
      final bScore = (accountType == "individual" ? 5 : 1) + _randomBoost();
      return bScore.compareTo(aScore);
    });

    return offers;
  }

  // 3. Recommended Organizations
  Future<List<Organization>> recommendOrganizations(
      Session session, int userId) async {
    final orgs = await Organization.db.find(session, limit: 50);

    orgs.sort((a, b) {
      final aScore = (a.jobOpenings.isNotEmpty ? 3 : 1) + _randomBoost();
      final bScore = (b.jobOpenings.isNotEmpty ? 3 : 1) + _randomBoost();
      return bScore.compareTo(aScore);
    });

    return orgs;
  }

  Future<List<UserView>> recommendUsers(Session session, int userId,
      {int limit = 20}) async {
    // 1. Get the requesting user's connections & pending requests
    var connect = await Connect.db.findFirstRow(
      session,
      where: (t) => t.accountId.equals(userId),
    );

    var excludeIds = <int>{};
    if (connect != null) {
      excludeIds.addAll(connect.activeConnections);
      var invites = await Invitation.db.find(session,
          where: (t) =>
              t.sender.equals(userId) |
              (t.receiver.equals(userId) & t.isRejected.equals(false)));
      for (var invite in invites) {
        if (invite.sender == userId) {
          excludeIds.add(invite.receiver);
          continue;
        } else {
          excludeIds.add(invite.sender);
          continue;
        }
      }
    }

    excludeIds.add(userId); // Don’t recommend self

    // 2. Fetch candidates from UserView
    var candidates = await UserView.db.find(
      session,
      where: (t) => t.userId.notInSet(excludeIds),
      limit: limit,
    );

    return candidates;
  }

  // Helper: recency score
  int _timeDecay(DateTime createdAt) {
    final days = DateTime.now().difference(createdAt).inDays;
    return days < 7 ? (7 - days) : 0;
  }

  // Helper: tiny randomness to vary results
  int _randomBoost() {
    return DateTime.now().millisecondsSinceEpoch % 3; // 0–2 points
  }
}
