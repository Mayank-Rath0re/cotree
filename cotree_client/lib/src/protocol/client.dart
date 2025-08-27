/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:cotree_client/src/protocol/user.dart' as _i3;
import 'package:cotree_client/src/protocol/userview.dart' as _i4;
import 'package:cotree_client/src/protocol/professional_data.dart' as _i5;
import 'package:cotree_client/src/protocol/custom_details.dart' as _i6;
import 'dart:typed_data' as _i7;
import 'package:cotree_client/src/protocol/individual.dart' as _i8;
import 'package:cotree_client/src/protocol/org.dart' as _i9;
import 'package:cotree_client/src/protocol/message.dart' as _i10;
import 'package:cotree_client/src/protocol/chat.dart' as _i11;
import 'package:cotree_client/src/protocol/connect.dart' as _i12;
import 'package:cotree_client/src/protocol/invitations.dart' as _i13;
import 'package:cotree_client/src/protocol/notification.dart' as _i14;
import 'package:cotree_client/src/protocol/post.dart' as _i15;
import 'package:cotree_client/src/protocol/comment.dart' as _i16;
import 'package:cotree_client/src/protocol/reactions.dart' as _i17;
import 'package:cotree_client/src/protocol/teams.dart' as _i18;
import 'package:cotree_client/src/protocol/documents.dart' as _i19;
import 'package:cotree_client/src/protocol/task.dart' as _i20;
import 'package:cotree_client/src/protocol/project.dart' as _i21;
import 'package:cotree_client/src/protocol/member.dart' as _i22;
import 'package:cotree_client/src/protocol/offers.dart' as _i23;
import 'package:cotree_client/src/protocol/space_invite.dart' as _i24;
import 'package:cotree_client/src/protocol/team_member.dart' as _i25;
import 'package:cotree_client/src/protocol/space.dart' as _i26;
import 'package:cotree_client/src/protocol/meetings.dart' as _i27;
import 'package:cotree_client/src/protocol/applications.dart' as _i28;
import 'package:cotree_client/src/protocol/greeting.dart' as _i29;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i30;
import 'protocol.dart' as _i31;

/// {@category Endpoint}
class EndpointAccount extends _i1.EndpointRef {
  EndpointAccount(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'account';

  _i2.Future<int> createAccount(
    int? id,
    String name,
    String email,
    String accountType,
    String password,
  ) =>
      caller.callServerEndpoint<int>(
        'account',
        'createAccount',
        {
          'id': id,
          'name': name,
          'email': email,
          'accountType': accountType,
          'password': password,
        },
      );

  _i2.Future<void> createUserView(
    int? userId,
    String name,
    String headline,
    String avatar,
    String accountType,
  ) =>
      caller.callServerEndpoint<void>(
        'account',
        'createUserView',
        {
          'userId': userId,
          'name': name,
          'headline': headline,
          'avatar': avatar,
          'accountType': accountType,
        },
      );

  _i2.Future<_i3.User> getUserData(int? id) =>
      caller.callServerEndpoint<_i3.User>(
        'account',
        'getUserData',
        {'id': id},
      );

  _i2.Future<int> updateIndivAccount(
    _i4.UserView userview,
    String bio,
    String residence,
  ) =>
      caller.callServerEndpoint<int>(
        'account',
        'updateIndivAccount',
        {
          'userview': userview,
          'bio': bio,
          'residence': residence,
        },
      );

  _i2.Future<List<_i4.UserView>> getAllUser() =>
      caller.callServerEndpoint<List<_i4.UserView>>(
        'account',
        'getAllUser',
        {},
      );

  _i2.Future<List<_i4.UserView>> getOrgs() =>
      caller.callServerEndpoint<List<_i4.UserView>>(
        'account',
        'getOrgs',
        {},
      );

  _i2.Future<_i4.UserView> getUserView(int? userId) =>
      caller.callServerEndpoint<_i4.UserView>(
        'account',
        'getUserView',
        {'userId': userId},
      );

  _i2.Future<List<_i5.ProfessionalData>> fetchUserProfessionalData(
          int profileId) =>
      caller.callServerEndpoint<List<_i5.ProfessionalData>>(
        'account',
        'fetchUserProfessionalData',
        {'profileId': profileId},
      );

  _i2.Future<_i4.UserView> setupProfileI(
    String? headline,
    String? bio,
    int? userId,
    String gender,
    String? residence,
    DateTime? dob,
    String contact,
  ) =>
      caller.callServerEndpoint<_i4.UserView>(
        'account',
        'setupProfileI',
        {
          'headline': headline,
          'bio': bio,
          'userId': userId,
          'gender': gender,
          'residence': residence,
          'dob': dob,
          'contact': contact,
        },
      );

  _i2.Future<void> setupProfileB(
    String headline,
    String about,
    int userId,
    DateTime originDate,
    List<_i6.CustomDetails> customInformation,
    _i7.ByteData? imageData,
  ) =>
      caller.callServerEndpoint<void>(
        'account',
        'setupProfileB',
        {
          'headline': headline,
          'about': about,
          'userId': userId,
          'originDate': originDate,
          'customInformation': customInformation,
          'imageData': imageData,
        },
      );

  _i2.Future<_i8.Individual> getIndividualData(int? userId) =>
      caller.callServerEndpoint<_i8.Individual>(
        'account',
        'getIndividualData',
        {'userId': userId},
      );

  _i2.Future<_i9.Organization> getOrganizationData(int? userId) =>
      caller.callServerEndpoint<_i9.Organization>(
        'account',
        'getOrganizationData',
        {'userId': userId},
      );

  _i2.Future<String> uploadImage(
    _i7.ByteData imageData,
    String filename,
  ) =>
      caller.callServerEndpoint<String>(
        'account',
        'uploadImage',
        {
          'imageData': imageData,
          'filename': filename,
        },
      );

  _i2.Future<void> addProfessionalInfo(
    int profileId,
    String type,
    String title,
    String institute,
    DateTime? startDate,
    DateTime? endDate,
    String supportingLink,
    List<String> images,
  ) =>
      caller.callServerEndpoint<void>(
        'account',
        'addProfessionalInfo',
        {
          'profileId': profileId,
          'type': type,
          'title': title,
          'institute': institute,
          'startDate': startDate,
          'endDate': endDate,
          'supportingLink': supportingLink,
          'images': images,
        },
      );

  _i2.Future<void> editProfessionalData(_i5.ProfessionalData profData) =>
      caller.callServerEndpoint<void>(
        'account',
        'editProfessionalData',
        {'profData': profData},
      );

  _i2.Future<void> deleteProfessionalData(int profDataId) =>
      caller.callServerEndpoint<void>(
        'account',
        'deleteProfessionalData',
        {'profDataId': profDataId},
      );

  _i2.Future<String> getUserAvatarUrl(int userId) =>
      caller.callServerEndpoint<String>(
        'account',
        'getUserAvatarUrl',
        {'userId': userId},
      );

  _i2.Future<void> updateAvatar(
    _i4.UserView userview,
    String url,
  ) =>
      caller.callServerEndpoint<void>(
        'account',
        'updateAvatar',
        {
          'userview': userview,
          'url': url,
        },
      );

  _i2.Future<void> removeAvatar(_i4.UserView userview) =>
      caller.callServerEndpoint<void>(
        'account',
        'removeAvatar',
        {'userview': userview},
      );

  _i2.Stream<_i4.UserView> userSearch(
    int? userId,
    String query,
  ) =>
      caller
          .callStreamingServerEndpoint<_i2.Stream<_i4.UserView>, _i4.UserView>(
        'account',
        'userSearch',
        {
          'userId': userId,
          'query': query,
        },
        {},
      );

  _i2.Future<int> fetchUserConnectionCount(int userId) =>
      caller.callServerEndpoint<int>(
        'account',
        'fetchUserConnectionCount',
        {'userId': userId},
      );

  _i2.Future<int> fetchUserSpaceCount(int userId) =>
      caller.callServerEndpoint<int>(
        'account',
        'fetchUserSpaceCount',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointChat extends _i1.EndpointRef {
  EndpointChat(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  _i2.Future<void> sendMessage(
    int chatId,
    _i10.Message message,
  ) =>
      caller.callServerEndpoint<void>(
        'chat',
        'sendMessage',
        {
          'chatId': chatId,
          'message': message,
        },
      );

  _i2.Stream<_i10.Message> messageStream(int chatId) => caller
          .callStreamingServerEndpoint<_i2.Stream<_i10.Message>, _i10.Message>(
        'chat',
        'messageStream',
        {'chatId': chatId},
        {},
      );

  _i2.Future<List<_i10.Message>> fetchChatMessages(
    int chatId,
    int participantId,
  ) =>
      caller.callServerEndpoint<List<_i10.Message>>(
        'chat',
        'fetchChatMessages',
        {
          'chatId': chatId,
          'participantId': participantId,
        },
      );

  _i2.Future<List<_i4.UserView>> fetchChatUserViews(int chatId) =>
      caller.callServerEndpoint<List<_i4.UserView>>(
        'chat',
        'fetchChatUserViews',
        {'chatId': chatId},
      );

  _i2.Future<_i11.Chat> createNewChat(
    int user1Id,
    int user2Id,
  ) =>
      caller.callServerEndpoint<_i11.Chat>(
        'chat',
        'createNewChat',
        {
          'user1Id': user1Id,
          'user2Id': user2Id,
        },
      );

  _i2.Future<_i11.Chat> getOrCreateChat(
    int user1Id,
    int user2Id,
  ) =>
      caller.callServerEndpoint<_i11.Chat>(
        'chat',
        'getOrCreateChat',
        {
          'user1Id': user1Id,
          'user2Id': user2Id,
        },
      );

  _i2.Future<List<_i11.Chat>> retrieveDmChats(int userId) =>
      caller.callServerEndpoint<List<_i11.Chat>>(
        'chat',
        'retrieveDmChats',
        {'userId': userId},
      );

  _i2.Future<List<_i11.Chat>> getUserChats(int userId) =>
      caller.callServerEndpoint<List<_i11.Chat>>(
        'chat',
        'getUserChats',
        {'userId': userId},
      );

  _i2.Future<List<_i11.Chat>> retrieveChats(int userId) =>
      caller.callServerEndpoint<List<_i11.Chat>>(
        'chat',
        'retrieveChats',
        {'userId': userId},
      );

  _i2.Stream<_i3.User> chatUserSearch(
    int? userId,
    String query,
  ) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i3.User>, _i3.User>(
        'chat',
        'chatUserSearch',
        {
          'userId': userId,
          'query': query,
        },
        {},
      );

  _i2.Future<void> deleteChat(
    int chatId,
    int userId,
  ) =>
      caller.callServerEndpoint<void>(
        'chat',
        'deleteChat',
        {
          'chatId': chatId,
          'userId': userId,
        },
      );
}

/// {@category Endpoint}
class EndpointConnection extends _i1.EndpointRef {
  EndpointConnection(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'connection';

  _i2.Future<_i12.Connect> fetchConnectData(int? userId) =>
      caller.callServerEndpoint<_i12.Connect>(
        'connection',
        'fetchConnectData',
        {'userId': userId},
      );

  _i2.Future<int> isConnection(
    int userId,
    int secondaryUserId,
  ) =>
      caller.callServerEndpoint<int>(
        'connection',
        'isConnection',
        {
          'userId': userId,
          'secondaryUserId': secondaryUserId,
        },
      );

  _i2.Future<void> sendConnectionRequest(
    int? senderId,
    int? receiverId,
    String? personalText,
  ) =>
      caller.callServerEndpoint<void>(
        'connection',
        'sendConnectionRequest',
        {
          'senderId': senderId,
          'receiverId': receiverId,
          'personalText': personalText,
        },
      );

  _i2.Future<_i13.Invitation?> getInviteData(
    int receiverId,
    int secondaryId,
  ) =>
      caller.callServerEndpoint<_i13.Invitation?>(
        'connection',
        'getInviteData',
        {
          'receiverId': receiverId,
          'secondaryId': secondaryId,
        },
      );

  _i2.Future<void> confirmConnection(
    int? receiverId,
    _i13.Invitation invite,
  ) =>
      caller.callServerEndpoint<void>(
        'connection',
        'confirmConnection',
        {
          'receiverId': receiverId,
          'invite': invite,
        },
      );

  _i2.Future<void> withdrawConnection(
    int senderId,
    _i13.Invitation invite,
  ) =>
      caller.callServerEndpoint<void>(
        'connection',
        'withdrawConnection',
        {
          'senderId': senderId,
          'invite': invite,
        },
      );

  _i2.Future<void> rejectConnection(
    int? receiverId,
    _i13.Invitation invite,
  ) =>
      caller.callServerEndpoint<void>(
        'connection',
        'rejectConnection',
        {
          'receiverId': receiverId,
          'invite': invite,
        },
      );

  _i2.Future<void> removeConnection(
    int userId1,
    int userId2,
  ) =>
      caller.callServerEndpoint<void>(
        'connection',
        'removeConnection',
        {
          'userId1': userId1,
          'userId2': userId2,
        },
      );

  _i2.Future<List<_i4.UserView>> getConnectedUserData(int? userId) =>
      caller.callServerEndpoint<List<_i4.UserView>>(
        'connection',
        'getConnectedUserData',
        {'userId': userId},
      );

  _i2.Future<int> followOrg(
    int profileId,
    int orgId,
  ) =>
      caller.callServerEndpoint<int>(
        'connection',
        'followOrg',
        {
          'profileId': profileId,
          'orgId': orgId,
        },
      );

  _i2.Future<int> unfollowOrg(
    int profileId,
    int orgId,
  ) =>
      caller.callServerEndpoint<int>(
        'connection',
        'unfollowOrg',
        {
          'profileId': profileId,
          'orgId': orgId,
        },
      );

  _i2.Future<int> followerCount(int orgId) => caller.callServerEndpoint<int>(
        'connection',
        'followerCount',
        {'orgId': orgId},
      );

  _i2.Future<bool> isFollowingOrg(
    int profileId,
    int orgId,
  ) =>
      caller.callServerEndpoint<bool>(
        'connection',
        'isFollowingOrg',
        {
          'profileId': profileId,
          'orgId': orgId,
        },
      );

  _i2.Future<List<_i4.UserView>> fetchFollowedOrgs(int profileId) =>
      caller.callServerEndpoint<List<_i4.UserView>>(
        'connection',
        'fetchFollowedOrgs',
        {'profileId': profileId},
      );

  _i2.Future<List<_i4.UserView>> fetchConnectedUsers(int userId) =>
      caller.callServerEndpoint<List<_i4.UserView>>(
        'connection',
        'fetchConnectedUsers',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointFile extends _i1.EndpointRef {
  EndpointFile(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'file';

  _i2.Future<String?> getUploadDescription(String path) =>
      caller.callServerEndpoint<String?>(
        'file',
        'getUploadDescription',
        {'path': path},
      );

  _i2.Future<bool> verifyUpload(String path) => caller.callServerEndpoint<bool>(
        'file',
        'verifyUpload',
        {'path': path},
      );

  _i2.Future<String?> getPublicUrl(String path) =>
      caller.callServerEndpoint<String?>(
        'file',
        'getPublicUrl',
        {'path': path},
      );
}

/// {@category Endpoint}
class EndpointNotification extends _i1.EndpointRef {
  EndpointNotification(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _i2.Future<void> createNotification(
    int userId,
    String content,
    int referencedUser,
    int? objectId,
    String? objectType,
  ) =>
      caller.callServerEndpoint<void>(
        'notification',
        'createNotification',
        {
          'userId': userId,
          'content': content,
          'referencedUser': referencedUser,
          'objectId': objectId,
          'objectType': objectType,
        },
      );

  _i2.Future<void> notifyMyConnections(
    int userId,
    String content,
    int? objectId,
    String? objectType,
  ) =>
      caller.callServerEndpoint<void>(
        'notification',
        'notifyMyConnections',
        {
          'userId': userId,
          'content': content,
          'objectId': objectId,
          'objectType': objectType,
        },
      );

  _i2.Future<bool> anyUnreadNotifications(int userId) =>
      caller.callServerEndpoint<bool>(
        'notification',
        'anyUnreadNotifications',
        {'userId': userId},
      );

  _i2.Future<void> markRead(List<_i14.Notification> notifications) =>
      caller.callServerEndpoint<void>(
        'notification',
        'markRead',
        {'notifications': notifications},
      );

  _i2.Future<List<_i14.Notification>> fetchUserNotifications(int userId) =>
      caller.callServerEndpoint<List<_i14.Notification>>(
        'notification',
        'fetchUserNotifications',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointPost extends _i1.EndpointRef {
  EndpointPost(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'post';

  _i2.Future<void> createPost(
    int? authorId,
    String text,
    List<String> mediaList,
  ) =>
      caller.callServerEndpoint<void>(
        'post',
        'createPost',
        {
          'authorId': authorId,
          'text': text,
          'mediaList': mediaList,
        },
      );

  _i2.Future<void> deletePost(int? postId) => caller.callServerEndpoint<void>(
        'post',
        'deletePost',
        {'postId': postId},
      );

  _i2.Future<List<_i15.Post>> retrieveAllPosts() =>
      caller.callServerEndpoint<List<_i15.Post>>(
        'post',
        'retrieveAllPosts',
        {},
      );

  _i2.Future<_i15.Post> retrievePost(int postId) =>
      caller.callServerEndpoint<_i15.Post>(
        'post',
        'retrievePost',
        {'postId': postId},
      );

  _i2.Future<_i15.Post?> fetchLastUserPost(int userId) =>
      caller.callServerEndpoint<_i15.Post?>(
        'post',
        'fetchLastUserPost',
        {'userId': userId},
      );

  _i2.Future<List<_i15.Post>> fetchUserPosts(int userId) =>
      caller.callServerEndpoint<List<_i15.Post>>(
        'post',
        'fetchUserPosts',
        {'userId': userId},
      );

  _i2.Future<_i16.Comment> uploadComment(
    int? postId,
    int? authorId,
    String text,
    String? media,
  ) =>
      caller.callServerEndpoint<_i16.Comment>(
        'post',
        'uploadComment',
        {
          'postId': postId,
          'authorId': authorId,
          'text': text,
          'media': media,
        },
      );

  _i2.Future<_i17.Reaction?> fetchReaction(
    String objectType,
    int objectId,
    int userId,
  ) =>
      caller.callServerEndpoint<_i17.Reaction?>(
        'post',
        'fetchReaction',
        {
          'objectType': objectType,
          'objectId': objectId,
          'userId': userId,
        },
      );

  _i2.Future<int> fetchReactionCount(
    int objectId,
    String objectType,
  ) =>
      caller.callServerEndpoint<int>(
        'post',
        'fetchReactionCount',
        {
          'objectId': objectId,
          'objectType': objectType,
        },
      );

  _i2.Future<void> updateReaction(
    int objectId,
    int authorId,
    String reactablTtype,
    int? userId,
    int? postId, {
    required int type,
  }) =>
      caller.callServerEndpoint<void>(
        'post',
        'updateReaction',
        {
          'objectId': objectId,
          'authorId': authorId,
          'reactablTtype': reactablTtype,
          'userId': userId,
          'postId': postId,
          'type': type,
        },
      );

  _i2.Future<List<_i16.Comment>> fetchComments(int postId) =>
      caller.callServerEndpoint<List<_i16.Comment>>(
        'post',
        'fetchComments',
        {'postId': postId},
      );

  _i2.Future<void> deleteComment(int? commentId) =>
      caller.callServerEndpoint<void>(
        'post',
        'deleteComment',
        {'commentId': commentId},
      );

  _i2.Future<String> uploadFile(
    int userId,
    _i7.ByteData imageData,
    String filename,
  ) =>
      caller.callServerEndpoint<String>(
        'post',
        'uploadFile',
        {
          'userId': userId,
          'imageData': imageData,
          'filename': filename,
        },
      );
}

/// {@category Endpoint}
class EndpointProject extends _i1.EndpointRef {
  EndpointProject(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'project';

  _i2.Future<void> removeProject(
    int spaceId,
    int projectId,
  ) =>
      caller.callServerEndpoint<void>(
        'project',
        'removeProject',
        {
          'spaceId': spaceId,
          'projectId': projectId,
        },
      );

  _i2.Future<void> changeProjectStatus(
    int projectId,
    String newStatus,
  ) =>
      caller.callServerEndpoint<void>(
        'project',
        'changeProjectStatus',
        {
          'projectId': projectId,
          'newStatus': newStatus,
        },
      );

  _i2.Future<List<_i18.Teams>> fetchExcludedProjectTeams(int projectId) =>
      caller.callServerEndpoint<List<_i18.Teams>>(
        'project',
        'fetchExcludedProjectTeams',
        {'projectId': projectId},
      );

  _i2.Future<void> updateAssignedTeams(
    int projectId,
    List<int> deletedTeamsIds,
    List<int> addedTeamsIds,
    bool deleteDocuments,
  ) =>
      caller.callServerEndpoint<void>(
        'project',
        'updateAssignedTeams',
        {
          'projectId': projectId,
          'deletedTeamsIds': deletedTeamsIds,
          'addedTeamsIds': addedTeamsIds,
          'deleteDocuments': deleteDocuments,
        },
      );

  _i2.Future<String> uploadFile(
    int projectId,
    int memberId,
    _i7.ByteData fileData,
    String filename,
  ) =>
      caller.callServerEndpoint<String>(
        'project',
        'uploadFile',
        {
          'projectId': projectId,
          'memberId': memberId,
          'fileData': fileData,
          'filename': filename,
        },
      );

  _i2.Future<List<_i19.Documents>> fetchDocuments(int projectId) =>
      caller.callServerEndpoint<List<_i19.Documents>>(
        'project',
        'fetchDocuments',
        {'projectId': projectId},
      );

  _i2.Future<int> deleteDocument(int documentId) =>
      caller.callServerEndpoint<int>(
        'project',
        'deleteDocument',
        {'documentId': documentId},
      );

  _i2.Future<_i20.Task?> createTask(
    _i20.Task task,
    List<int> assignedIds,
  ) =>
      caller.callServerEndpoint<_i20.Task?>(
        'project',
        'createTask',
        {
          'task': task,
          'assignedIds': assignedIds,
        },
      );

  _i2.Future<List<_i20.Task>> fetchMemberTasks(int memberId) =>
      caller.callServerEndpoint<List<_i20.Task>>(
        'project',
        'fetchMemberTasks',
        {'memberId': memberId},
      );

  _i2.Future<List<_i20.Task>> fetchTasks(List<int> projectId) =>
      caller.callServerEndpoint<List<_i20.Task>>(
        'project',
        'fetchTasks',
        {'projectId': projectId},
      );

  _i2.Future<_i21.Project> fetchProject(int projectId) =>
      caller.callServerEndpoint<_i21.Project>(
        'project',
        'fetchProject',
        {'projectId': projectId},
      );

  _i2.Future<List<_i18.Teams>> fetchProjectTeams(List<int> projectIds) =>
      caller.callServerEndpoint<List<_i18.Teams>>(
        'project',
        'fetchProjectTeams',
        {'projectIds': projectIds},
      );

  _i2.Future<List<_i22.Member>> fetchProjectMembers(int projectId) =>
      caller.callServerEndpoint<List<_i22.Member>>(
        'project',
        'fetchProjectMembers',
        {'projectId': projectId},
      );

  _i2.Future<void> updateTask(_i20.Task taskObj) =>
      caller.callServerEndpoint<void>(
        'project',
        'updateTask',
        {'taskObj': taskObj},
      );

  _i2.Future<void> deleteTask(int taskId) => caller.callServerEndpoint<void>(
        'project',
        'deleteTask',
        {'taskId': taskId},
      );
}

/// {@category Endpoint}
class EndpointRecommendation extends _i1.EndpointRef {
  EndpointRecommendation(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'recommendation';

  _i2.Future<List<_i15.Post>> recommendPosts(int userId) =>
      caller.callServerEndpoint<List<_i15.Post>>(
        'recommendation',
        'recommendPosts',
        {'userId': userId},
      );

  _i2.Future<List<_i23.Offers>> recommendOffers(int userId) =>
      caller.callServerEndpoint<List<_i23.Offers>>(
        'recommendation',
        'recommendOffers',
        {'userId': userId},
      );

  _i2.Future<List<_i9.Organization>> recommendOrganizations(int userId) =>
      caller.callServerEndpoint<List<_i9.Organization>>(
        'recommendation',
        'recommendOrganizations',
        {'userId': userId},
      );

  _i2.Future<List<_i4.UserView>> recommendUsers(
    int userId, {
    required int limit,
  }) =>
      caller.callServerEndpoint<List<_i4.UserView>>(
        'recommendation',
        'recommendUsers',
        {
          'userId': userId,
          'limit': limit,
        },
      );
}

/// {@category Endpoint}
class EndpointSpace extends _i1.EndpointRef {
  EndpointSpace(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'space';

  _i2.Future<int> createSpace(
    int creatorId,
    String title,
    String description,
    String url,
    String? credentials,
  ) =>
      caller.callServerEndpoint<int>(
        'space',
        'createSpace',
        {
          'creatorId': creatorId,
          'title': title,
          'description': description,
          'url': url,
          'credentials': credentials,
        },
      );

  _i2.Future<int> deleteSpace(
    int creatorId,
    int spaceId,
  ) =>
      caller.callServerEndpoint<int>(
        'space',
        'deleteSpace',
        {
          'creatorId': creatorId,
          'spaceId': spaceId,
        },
      );

  _i2.Future<int> createTeam(
    int spaceId,
    String title,
    List<int> members,
    List<String> role,
  ) =>
      caller.callServerEndpoint<int>(
        'space',
        'createTeam',
        {
          'spaceId': spaceId,
          'title': title,
          'members': members,
          'role': role,
        },
      );

  _i2.Future<int> createProject(
    int spaceId,
    String title,
    String overview,
    List<int> teamAssigned,
  ) =>
      caller.callServerEndpoint<int>(
        'space',
        'createProject',
        {
          'spaceId': spaceId,
          'title': title,
          'overview': overview,
          'teamAssigned': teamAssigned,
        },
      );

  _i2.Future<int> addOwner(
    int userId,
    int spaceId,
    _i4.UserView userview,
  ) =>
      caller.callServerEndpoint<int>(
        'space',
        'addOwner',
        {
          'userId': userId,
          'spaceId': spaceId,
          'userview': userview,
        },
      );

  _i2.Future<int> createSpaceInvite(
    int userId,
    int spaceId,
    String designation,
    List<List<String>> teamAndRoles,
    String globalRole,
    int sentBy,
  ) =>
      caller.callServerEndpoint<int>(
        'space',
        'createSpaceInvite',
        {
          'userId': userId,
          'spaceId': spaceId,
          'designation': designation,
          'teamAndRoles': teamAndRoles,
          'globalRole': globalRole,
          'sentBy': sentBy,
        },
      );

  _i2.Future<void> markInviteRead(List<_i24.SpaceInvite> invites) =>
      caller.callServerEndpoint<void>(
        'space',
        'markInviteRead',
        {'invites': invites},
      );

  _i2.Future<bool> unreadInvites(int userId) => caller.callServerEndpoint<bool>(
        'space',
        'unreadInvites',
        {'userId': userId},
      );

  _i2.Future<void> acceptInvite(int spaceInviteId) =>
      caller.callServerEndpoint<void>(
        'space',
        'acceptInvite',
        {'spaceInviteId': spaceInviteId},
      );

  _i2.Future<int> addMember(
    int userId,
    _i24.SpaceInvite spInvite,
  ) =>
      caller.callServerEndpoint<int>(
        'space',
        'addMember',
        {
          'userId': userId,
          'spInvite': spInvite,
        },
      );

  _i2.Future<void> removeMember(List<int> memberIds) =>
      caller.callServerEndpoint<void>(
        'space',
        'removeMember',
        {'memberIds': memberIds},
      );

  _i2.Future<void> editMemberRoles(
    List<_i22.Member> members,
    List<_i25.TeamMember> teamRoles,
  ) =>
      caller.callServerEndpoint<void>(
        'space',
        'editMemberRoles',
        {
          'members': members,
          'teamRoles': teamRoles,
        },
      );

  _i2.Future<List<_i26.Space>> fetchSpacesByUser(int userId) =>
      caller.callServerEndpoint<List<_i26.Space>>(
        'space',
        'fetchSpacesByUser',
        {'userId': userId},
      );

  _i2.Future<_i26.Space?> fetchSpace(int spaceId) =>
      caller.callServerEndpoint<_i26.Space?>(
        'space',
        'fetchSpace',
        {'spaceId': spaceId},
      );

  _i2.Stream<_i22.Member> searchMemberByName(
    int spaceId,
    String query,
  ) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i22.Member>, _i22.Member>(
        'space',
        'searchMemberByName',
        {
          'spaceId': spaceId,
          'query': query,
        },
        {},
      );

  _i2.Future<_i22.Member> fetchMember(int userId) =>
      caller.callServerEndpoint<_i22.Member>(
        'space',
        'fetchMember',
        {'userId': userId},
      );

  _i2.Future<List<List<String>>> fetchTitles(int spaceId) =>
      caller.callServerEndpoint<List<List<String>>>(
        'space',
        'fetchTitles',
        {'spaceId': spaceId},
      );

  _i2.Future<List<_i21.Project>> fetchProjectsByUser(List<int> teams) =>
      caller.callServerEndpoint<List<_i21.Project>>(
        'space',
        'fetchProjectsByUser',
        {'teams': teams},
      );

  _i2.Future<List<_i18.Teams>> fetchSpaceTeams(int spaceId) =>
      caller.callServerEndpoint<List<_i18.Teams>>(
        'space',
        'fetchSpaceTeams',
        {'spaceId': spaceId},
      );

  _i2.Future<List<_i21.Project>> fetchSpaceProjects(int spaceId) =>
      caller.callServerEndpoint<List<_i21.Project>>(
        'space',
        'fetchSpaceProjects',
        {'spaceId': spaceId},
      );

  _i2.Future<List<_i18.Teams>> fetchMemberTeams(int memberId) =>
      caller.callServerEndpoint<List<_i18.Teams>>(
        'space',
        'fetchMemberTeams',
        {'memberId': memberId},
      );

  _i2.Future<_i22.Member?> fetchMemberByUserId(
    int spaceId,
    int userId,
  ) =>
      caller.callServerEndpoint<_i22.Member?>(
        'space',
        'fetchMemberByUserId',
        {
          'spaceId': spaceId,
          'userId': userId,
        },
      );

  _i2.Future<List<_i22.Member>> fetchMemberByMemberIds(List<int> memberIds) =>
      caller.callServerEndpoint<List<_i22.Member>>(
        'space',
        'fetchMemberByMemberIds',
        {'memberIds': memberIds},
      );

  _i2.Future<List<_i22.Member>> fetchSpaceMembers(int spaceId) =>
      caller.callServerEndpoint<List<_i22.Member>>(
        'space',
        'fetchSpaceMembers',
        {'spaceId': spaceId},
      );

  _i2.Future<List<_i24.SpaceInvite>> fetchSpaceInvites(int userId) =>
      caller.callServerEndpoint<List<_i24.SpaceInvite>>(
        'space',
        'fetchSpaceInvites',
        {'userId': userId},
      );

  _i2.Future<int> fetchSpaceCount(int userId) => caller.callServerEndpoint<int>(
        'space',
        'fetchSpaceCount',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointTeam extends _i1.EndpointRef {
  EndpointTeam(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'team';

  _i2.Future<void> removeTeam(
    int spaceId,
    int teamId,
    bool delDocs,
  ) =>
      caller.callServerEndpoint<void>(
        'team',
        'removeTeam',
        {
          'spaceId': spaceId,
          'teamId': teamId,
          'delDocs': delDocs,
        },
      );

  _i2.Future<void> editTeamRole(
    int memberId,
    int teamId,
    String newRole,
  ) =>
      caller.callServerEndpoint<void>(
        'team',
        'editTeamRole',
        {
          'memberId': memberId,
          'teamId': teamId,
          'newRole': newRole,
        },
      );

  _i2.Future<List<_i25.TeamMember>> fetchTeamRoles(int teamId) =>
      caller.callServerEndpoint<List<_i25.TeamMember>>(
        'team',
        'fetchTeamRoles',
        {'teamId': teamId},
      );

  _i2.Future<List<int>> alertAffects(
    List<int> memberId,
    int teamId,
  ) =>
      caller.callServerEndpoint<List<int>>(
        'team',
        'alertAffects',
        {
          'memberId': memberId,
          'teamId': teamId,
        },
      );

  _i2.Future<void> addTeamMember(List<_i25.TeamMember> newMembers) =>
      caller.callServerEndpoint<void>(
        'team',
        'addTeamMember',
        {'newMembers': newMembers},
      );

  _i2.Future<void> removeTeamMember(
    List<int> memberId,
    int teamId,
    bool deleteTasks,
    bool deleteDocs,
  ) =>
      caller.callServerEndpoint<void>(
        'team',
        'removeTeamMember',
        {
          'memberId': memberId,
          'teamId': teamId,
          'deleteTasks': deleteTasks,
          'deleteDocs': deleteDocs,
        },
      );

  _i2.Future<String> fetchTeamTitle(int teamId) =>
      caller.callServerEndpoint<String>(
        'team',
        'fetchTeamTitle',
        {'teamId': teamId},
      );

  _i2.Future<List<_i22.Member>> fetchNonTeamMembers(int teamId) =>
      caller.callServerEndpoint<List<_i22.Member>>(
        'team',
        'fetchNonTeamMembers',
        {'teamId': teamId},
      );

  _i2.Future<List<_i22.Member>> fetchTeamMembers(List<int> teamIds) =>
      caller.callServerEndpoint<List<_i22.Member>>(
        'team',
        'fetchTeamMembers',
        {'teamIds': teamIds},
      );

  _i2.Future<List<_i21.Project>> fetchTeamProjects(List<int> teamIds) =>
      caller.callServerEndpoint<List<_i21.Project>>(
        'team',
        'fetchTeamProjects',
        {'teamIds': teamIds},
      );

  _i2.Future<void> createMeeting(
    int teamId,
    String agenda,
    String url,
    DateTime time,
    Duration duration,
    String status,
    int creatorId,
    List<int> members,
  ) =>
      caller.callServerEndpoint<void>(
        'team',
        'createMeeting',
        {
          'teamId': teamId,
          'agenda': agenda,
          'url': url,
          'time': time,
          'duration': duration,
          'status': status,
          'creatorId': creatorId,
          'members': members,
        },
      );

  _i2.Future<List<_i27.Meetings>> fetchMeetings(List<int> teamIds) =>
      caller.callServerEndpoint<List<_i27.Meetings>>(
        'team',
        'fetchMeetings',
        {'teamIds': teamIds},
      );

  _i2.Future<void> updateMeeting(_i27.Meetings meeting) =>
      caller.callServerEndpoint<void>(
        'team',
        'updateMeeting',
        {'meeting': meeting},
      );

  _i2.Future<void> deleteMeeting(int meetingId) =>
      caller.callServerEndpoint<void>(
        'team',
        'deleteMeeting',
        {'meetingId': meetingId},
      );
}

/// {@category Endpoint}
class EndpointWork extends _i1.EndpointRef {
  EndpointWork(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'work';

  _i2.Future<void> createWorkOffer(
    int authorId,
    String authorName,
    String title,
    String pay,
    String offerType,
    String location,
    String description,
    int duration,
    List<String> qualifications,
  ) =>
      caller.callServerEndpoint<void>(
        'work',
        'createWorkOffer',
        {
          'authorId': authorId,
          'authorName': authorName,
          'title': title,
          'pay': pay,
          'offerType': offerType,
          'location': location,
          'description': description,
          'duration': duration,
          'qualifications': qualifications,
        },
      );

  _i2.Future<List<_i23.Offers>> fetchOffers() =>
      caller.callServerEndpoint<List<_i23.Offers>>(
        'work',
        'fetchOffers',
        {},
      );

  _i2.Future<int> haltApplications(
    int offerId,
    bool halt,
  ) =>
      caller.callServerEndpoint<int>(
        'work',
        'haltApplications',
        {
          'offerId': offerId,
          'halt': halt,
        },
      );

  _i2.Future<int> closeOffer(int offerId) => caller.callServerEndpoint<int>(
        'work',
        'closeOffer',
        {'offerId': offerId},
      );

  _i2.Future<void> deleteOffer(
    int? userId,
    int? offerId,
  ) =>
      caller.callServerEndpoint<void>(
        'work',
        'deleteOffer',
        {
          'userId': userId,
          'offerId': offerId,
        },
      );

  _i2.Future<void> submitApplication(
    _i23.Offers offerData,
    int? applicantId,
    String description,
    List<int> qualifyIndices,
  ) =>
      caller.callServerEndpoint<void>(
        'work',
        'submitApplication',
        {
          'offerData': offerData,
          'applicantId': applicantId,
          'description': description,
          'qualifyIndices': qualifyIndices,
        },
      );

  _i2.Future<void> withdrawApplication(
    int offerId,
    int? applicantId,
  ) =>
      caller.callServerEndpoint<void>(
        'work',
        'withdrawApplication',
        {
          'offerId': offerId,
          'applicantId': applicantId,
        },
      );

  _i2.Future<List<_i28.Applications>> fetchUserApplications(int userId) =>
      caller.callServerEndpoint<List<_i28.Applications>>(
        'work',
        'fetchUserApplications',
        {'userId': userId},
      );

  _i2.Future<List<_i23.Offers>> getOffersData(List<int> offerIds) =>
      caller.callServerEndpoint<List<_i23.Offers>>(
        'work',
        'getOffersData',
        {'offerIds': offerIds},
      );

  _i2.Future<List<_i23.Offers>> fetchSearchOffers(String pattern) =>
      caller.callServerEndpoint<List<_i23.Offers>>(
        'work',
        'fetchSearchOffers',
        {'pattern': pattern},
      );

  _i2.Future<List<_i23.Offers>> fetchAuthorOffers(int userId) =>
      caller.callServerEndpoint<List<_i23.Offers>>(
        'work',
        'fetchAuthorOffers',
        {'userId': userId},
      );

  _i2.Future<void> changeApplicationStatus(
    _i28.Applications application,
    String newStatus,
  ) =>
      caller.callServerEndpoint<void>(
        'work',
        'changeApplicationStatus',
        {
          'application': application,
          'newStatus': newStatus,
        },
      );

  _i2.Future<List<_i28.Applications>> fetchApplicationsForReview(int offerId) =>
      caller.callServerEndpoint<List<_i28.Applications>>(
        'work',
        'fetchApplicationsForReview',
        {'offerId': offerId},
      );

  _i2.Future<bool> hasApplied(
    int userId,
    int offerId,
  ) =>
      caller.callServerEndpoint<bool>(
        'work',
        'hasApplied',
        {
          'userId': userId,
          'offerId': offerId,
        },
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i29.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i29.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i30.Caller(client);
  }

  late final _i30.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i31.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    account = EndpointAccount(this);
    chat = EndpointChat(this);
    connection = EndpointConnection(this);
    example = EndpointExample(this);
    file = EndpointFile(this);
    notification = EndpointNotification(this);
    post = EndpointPost(this);
    project = EndpointProject(this);
    recommendation = EndpointRecommendation(this);
    space = EndpointSpace(this);
    team = EndpointTeam(this);
    work = EndpointWork(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointAccount account;

  late final EndpointChat chat;

  late final EndpointConnection connection;

  late final EndpointExample example;

  late final EndpointFile file;

  late final EndpointNotification notification;

  late final EndpointPost post;

  late final EndpointProject project;

  late final EndpointRecommendation recommendation;

  late final EndpointSpace space;

  late final EndpointTeam team;

  late final EndpointWork work;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'account': account,
        'chat': chat,
        'connection': connection,
        'example': example,
        'file': file,
        'notification': notification,
        'post': post,
        'project': project,
        'recommendation': recommendation,
        'space': space,
        'team': team,
        'work': work,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
