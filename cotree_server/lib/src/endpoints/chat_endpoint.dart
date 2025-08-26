// server/lib/src/endpoints/chat_endpoint.dart
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ChatEndpoint extends Endpoint {
  static const _chatChannel = 'chat-message';

  Future<void> sendMessage(Session session, int chatId, Message message) async {
    // Save the message to DB
    await Message.db.insertRow(session, message);

    // Broadcast to all subscribers of this chat
    session.messages.postMessage(
      '$_chatChannel-$chatId',
      message,
    );
  }

  Stream<Message> messageStream(Session session, int chatId) async* {
    // Subscribe first to avoid missing messages
    var updates = session.messages.createStream<Message>(
      '$_chatChannel-$chatId',
    );

    // Then relay incoming updates
    await for (var msg in updates) {
      yield msg;
    }
  }

  Future<List<Message>> fetchChatMessages(
      Session session, int chatId, int participantId) async {
    var chatData = await ChatParticipant.db.findFirstRow(session,
        where: (t) =>
            t.chatId.equals(chatId) & t.participant.equals(participantId));
    if (chatData!.deletedAt == null) {
      return await Message.db.find(session,
          where: (t) => t.chatId.equals(chatId),
          limit: 1000,
          orderBy: (t) => t.sentAt);
    }
    return await Message.db.find(session,
        where: (t) =>
            t.chatId.equals(chatId) & (t.sentAt >= chatData.deletedAt),
        limit: 1000,
        orderBy: (t) => t.sentAt);
  }

  Future<List<UserView>> fetchChatUserViews(Session session, int chatId) async {
    var members = await ChatParticipant.db
        .find(session, where: (t) => t.chatId.equals(chatId));
    var userviews = await UserView.db.find(session,
        where: (t) => t.userId.inSet(members.map((memb) {
              return memb.participant;
            }).toSet()));
    return userviews;
  }

  Future<Chat> createNewChat(Session session, int user1Id, int user2Id) async {
    // Create New Object
    var chatNew = await Chat.db.insertRow(session, Chat(isGroup: false));
    // ignore: unused_local_variable
    var chatParticipants = await ChatParticipant.db.insert(session, [
      ChatParticipant(chatId: chatNew.id!, participant: user1Id),
      ChatParticipant(chatId: chatNew.id!, participant: user2Id)
    ]);
    return chatNew;
  }

  Future<Chat> getOrCreateChat(
      Session session, int user1Id, int user2Id) async {
    var user1Chats = await ChatParticipant.db
        .find(session, where: (t) => t.participant.equals(user1Id));
    var combinedChat = await ChatParticipant.db.find(session,
        where: (t) =>
            t.chatId.inSet(user1Chats.map((chat) {
              return chat.chatId;
            }).toSet()) &
            t.participant.equals(user2Id));
    if (combinedChat.isEmpty) {
      var chatNew = createNewChat(session, user1Id, user2Id);
      return chatNew;
    }
    var chat = await Chat.db.findFirstRow(session,
        where: (t) =>
            t.isGroup.equals(false) &
            t.id.inSet(combinedChat.map((comb) {
              return comb.chatId;
            }).toSet()));
    if (chat == null) {
      var chatNew = createNewChat(session, user1Id, user2Id);
      return chatNew;
    }
    return chat;
  }

  Future<List<Chat>> retrieveDmChats(Session session, int userId) async {
    var participant = await ChatParticipant.db.find(session,
        where: (t) => t.participant.equals(userId) & t.deletedAt.equals(null));
    var chats = await Chat.db.find(session,
        where: (t) => t.id.inSet(participant.map((part) {
              return part.chatId;
            }).toSet()));
    return chats.where((t) => t.isGroup == false).toList();
  }

  Future<List<Chat>> getUserChats(Session session, int userId) async {
    var participants = await ChatParticipant.db.find(
      session,
      where: (t) => t.participant.equals(userId) & t.deletedAt.equals(null),
    );

    if (participants.isEmpty) return [];

    var chatIds = participants.map((p) => p.chatId).toList();

    return await Chat.db.find(
      session,
      where: (t) => t.id.inSet(chatIds.toSet()),
    );
  }

  Future<List<Chat>> retrieveChats(Session session, int userId) async {
    var participant = await ChatParticipant.db
        .find(session, where: (t) => t.participant.equals(userId));
    var chats = await Chat.db.find(session,
        where: (t) => t.id.inSet(participant.map((part) {
              return part.chatId;
            }).toSet()));
    return chats;
  }

  Stream<User> chatUserSearch(
      Session session, int? userId, String query) async* {
    var connections = await Connect.db
        .find(session, where: (t) => (t.accountId.equals(userId)));
    print("${connections[0].activeConnections.toSet()}");
    var users = await User.db.find(session,
        where: (t) => (t.name.ilike("%$query%") &
            t.id.inSet(connections[0].activeConnections.toSet())));
    for (int i = 0; i < users.length; i++) {
      print("Retrieved Users: ${users[i].name}");
    }
    for (var user in users) {
      yield user;
    }
  }

  Future<void> deleteChat(Session session, int chatId, int userId) async {
    var participant = await ChatParticipant.db.findFirstRow(
      session,
      where: (t) => t.chatId.equals(chatId) & t.participant.equals(userId),
    );

    if (participant != null) {
      await ChatParticipant.db.updateRow(
        session,
        participant.copyWith(deletedAt: DateTime.now()),
      );

      var remaining = await ChatParticipant.db.count(
        session,
        where: (t) => t.chatId.equals(chatId) & t.deletedAt.equals(null),
      );

      if (remaining == 0) {
        await Chat.db.deleteWhere(session, where: (t) => t.id.equals(chatId));
        await ChatParticipant.db
            .deleteWhere(session, where: (t) => t.chatId.equals(chatId));
        // delete messages
        await Message.db
            .deleteWhere(session, where: (t) => t.chatId.equals(chatId));
      }
    }
  }
}
