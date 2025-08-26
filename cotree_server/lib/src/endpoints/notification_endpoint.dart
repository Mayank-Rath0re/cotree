import 'package:cotree_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class NotificationEndpoint extends Endpoint {
  Future<void> createNotification(Session session, int userId, String content,
      int referencedUser, int? objectId, String? objectType) async {
    var notifyObj = Notification(
        forUser: userId,
        content: content,
        referencedUser: referencedUser,
        triggeredAt: DateTime.now(),
        unread: true,
        objectId: objectId,
        objectType: objectType);
    await Notification.db.insertRow(session, notifyObj);
  }

  Future<void> notifyMyConnections(Session session, int userId, String content,
      int? objectId, String? objectType) async {
    var connections = await Connect.db
        .findFirstRow(session, where: (t) => t.accountId.equals(userId));
    var notifications = List.generate(
        connections!.activeConnections.length,
        (index) => Notification(
            forUser: connections.activeConnections[index],
            content: content,
            referencedUser: userId,
            triggeredAt: DateTime.now(),
            unread: true,
            objectId: objectId,
            objectType: objectType));
    await Notification.db.insert(session, notifications);
  }

  Future<bool> anyUnreadNotifications(Session session, int userId) async {
    var check = await Notification.db.count(session,
        where: (t) => t.forUser.equals(userId) & t.unread.equals(true));
    if (check == 0) {
      return false;
    }
    return true;
  }

  Future<void> markRead(
      Session session, List<Notification> notifications) async {
    for (var object in notifications) {
      if (object.unread) {
        object.unread = false;
      }
    }
    await Notification.db.update(session, notifications);
  }

  Future<List<Notification>> fetchUserNotifications(
      Session session, int userId) async {
    var notifications = await Notification.db
        .find(session, where: (t) => t.forUser.equals(userId), limit: 30);
    return notifications;
  }
}
