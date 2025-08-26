import 'package:cotree_server/src/endpoints/notification_endpoint.dart';
import 'package:cotree_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ConnectionEndpoint extends Endpoint {
  var notifObj = NotificationEndpoint();
  // Get Connect Data of a User
  Future<Connect> fetchConnectData(Session session, int? userId) async {
    var connectObj = await Connect.db
        .find(session, where: (t) => t.accountId.equals(userId));
    return connectObj[0];
  }

  Future<int> isConnection(
      Session session, int userId, int secondaryUserId) async {
    var connectObj = await Connect.db
        .find(session, where: (t) => t.accountId.equals(userId));
    if (connectObj[0].activeConnections.contains(secondaryUserId)) {
      // Account is Connected
      return 1;
    }
    for (int i = 0; i < connectObj[0].sentPending!.length; i++) {
      if (connectObj[0].sentPending![i].user == secondaryUserId) {
        // Account is Pending
        return 2;
      }
    }
    for (int i = 0; i < connectObj[0].receivedPending!.length; i++) {
      // Account has received request from this profile
      if (connectObj[0].receivedPending![i].user == secondaryUserId) {
        return 3;
      }
    }
    // Account is completely stranger
    return 0;
  }

  // Send Request
  Future<void> sendConnectionRequest(Session session, int? senderId,
      int? receiverId, String? personalText) async {
    // Update details for the first user
    var firstUserConnect = await Connect.db
        .find(session, where: (t) => t.accountId.equals(senderId));
    var inviteSend = Invitation(user: receiverId!, type: "Sent");
    if (firstUserConnect[0].sentPending == null) {
      firstUserConnect[0].sentPending = [inviteSend];
    } else {
      firstUserConnect[0].sentPending!.add(inviteSend);
    }
    // Connection Request updation for the second user
    var secondUserConnect = await Connect.db
        .find(session, where: (t) => t.accountId.equals(receiverId));
    var invite = Invitation(
        user: senderId!, type: "Received", personalText: personalText);
    if (secondUserConnect[0].receivedPending == null) {
      secondUserConnect[0].receivedPending = [invite];
    } else {
      secondUserConnect[0].receivedPending!.add(invite);
    }
    // Push the changes to database
    // ignore: unused_local_variable
    var updateData = await Connect.db
        .update(session, [firstUserConnect[0], secondUserConnect[0]]);
    // ignore: unawaited_futures
    notifObj.createNotification(session, receiverId,
        "sent you a connection request", senderId, senderId, "profile");
  }

  Future<List<Invitation>> removeInvite(
      List<Invitation>? data, int? accountId) async {
    for (int i = 0; i < data!.length; i++) {
      if (data[i].user == accountId) {
        data.removeAt(i);
        break;
      }
    }
    return data;
  }

  Future<Invitation?> getInviteData(
      Session session, int receiverId, int secondaryId) async {
    var connectData = await Connect.db
        .find(session, where: (t) => t.accountId.equals(receiverId));
    for (int i = 0; i < connectData[0].receivedPending!.length; i++) {
      if (connectData[0].receivedPending![i].user == secondaryId) {
        return connectData[0].receivedPending![i];
      }
    }
    return null;
  }

  // Send Confirmation
  Future<void> confirmConnection(
      Session session, int? receiverId, Invitation invite) async {
    // Update active connections for both users
    var firstUserData = await Connect.db
        .find(session, where: (t) => t.accountId.equals(invite.user));
    var secondUserData = await Connect.db
        .find(session, where: (t) => t.accountId.equals(receiverId));
    firstUserData[0].activeConnections.add(receiverId!);
    secondUserData[0].activeConnections.add(invite.user);
    // Remove Invitation data for both user
    firstUserData[0].sentPending =
        await removeInvite(firstUserData[0].sentPending, receiverId);
    secondUserData[0].receivedPending =
        await removeInvite(secondUserData[0].receivedPending, invite.user);
    // Push updated data to database
    // ignore: unused_local_variable
    var updateDB =
        await Connect.db.update(session, [firstUserData[0], secondUserData[0]]);
    await NotificationEndpoint().createNotification(session, invite.user,
        "accepted your invite", receiverId, receiverId, "Request");
  }

  // Withdraw Connection Request
  Future<void> withdrawConnection(
      Session session, int senderId, Invitation invite) async {
    // remove sent Request from sender
    // Update active connections for both users
    var firstUserData = await Connect.db
        .find(session, where: (t) => t.accountId.equals(senderId));
    var secondUserData = await Connect.db
        .find(session, where: (t) => t.accountId.equals(invite.user));
    // remove received invitation from receiver
    firstUserData[0].sentPending =
        await removeInvite(firstUserData[0].sentPending, invite.user);
    secondUserData[0].receivedPending =
        await removeInvite(secondUserData[0].receivedPending, senderId);
    // Push updated data to database
    // ignore: unused_local_variable
    var updateDB =
        await Connect.db.update(session, [firstUserData[0], secondUserData[0]]);
  }

  // Reject Invitation
  Future<void> rejectConnection(
      Session session, int? receiverId, Invitation invite) async {
    // Remove invitation from the receivers data
    var secondUserData = await Connect.db
        .find(session, where: (t) => t.accountId.equals(receiverId));
    secondUserData[0].receivedPending =
        await removeInvite(secondUserData[0].receivedPending, invite.user);
    // Push data to the DB
    // ignore: unused_local_variable
    var updateDB = await Connect.db.update(session, secondUserData);
  }

  Future<void> removeConnection(
      Session session, int userId1, int userId2) async {
    var connectData1 = await Connect.db
        .findFirstRow(session, where: (t) => t.accountId.equals(userId1));
    var connectData2 = await Connect.db
        .findFirstRow(session, where: (t) => t.accountId.equals(userId2));
    connectData1!.activeConnections.remove(userId2);
    connectData2!.activeConnections.remove(userId1);
    await Connect.db.update(session, [connectData1, connectData2]);
  }

  Future<List<UserView>> getConnectedUserData(
      Session session, int? userId) async {
    // Get list of connection Id
    var connectedPeople = await Connect.db
        .find(session, where: (t) => t.accountId.equals(userId));
    // Get Account Data of all connected users
    var mainData = await UserView.db.find(session,
        where: (t) => t.id.inSet(connectedPeople[0].activeConnections.toSet()));
    return mainData;
  }

  // Org connection
  Future<int> followOrg(Session session, int profileId, int orgId) async {
    try {
      var follow = Follow(orgId: orgId, followedBy: profileId);
      // ignore: unused_local_variable
      var followIns = await Follow.db.insertRow(session, follow);
      return 0;
    } catch (err) {
      return 1;
    }
  }

  Future<int> unfollowOrg(Session session, int profileId, int orgId) async {
    try {
      var checkFollow = await Follow.db.findFirstRow(session,
          where: (t) => t.orgId.equals(orgId) & t.followedBy.equals(profileId));
      if (checkFollow == null) {
      } else {
        // ignore: unused_local_variable
        var delFollow = await Follow.db.deleteRow(session, checkFollow);
      }
      return 0;
    } catch (err) {
      return 1;
    }
  }

  Future<int> followerCount(Session session, int orgId) async {
    var followCount =
        await Follow.db.count(session, where: (t) => t.orgId.equals(orgId));
    return followCount;
  }

  Future<bool> isFollowingOrg(Session session, int profileId, int orgId) async {
    var following = await Follow.db.findFirstRow(session,
        where: (t) => t.orgId.equals(orgId) & t.followedBy.equals(profileId));
    if (following == null) {
      return false;
    }
    return true;
  }

  Future<List<UserView>> fetchFollowedOrgs(
      Session session, int profileId) async {
    var follows = await Follow.db
        .find(session, where: (t) => t.followedBy.equals(profileId));
    var orgs = await UserView.db.find(session,
        where: (t) =>
            t.accountType.equals("Organization") &
            t.userId.inSet(follows.map((follow) {
              return follow.orgId;
            }).toSet()));
    return orgs;
  }
}
