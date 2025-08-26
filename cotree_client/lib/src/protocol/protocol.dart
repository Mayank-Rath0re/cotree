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
import 'greeting.dart' as _i2;
import 'applications.dart' as _i3;
import 'chat.dart' as _i4;
import 'chat_participant.dart' as _i5;
import 'comment.dart' as _i6;
import 'connect.dart' as _i7;
import 'custom_details.dart' as _i8;
import 'documents.dart' as _i9;
import 'follow.dart' as _i10;
import 'individual.dart' as _i11;
import 'invitations.dart' as _i12;
import 'meetings.dart' as _i13;
import 'member.dart' as _i14;
import 'message.dart' as _i15;
import 'notification.dart' as _i16;
import 'offers.dart' as _i17;
import 'org.dart' as _i18;
import 'post.dart' as _i19;
import 'professional_data.dart' as _i20;
import 'project.dart' as _i21;
import 'project_assigned.dart' as _i22;
import 'reactions.dart' as _i23;
import 'reply.dart' as _i24;
import 'space.dart' as _i25;
import 'space_invite.dart' as _i26;
import 'task.dart' as _i27;
import 'task_assigned.dart' as _i28;
import 'team_member.dart' as _i29;
import 'teams.dart' as _i30;
import 'user.dart' as _i31;
import 'userview.dart' as _i32;
import 'package:cotree_client/src/protocol/userview.dart' as _i33;
import 'package:cotree_client/src/protocol/professional_data.dart' as _i34;
import 'package:cotree_client/src/protocol/custom_details.dart' as _i35;
import 'package:cotree_client/src/protocol/message.dart' as _i36;
import 'package:cotree_client/src/protocol/chat.dart' as _i37;
import 'package:cotree_client/src/protocol/notification.dart' as _i38;
import 'package:cotree_client/src/protocol/post.dart' as _i39;
import 'package:cotree_client/src/protocol/comment.dart' as _i40;
import 'package:cotree_client/src/protocol/teams.dart' as _i41;
import 'package:cotree_client/src/protocol/documents.dart' as _i42;
import 'package:cotree_client/src/protocol/task.dart' as _i43;
import 'package:cotree_client/src/protocol/member.dart' as _i44;
import 'package:cotree_client/src/protocol/offers.dart' as _i45;
import 'package:cotree_client/src/protocol/org.dart' as _i46;
import 'package:cotree_client/src/protocol/space_invite.dart' as _i47;
import 'package:cotree_client/src/protocol/team_member.dart' as _i48;
import 'package:cotree_client/src/protocol/space.dart' as _i49;
import 'package:cotree_client/src/protocol/project.dart' as _i50;
import 'package:cotree_client/src/protocol/meetings.dart' as _i51;
import 'package:cotree_client/src/protocol/applications.dart' as _i52;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i53;
export 'greeting.dart';
export 'applications.dart';
export 'chat.dart';
export 'chat_participant.dart';
export 'comment.dart';
export 'connect.dart';
export 'custom_details.dart';
export 'documents.dart';
export 'follow.dart';
export 'individual.dart';
export 'invitations.dart';
export 'meetings.dart';
export 'member.dart';
export 'message.dart';
export 'notification.dart';
export 'offers.dart';
export 'org.dart';
export 'post.dart';
export 'professional_data.dart';
export 'project.dart';
export 'project_assigned.dart';
export 'reactions.dart';
export 'reply.dart';
export 'space.dart';
export 'space_invite.dart';
export 'task.dart';
export 'task_assigned.dart';
export 'team_member.dart';
export 'teams.dart';
export 'user.dart';
export 'userview.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Greeting) {
      return _i2.Greeting.fromJson(data) as T;
    }
    if (t == _i3.Applications) {
      return _i3.Applications.fromJson(data) as T;
    }
    if (t == _i4.Chat) {
      return _i4.Chat.fromJson(data) as T;
    }
    if (t == _i5.ChatParticipant) {
      return _i5.ChatParticipant.fromJson(data) as T;
    }
    if (t == _i6.Comment) {
      return _i6.Comment.fromJson(data) as T;
    }
    if (t == _i7.Connect) {
      return _i7.Connect.fromJson(data) as T;
    }
    if (t == _i8.CustomDetails) {
      return _i8.CustomDetails.fromJson(data) as T;
    }
    if (t == _i9.Documents) {
      return _i9.Documents.fromJson(data) as T;
    }
    if (t == _i10.Follow) {
      return _i10.Follow.fromJson(data) as T;
    }
    if (t == _i11.Individual) {
      return _i11.Individual.fromJson(data) as T;
    }
    if (t == _i12.Invitation) {
      return _i12.Invitation.fromJson(data) as T;
    }
    if (t == _i13.Meetings) {
      return _i13.Meetings.fromJson(data) as T;
    }
    if (t == _i14.Member) {
      return _i14.Member.fromJson(data) as T;
    }
    if (t == _i15.Message) {
      return _i15.Message.fromJson(data) as T;
    }
    if (t == _i16.Notification) {
      return _i16.Notification.fromJson(data) as T;
    }
    if (t == _i17.Offers) {
      return _i17.Offers.fromJson(data) as T;
    }
    if (t == _i18.Organization) {
      return _i18.Organization.fromJson(data) as T;
    }
    if (t == _i19.Post) {
      return _i19.Post.fromJson(data) as T;
    }
    if (t == _i20.ProfessionalData) {
      return _i20.ProfessionalData.fromJson(data) as T;
    }
    if (t == _i21.Project) {
      return _i21.Project.fromJson(data) as T;
    }
    if (t == _i22.ProjectAssigned) {
      return _i22.ProjectAssigned.fromJson(data) as T;
    }
    if (t == _i23.Reaction) {
      return _i23.Reaction.fromJson(data) as T;
    }
    if (t == _i24.Reply) {
      return _i24.Reply.fromJson(data) as T;
    }
    if (t == _i25.Space) {
      return _i25.Space.fromJson(data) as T;
    }
    if (t == _i26.SpaceInvite) {
      return _i26.SpaceInvite.fromJson(data) as T;
    }
    if (t == _i27.Task) {
      return _i27.Task.fromJson(data) as T;
    }
    if (t == _i28.TaskAssigned) {
      return _i28.TaskAssigned.fromJson(data) as T;
    }
    if (t == _i29.TeamMember) {
      return _i29.TeamMember.fromJson(data) as T;
    }
    if (t == _i30.Teams) {
      return _i30.Teams.fromJson(data) as T;
    }
    if (t == _i31.User) {
      return _i31.User.fromJson(data) as T;
    }
    if (t == _i32.UserView) {
      return _i32.UserView.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Applications?>()) {
      return (data != null ? _i3.Applications.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Chat?>()) {
      return (data != null ? _i4.Chat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ChatParticipant?>()) {
      return (data != null ? _i5.ChatParticipant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Comment?>()) {
      return (data != null ? _i6.Comment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Connect?>()) {
      return (data != null ? _i7.Connect.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CustomDetails?>()) {
      return (data != null ? _i8.CustomDetails.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Documents?>()) {
      return (data != null ? _i9.Documents.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Follow?>()) {
      return (data != null ? _i10.Follow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Individual?>()) {
      return (data != null ? _i11.Individual.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Invitation?>()) {
      return (data != null ? _i12.Invitation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Meetings?>()) {
      return (data != null ? _i13.Meetings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Member?>()) {
      return (data != null ? _i14.Member.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Message?>()) {
      return (data != null ? _i15.Message.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Notification?>()) {
      return (data != null ? _i16.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Offers?>()) {
      return (data != null ? _i17.Offers.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Organization?>()) {
      return (data != null ? _i18.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Post?>()) {
      return (data != null ? _i19.Post.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ProfessionalData?>()) {
      return (data != null ? _i20.ProfessionalData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Project?>()) {
      return (data != null ? _i21.Project.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.ProjectAssigned?>()) {
      return (data != null ? _i22.ProjectAssigned.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Reaction?>()) {
      return (data != null ? _i23.Reaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.Reply?>()) {
      return (data != null ? _i24.Reply.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Space?>()) {
      return (data != null ? _i25.Space.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.SpaceInvite?>()) {
      return (data != null ? _i26.SpaceInvite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.Task?>()) {
      return (data != null ? _i27.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.TaskAssigned?>()) {
      return (data != null ? _i28.TaskAssigned.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.TeamMember?>()) {
      return (data != null ? _i29.TeamMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.Teams?>()) {
      return (data != null ? _i30.Teams.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.User?>()) {
      return (data != null ? _i31.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.UserView?>()) {
      return (data != null ? _i32.UserView.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i24.Reply>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.Reply>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.Invitation>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i12.Invitation>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.Invitation>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i12.Invitation>(e)).toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i8.CustomDetails>) {
      return (data as List)
          .map((e) => deserialize<_i8.CustomDetails>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == List<List<String>>) {
      return (data as List).map((e) => deserialize<List<String>>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i28.TaskAssigned>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i28.TaskAssigned>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i33.UserView>) {
      return (data as List).map((e) => deserialize<_i33.UserView>(e)).toList()
          as T;
    }
    if (t == List<_i34.ProfessionalData>) {
      return (data as List)
          .map((e) => deserialize<_i34.ProfessionalData>(e))
          .toList() as T;
    }
    if (t == List<_i35.CustomDetails>) {
      return (data as List)
          .map((e) => deserialize<_i35.CustomDetails>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i36.Message>) {
      return (data as List).map((e) => deserialize<_i36.Message>(e)).toList()
          as T;
    }
    if (t == List<_i37.Chat>) {
      return (data as List).map((e) => deserialize<_i37.Chat>(e)).toList() as T;
    }
    if (t == List<_i38.Notification>) {
      return (data as List)
          .map((e) => deserialize<_i38.Notification>(e))
          .toList() as T;
    }
    if (t == List<_i39.Post>) {
      return (data as List).map((e) => deserialize<_i39.Post>(e)).toList() as T;
    }
    if (t == List<_i40.Comment>) {
      return (data as List).map((e) => deserialize<_i40.Comment>(e)).toList()
          as T;
    }
    if (t == List<_i41.Teams>) {
      return (data as List).map((e) => deserialize<_i41.Teams>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i42.Documents>) {
      return (data as List).map((e) => deserialize<_i42.Documents>(e)).toList()
          as T;
    }
    if (t == List<_i43.Task>) {
      return (data as List).map((e) => deserialize<_i43.Task>(e)).toList() as T;
    }
    if (t == List<_i44.Member>) {
      return (data as List).map((e) => deserialize<_i44.Member>(e)).toList()
          as T;
    }
    if (t == List<_i45.Offers>) {
      return (data as List).map((e) => deserialize<_i45.Offers>(e)).toList()
          as T;
    }
    if (t == List<_i46.Organization>) {
      return (data as List)
          .map((e) => deserialize<_i46.Organization>(e))
          .toList() as T;
    }
    if (t == List<List<String>>) {
      return (data as List).map((e) => deserialize<List<String>>(e)).toList()
          as T;
    }
    if (t == List<_i47.SpaceInvite>) {
      return (data as List)
          .map((e) => deserialize<_i47.SpaceInvite>(e))
          .toList() as T;
    }
    if (t == List<_i48.TeamMember>) {
      return (data as List).map((e) => deserialize<_i48.TeamMember>(e)).toList()
          as T;
    }
    if (t == List<_i49.Space>) {
      return (data as List).map((e) => deserialize<_i49.Space>(e)).toList()
          as T;
    }
    if (t == List<_i50.Project>) {
      return (data as List).map((e) => deserialize<_i50.Project>(e)).toList()
          as T;
    }
    if (t == List<_i51.Meetings>) {
      return (data as List).map((e) => deserialize<_i51.Meetings>(e)).toList()
          as T;
    }
    if (t == List<_i52.Applications>) {
      return (data as List)
          .map((e) => deserialize<_i52.Applications>(e))
          .toList() as T;
    }
    try {
      return _i53.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Greeting) {
      return 'Greeting';
    }
    if (data is _i3.Applications) {
      return 'Applications';
    }
    if (data is _i4.Chat) {
      return 'Chat';
    }
    if (data is _i5.ChatParticipant) {
      return 'ChatParticipant';
    }
    if (data is _i6.Comment) {
      return 'Comment';
    }
    if (data is _i7.Connect) {
      return 'Connect';
    }
    if (data is _i8.CustomDetails) {
      return 'CustomDetails';
    }
    if (data is _i9.Documents) {
      return 'Documents';
    }
    if (data is _i10.Follow) {
      return 'Follow';
    }
    if (data is _i11.Individual) {
      return 'Individual';
    }
    if (data is _i12.Invitation) {
      return 'Invitation';
    }
    if (data is _i13.Meetings) {
      return 'Meetings';
    }
    if (data is _i14.Member) {
      return 'Member';
    }
    if (data is _i15.Message) {
      return 'Message';
    }
    if (data is _i16.Notification) {
      return 'Notification';
    }
    if (data is _i17.Offers) {
      return 'Offers';
    }
    if (data is _i18.Organization) {
      return 'Organization';
    }
    if (data is _i19.Post) {
      return 'Post';
    }
    if (data is _i20.ProfessionalData) {
      return 'ProfessionalData';
    }
    if (data is _i21.Project) {
      return 'Project';
    }
    if (data is _i22.ProjectAssigned) {
      return 'ProjectAssigned';
    }
    if (data is _i23.Reaction) {
      return 'Reaction';
    }
    if (data is _i24.Reply) {
      return 'Reply';
    }
    if (data is _i25.Space) {
      return 'Space';
    }
    if (data is _i26.SpaceInvite) {
      return 'SpaceInvite';
    }
    if (data is _i27.Task) {
      return 'Task';
    }
    if (data is _i28.TaskAssigned) {
      return 'TaskAssigned';
    }
    if (data is _i29.TeamMember) {
      return 'TeamMember';
    }
    if (data is _i30.Teams) {
      return 'Teams';
    }
    if (data is _i31.User) {
      return 'User';
    }
    if (data is _i32.UserView) {
      return 'UserView';
    }
    className = _i53.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i2.Greeting>(data['data']);
    }
    if (dataClassName == 'Applications') {
      return deserialize<_i3.Applications>(data['data']);
    }
    if (dataClassName == 'Chat') {
      return deserialize<_i4.Chat>(data['data']);
    }
    if (dataClassName == 'ChatParticipant') {
      return deserialize<_i5.ChatParticipant>(data['data']);
    }
    if (dataClassName == 'Comment') {
      return deserialize<_i6.Comment>(data['data']);
    }
    if (dataClassName == 'Connect') {
      return deserialize<_i7.Connect>(data['data']);
    }
    if (dataClassName == 'CustomDetails') {
      return deserialize<_i8.CustomDetails>(data['data']);
    }
    if (dataClassName == 'Documents') {
      return deserialize<_i9.Documents>(data['data']);
    }
    if (dataClassName == 'Follow') {
      return deserialize<_i10.Follow>(data['data']);
    }
    if (dataClassName == 'Individual') {
      return deserialize<_i11.Individual>(data['data']);
    }
    if (dataClassName == 'Invitation') {
      return deserialize<_i12.Invitation>(data['data']);
    }
    if (dataClassName == 'Meetings') {
      return deserialize<_i13.Meetings>(data['data']);
    }
    if (dataClassName == 'Member') {
      return deserialize<_i14.Member>(data['data']);
    }
    if (dataClassName == 'Message') {
      return deserialize<_i15.Message>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i16.Notification>(data['data']);
    }
    if (dataClassName == 'Offers') {
      return deserialize<_i17.Offers>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i18.Organization>(data['data']);
    }
    if (dataClassName == 'Post') {
      return deserialize<_i19.Post>(data['data']);
    }
    if (dataClassName == 'ProfessionalData') {
      return deserialize<_i20.ProfessionalData>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_i21.Project>(data['data']);
    }
    if (dataClassName == 'ProjectAssigned') {
      return deserialize<_i22.ProjectAssigned>(data['data']);
    }
    if (dataClassName == 'Reaction') {
      return deserialize<_i23.Reaction>(data['data']);
    }
    if (dataClassName == 'Reply') {
      return deserialize<_i24.Reply>(data['data']);
    }
    if (dataClassName == 'Space') {
      return deserialize<_i25.Space>(data['data']);
    }
    if (dataClassName == 'SpaceInvite') {
      return deserialize<_i26.SpaceInvite>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i27.Task>(data['data']);
    }
    if (dataClassName == 'TaskAssigned') {
      return deserialize<_i28.TaskAssigned>(data['data']);
    }
    if (dataClassName == 'TeamMember') {
      return deserialize<_i29.TeamMember>(data['data']);
    }
    if (dataClassName == 'Teams') {
      return deserialize<_i30.Teams>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i31.User>(data['data']);
    }
    if (dataClassName == 'UserView') {
      return deserialize<_i32.UserView>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i53.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
