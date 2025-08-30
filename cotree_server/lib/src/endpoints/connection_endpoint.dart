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

  Future<List<Invitation>> fetchInvitations(
      Session session, int? userId) async {
    var inviteData = await Invitation.db.find(session,
        where: (t) =>
            t.sender.equals(userId) |
            (t.receiver.equals(userId) & t.isRejected.equals(false)),
        orderBy: (t) => t.id,
        orderDescending: true);
    return inviteData;
  }

  Future<Invitation?> fetchInvitationByUsers(
      Session session, int userId, int secondaryId) async {
    var inviteData = await Invitation.db.findFirstRow(session,
        where: (t) =>
            t.sender.equals(userId) &
            t.receiver.equals(secondaryId) &
            t.isRejected.equals(false));
    return inviteData;
  }

  Future<int> isConnection(
      Session session, int userId, int secondaryUserId) async {
    var connectObj = await Connect.db
        .findFirstRow(session, where: (t) => t.accountId.equals(userId));
    if (connectObj!.activeConnections.contains(secondaryUserId)) {
      // Account is Connected
      return 1;
    }
    var sent = await Invitation.db.findFirstRow(session,
        where: (t) =>
            t.sender.equals(userId) | t.receiver.equals(secondaryUserId));
    if (sent != null) {
      // Account is Pending
      return 2;
    }
    var received = await Invitation.db.findFirstRow(session,
        where: (t) =>
            t.sender.equals(secondaryUserId) &
            t.receiver.equals(userId) &
            t.isRejected.equals(false));
    if (received != null) {
      // Account has received request from this profile
      return 3;
    }
    // Account is completely stranger
    return 0;
  }

  // Send Request
  Future<void> sendConnectionRequest(Session session, int? senderId,
      int? receiverId, String? personalText) async {
    var check = await Invitation.db.findFirstRow(session,
        where: (t) =>
            t.sender.equals(receiverId) & t.receiver.equals(senderId));
    if (check != null) {
      if (check.isRejected == true) {
        check.isRejected = false;
        check.sender = senderId!;
        check.receiver = receiverId!;
        check.personalText = personalText;
        // ignore: unused_local_variable
        var inviteSend = await Invitation.db.updateRow(session, check);
        // ignore: unawaited_futures
        notifObj.createNotification(session, receiverId,
            "sent you a connection request", senderId, senderId, "profile");
      }
      return;
    }
    var invite = Invitation(
        sender: senderId!, receiver: receiverId!, personalText: personalText);
    // ignore: unused_local_variable
    var inviteSend = await Invitation.db.insertRow(session, invite);
    // ignore: unawaited_futures
    notifObj.createNotification(session, receiverId,
        "sent you a connection request", senderId, senderId, "profile");
  }

  Future<void> removeInvite(
      Session session, int senderId, int receiverId) async {
    var data = await Invitation.db.findFirstRow(session,
        where: (t) =>
            t.sender.equals(senderId) & t.receiver.equals(receiverId));
    if (data != null) {
      // ignore: unused_local_variable
      var delInvite = await Invitation.db.deleteRow(session, data);
    }
  }

  Future<Invitation?> getInviteData(
      Session session, int receiverId, int secondaryId) async {
    var inviteData = await Invitation.db.findFirstRow(session,
        where: (t) =>
            t.sender.equals(secondaryId) &
            t.receiver.equals(receiverId) &
            t.isRejected.equals(false));
    if (inviteData != null) {
      return inviteData;
    }
    return null;
  }

  // Send Confirmation
  Future<void> confirmConnection(Session session, Invitation invite) async {
    // Update active connections for both users
    var firstUserData = await Connect.db
        .findFirstRow(session, where: (t) => t.accountId.equals(invite.sender));
    var secondUserData = await Connect.db.findFirstRow(session,
        where: (t) => t.accountId.equals(invite.receiver));
    firstUserData!.activeConnections.add(invite.receiver);
    secondUserData!.activeConnections.add(invite.sender);
    // Remove Invitation data for both user
    // ignore: unused_local_variable
    var delInvite = await Invitation.db.deleteRow(session, invite);
    // Push updated data to database
    // ignore: unused_local_variable
    var updateDB =
        await Connect.db.update(session, [firstUserData, secondUserData]);
    await notifObj.createNotification(session, invite.sender,
        "accepted your invite", invite.receiver, invite.receiver, "request");
    await Notification.db.deleteWhere(session,
        where: (t) =>
            t.forUser.equals(invite.receiver) &
            t.referencedUser.equals(invite.sender) &
            t.objectType.equals("profile"));
  }

  // Withdraw Connection Request
  Future<void> withdrawConnection(
      Session session, int senderId, int receiverId) async {
    // remove sent Request from sender
    // Update active connections for both users
    // ignore: unused_local_variable
    var inviteData = await Invitation.db.deleteWhere(session,
        where: (t) =>
            t.sender.equals(senderId) & t.receiver.equals(receiverId));
    // ignore: unused_local_variable
    var notifData = await Notification.db.deleteWhere(session,
        where: (t) =>
            t.forUser.equals(receiverId) &
            t.referencedUser.equals(senderId) &
            t.objectType.equals("profile"));
  }

  // Reject Invitation
  Future<void> rejectConnection(Session session, Invitation inviteData) async {
    // Remove invitation from the receivers data
    inviteData.isRejected = true;
    // ignore: unused_local_variable
    var invite = await Invitation.db.updateRow(session, inviteData);
    await Notification.db.deleteWhere(session,
        where: (t) =>
            t.forUser.equals(inviteData.receiver) &
            t.referencedUser.equals(inviteData.sender) &
            t.objectType.equals("profile"));
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

  Future<List<UserView>> fetchConnectedUsers(
      Session session, int userId) async {
    var connData = await Connect.db
        .findFirstRow(session, where: (t) => t.accountId.equals(userId));
    if (connData != null) {
      var views = await UserView.db.find(session,
          where: (t) => t.userId.inSet(connData.activeConnections.toSet()));
      return views;
    }
    return [];
  }
}
