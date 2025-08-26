/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/account_endpoint.dart' as _i2;
import '../endpoints/chat_endpoint.dart' as _i3;
import '../endpoints/connection_endpoint.dart' as _i4;
import '../endpoints/example_endpoint.dart' as _i5;
import '../endpoints/file_endpoint.dart' as _i6;
import '../endpoints/notification_endpoint.dart' as _i7;
import '../endpoints/post_endpoint.dart' as _i8;
import '../endpoints/project_endpoint.dart' as _i9;
import '../endpoints/recommendation_endpoint.dart' as _i10;
import '../endpoints/space_endpoint.dart' as _i11;
import '../endpoints/team_endpoint.dart' as _i12;
import '../endpoints/work_endpoint.dart' as _i13;
import '../greeting_endpoint.dart' as _i14;
import 'package:cotree_server/src/generated/userview.dart' as _i15;
import 'package:cotree_server/src/generated/custom_details.dart' as _i16;
import 'dart:typed_data' as _i17;
import 'package:cotree_server/src/generated/professional_data.dart' as _i18;
import 'package:cotree_server/src/generated/message.dart' as _i19;
import 'package:cotree_server/src/generated/invitations.dart' as _i20;
import 'package:cotree_server/src/generated/notification.dart' as _i21;
import 'package:cotree_server/src/generated/task.dart' as _i22;
import 'package:cotree_server/src/generated/space_invite.dart' as _i23;
import 'package:cotree_server/src/generated/member.dart' as _i24;
import 'package:cotree_server/src/generated/team_member.dart' as _i25;
import 'package:cotree_server/src/generated/meetings.dart' as _i26;
import 'package:cotree_server/src/generated/offers.dart' as _i27;
import 'package:cotree_server/src/generated/applications.dart' as _i28;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i29;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'account': _i2.AccountEndpoint()
        ..initialize(
          server,
          'account',
          null,
        ),
      'chat': _i3.ChatEndpoint()
        ..initialize(
          server,
          'chat',
          null,
        ),
      'connection': _i4.ConnectionEndpoint()
        ..initialize(
          server,
          'connection',
          null,
        ),
      'example': _i5.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'file': _i6.FileEndpoint()
        ..initialize(
          server,
          'file',
          null,
        ),
      'notification': _i7.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'post': _i8.PostEndpoint()
        ..initialize(
          server,
          'post',
          null,
        ),
      'project': _i9.ProjectEndpoint()
        ..initialize(
          server,
          'project',
          null,
        ),
      'recommendation': _i10.RecommendationEndpoint()
        ..initialize(
          server,
          'recommendation',
          null,
        ),
      'space': _i11.SpaceEndpoint()
        ..initialize(
          server,
          'space',
          null,
        ),
      'team': _i12.TeamEndpoint()
        ..initialize(
          server,
          'team',
          null,
        ),
      'work': _i13.WorkEndpoint()
        ..initialize(
          server,
          'work',
          null,
        ),
      'greeting': _i14.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['account'] = _i1.EndpointConnector(
      name: 'account',
      endpoint: endpoints['account']!,
      methodConnectors: {
        'createAccount': _i1.MethodConnector(
          name: 'createAccount',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'accountType': _i1.ParameterDescription(
              name: 'accountType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).createAccount(
            session,
            params['id'],
            params['name'],
            params['email'],
            params['accountType'],
            params['password'],
          ),
        ),
        'createUserView': _i1.MethodConnector(
          name: 'createUserView',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'headline': _i1.ParameterDescription(
              name: 'headline',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'avatar': _i1.ParameterDescription(
              name: 'avatar',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'accountType': _i1.ParameterDescription(
              name: 'accountType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).createUserView(
            session,
            params['userId'],
            params['name'],
            params['headline'],
            params['avatar'],
            params['accountType'],
          ),
        ),
        'getUserData': _i1.MethodConnector(
          name: 'getUserData',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).getUserData(
            session,
            params['id'],
          ),
        ),
        'updateIndivAccount': _i1.MethodConnector(
          name: 'updateIndivAccount',
          params: {
            'userview': _i1.ParameterDescription(
              name: 'userview',
              type: _i1.getType<_i15.UserView>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).updateIndivAccount(
            session,
            params['userview'],
          ),
        ),
        'getAllUser': _i1.MethodConnector(
          name: 'getAllUser',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).getAllUser(session),
        ),
        'getOrgs': _i1.MethodConnector(
          name: 'getOrgs',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).getOrgs(session),
        ),
        'getUserView': _i1.MethodConnector(
          name: 'getUserView',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).getUserView(
            session,
            params['userId'],
          ),
        ),
        'fetchUserProfessionalData': _i1.MethodConnector(
          name: 'fetchUserProfessionalData',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint)
                  .fetchUserProfessionalData(
            session,
            params['profileId'],
          ),
        ),
        'setupProfileI': _i1.MethodConnector(
          name: 'setupProfileI',
          params: {
            'headline': _i1.ParameterDescription(
              name: 'headline',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'bio': _i1.ParameterDescription(
              name: 'bio',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'gender': _i1.ParameterDescription(
              name: 'gender',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'residence': _i1.ParameterDescription(
              name: 'residence',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'dob': _i1.ParameterDescription(
              name: 'dob',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'contact': _i1.ParameterDescription(
              name: 'contact',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).setupProfileI(
            session,
            params['headline'],
            params['bio'],
            params['userId'],
            params['gender'],
            params['residence'],
            params['dob'],
            params['contact'],
          ),
        ),
        'setupProfileB': _i1.MethodConnector(
          name: 'setupProfileB',
          params: {
            'headline': _i1.ParameterDescription(
              name: 'headline',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'about': _i1.ParameterDescription(
              name: 'about',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'originDate': _i1.ParameterDescription(
              name: 'originDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'customInformation': _i1.ParameterDescription(
              name: 'customInformation',
              type: _i1.getType<List<_i16.CustomDetails>>(),
              nullable: false,
            ),
            'imageData': _i1.ParameterDescription(
              name: 'imageData',
              type: _i1.getType<_i17.ByteData?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).setupProfileB(
            session,
            params['headline'],
            params['about'],
            params['userId'],
            params['originDate'],
            params['customInformation'],
            params['imageData'],
          ),
        ),
        'getIndividualData': _i1.MethodConnector(
          name: 'getIndividualData',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).getIndividualData(
            session,
            params['userId'],
          ),
        ),
        'getOrganizationData': _i1.MethodConnector(
          name: 'getOrganizationData',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).getOrganizationData(
            session,
            params['userId'],
          ),
        ),
        'uploadImage': _i1.MethodConnector(
          name: 'uploadImage',
          params: {
            'imageData': _i1.ParameterDescription(
              name: 'imageData',
              type: _i1.getType<_i17.ByteData>(),
              nullable: false,
            ),
            'filename': _i1.ParameterDescription(
              name: 'filename',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).uploadImage(
            session,
            params['imageData'],
            params['filename'],
          ),
        ),
        'addProfessionalInfo': _i1.MethodConnector(
          name: 'addProfessionalInfo',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'institute': _i1.ParameterDescription(
              name: 'institute',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'supportingLink': _i1.ParameterDescription(
              name: 'supportingLink',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'images': _i1.ParameterDescription(
              name: 'images',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).addProfessionalInfo(
            session,
            params['profileId'],
            params['type'],
            params['title'],
            params['institute'],
            params['startDate'],
            params['endDate'],
            params['supportingLink'],
            params['images'],
          ),
        ),
        'editProfessionalData': _i1.MethodConnector(
          name: 'editProfessionalData',
          params: {
            'profData': _i1.ParameterDescription(
              name: 'profData',
              type: _i1.getType<_i18.ProfessionalData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint)
                  .editProfessionalData(
            session,
            params['profData'],
          ),
        ),
        'deleteProfessionalData': _i1.MethodConnector(
          name: 'deleteProfessionalData',
          params: {
            'profDataId': _i1.ParameterDescription(
              name: 'profDataId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint)
                  .deleteProfessionalData(
            session,
            params['profDataId'],
          ),
        ),
        'getUserAvatarUrl': _i1.MethodConnector(
          name: 'getUserAvatarUrl',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).getUserAvatarUrl(
            session,
            params['userId'],
          ),
        ),
        'updateAvatar': _i1.MethodConnector(
          name: 'updateAvatar',
          params: {
            'userview': _i1.ParameterDescription(
              name: 'userview',
              type: _i1.getType<_i15.UserView>(),
              nullable: false,
            ),
            'url': _i1.ParameterDescription(
              name: 'url',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).updateAvatar(
            session,
            params['userview'],
            params['url'],
          ),
        ),
        'removeAvatar': _i1.MethodConnector(
          name: 'removeAvatar',
          params: {
            'userview': _i1.ParameterDescription(
              name: 'userview',
              type: _i1.getType<_i15.UserView>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).removeAvatar(
            session,
            params['userview'],
          ),
        ),
        'fetchUserConnectionCount': _i1.MethodConnector(
          name: 'fetchUserConnectionCount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint)
                  .fetchUserConnectionCount(
            session,
            params['userId'],
          ),
        ),
        'fetchUserSpaceCount': _i1.MethodConnector(
          name: 'fetchUserSpaceCount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['account'] as _i2.AccountEndpoint).fetchUserSpaceCount(
            session,
            params['userId'],
          ),
        ),
        'userSearch': _i1.MethodStreamConnector(
          name: 'userSearch',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['account'] as _i2.AccountEndpoint).userSearch(
            session,
            params['userId'],
            params['query'],
          ),
        ),
      },
    );
    connectors['chat'] = _i1.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'sendMessage': _i1.MethodConnector(
          name: 'sendMessage',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<_i19.Message>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).sendMessage(
            session,
            params['chatId'],
            params['message'],
          ),
        ),
        'fetchChatMessages': _i1.MethodConnector(
          name: 'fetchChatMessages',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'participantId': _i1.ParameterDescription(
              name: 'participantId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).fetchChatMessages(
            session,
            params['chatId'],
            params['participantId'],
          ),
        ),
        'fetchChatUserViews': _i1.MethodConnector(
          name: 'fetchChatUserViews',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).fetchChatUserViews(
            session,
            params['chatId'],
          ),
        ),
        'createNewChat': _i1.MethodConnector(
          name: 'createNewChat',
          params: {
            'user1Id': _i1.ParameterDescription(
              name: 'user1Id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'user2Id': _i1.ParameterDescription(
              name: 'user2Id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).createNewChat(
            session,
            params['user1Id'],
            params['user2Id'],
          ),
        ),
        'getOrCreateChat': _i1.MethodConnector(
          name: 'getOrCreateChat',
          params: {
            'user1Id': _i1.ParameterDescription(
              name: 'user1Id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'user2Id': _i1.ParameterDescription(
              name: 'user2Id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).getOrCreateChat(
            session,
            params['user1Id'],
            params['user2Id'],
          ),
        ),
        'retrieveDmChats': _i1.MethodConnector(
          name: 'retrieveDmChats',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).retrieveDmChats(
            session,
            params['userId'],
          ),
        ),
        'getUserChats': _i1.MethodConnector(
          name: 'getUserChats',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).getUserChats(
            session,
            params['userId'],
          ),
        ),
        'retrieveChats': _i1.MethodConnector(
          name: 'retrieveChats',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).retrieveChats(
            session,
            params['userId'],
          ),
        ),
        'deleteChat': _i1.MethodConnector(
          name: 'deleteChat',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i3.ChatEndpoint).deleteChat(
            session,
            params['chatId'],
            params['userId'],
          ),
        ),
        'messageStream': _i1.MethodStreamConnector(
          name: 'messageStream',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['chat'] as _i3.ChatEndpoint).messageStream(
            session,
            params['chatId'],
          ),
        ),
        'chatUserSearch': _i1.MethodStreamConnector(
          name: 'chatUserSearch',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['chat'] as _i3.ChatEndpoint).chatUserSearch(
            session,
            params['userId'],
            params['query'],
          ),
        ),
      },
    );
    connectors['connection'] = _i1.EndpointConnector(
      name: 'connection',
      endpoint: endpoints['connection']!,
      methodConnectors: {
        'fetchConnectData': _i1.MethodConnector(
          name: 'fetchConnectData',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .fetchConnectData(
            session,
            params['userId'],
          ),
        ),
        'isConnection': _i1.MethodConnector(
          name: 'isConnection',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'secondaryUserId': _i1.ParameterDescription(
              name: 'secondaryUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint).isConnection(
            session,
            params['userId'],
            params['secondaryUserId'],
          ),
        ),
        'sendConnectionRequest': _i1.MethodConnector(
          name: 'sendConnectionRequest',
          params: {
            'senderId': _i1.ParameterDescription(
              name: 'senderId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'receiverId': _i1.ParameterDescription(
              name: 'receiverId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'personalText': _i1.ParameterDescription(
              name: 'personalText',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .sendConnectionRequest(
            session,
            params['senderId'],
            params['receiverId'],
            params['personalText'],
          ),
        ),
        'getInviteData': _i1.MethodConnector(
          name: 'getInviteData',
          params: {
            'receiverId': _i1.ParameterDescription(
              name: 'receiverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'secondaryId': _i1.ParameterDescription(
              name: 'secondaryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint).getInviteData(
            session,
            params['receiverId'],
            params['secondaryId'],
          ),
        ),
        'confirmConnection': _i1.MethodConnector(
          name: 'confirmConnection',
          params: {
            'receiverId': _i1.ParameterDescription(
              name: 'receiverId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'invite': _i1.ParameterDescription(
              name: 'invite',
              type: _i1.getType<_i20.Invitation>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .confirmConnection(
            session,
            params['receiverId'],
            params['invite'],
          ),
        ),
        'withdrawConnection': _i1.MethodConnector(
          name: 'withdrawConnection',
          params: {
            'senderId': _i1.ParameterDescription(
              name: 'senderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'invite': _i1.ParameterDescription(
              name: 'invite',
              type: _i1.getType<_i20.Invitation>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .withdrawConnection(
            session,
            params['senderId'],
            params['invite'],
          ),
        ),
        'rejectConnection': _i1.MethodConnector(
          name: 'rejectConnection',
          params: {
            'receiverId': _i1.ParameterDescription(
              name: 'receiverId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'invite': _i1.ParameterDescription(
              name: 'invite',
              type: _i1.getType<_i20.Invitation>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .rejectConnection(
            session,
            params['receiverId'],
            params['invite'],
          ),
        ),
        'removeConnection': _i1.MethodConnector(
          name: 'removeConnection',
          params: {
            'userId1': _i1.ParameterDescription(
              name: 'userId1',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId2': _i1.ParameterDescription(
              name: 'userId2',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .removeConnection(
            session,
            params['userId1'],
            params['userId2'],
          ),
        ),
        'getConnectedUserData': _i1.MethodConnector(
          name: 'getConnectedUserData',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .getConnectedUserData(
            session,
            params['userId'],
          ),
        ),
        'followOrg': _i1.MethodConnector(
          name: 'followOrg',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orgId': _i1.ParameterDescription(
              name: 'orgId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint).followOrg(
            session,
            params['profileId'],
            params['orgId'],
          ),
        ),
        'unfollowOrg': _i1.MethodConnector(
          name: 'unfollowOrg',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orgId': _i1.ParameterDescription(
              name: 'orgId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint).unfollowOrg(
            session,
            params['profileId'],
            params['orgId'],
          ),
        ),
        'followerCount': _i1.MethodConnector(
          name: 'followerCount',
          params: {
            'orgId': _i1.ParameterDescription(
              name: 'orgId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint).followerCount(
            session,
            params['orgId'],
          ),
        ),
        'isFollowingOrg': _i1.MethodConnector(
          name: 'isFollowingOrg',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orgId': _i1.ParameterDescription(
              name: 'orgId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .isFollowingOrg(
            session,
            params['profileId'],
            params['orgId'],
          ),
        ),
        'fetchFollowedOrgs': _i1.MethodConnector(
          name: 'fetchFollowedOrgs',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['connection'] as _i4.ConnectionEndpoint)
                  .fetchFollowedOrgs(
            session,
            params['profileId'],
          ),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i5.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['file'] = _i1.EndpointConnector(
      name: 'file',
      endpoint: endpoints['file']!,
      methodConnectors: {
        'getUploadDescription': _i1.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['file'] as _i6.FileEndpoint).getUploadDescription(
            session,
            params['path'],
          ),
        ),
        'verifyUpload': _i1.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['file'] as _i6.FileEndpoint).verifyUpload(
            session,
            params['path'],
          ),
        ),
        'getPublicUrl': _i1.MethodConnector(
          name: 'getPublicUrl',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['file'] as _i6.FileEndpoint).getPublicUrl(
            session,
            params['path'],
          ),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'createNotification': _i1.MethodConnector(
          name: 'createNotification',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'referencedUser': _i1.ParameterDescription(
              name: 'referencedUser',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'objectId': _i1.ParameterDescription(
              name: 'objectId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'objectType': _i1.ParameterDescription(
              name: 'objectType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i7.NotificationEndpoint)
                  .createNotification(
            session,
            params['userId'],
            params['content'],
            params['referencedUser'],
            params['objectId'],
            params['objectType'],
          ),
        ),
        'notifyMyConnections': _i1.MethodConnector(
          name: 'notifyMyConnections',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'objectId': _i1.ParameterDescription(
              name: 'objectId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'objectType': _i1.ParameterDescription(
              name: 'objectType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i7.NotificationEndpoint)
                  .notifyMyConnections(
            session,
            params['userId'],
            params['content'],
            params['objectId'],
            params['objectType'],
          ),
        ),
        'anyUnreadNotifications': _i1.MethodConnector(
          name: 'anyUnreadNotifications',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i7.NotificationEndpoint)
                  .anyUnreadNotifications(
            session,
            params['userId'],
          ),
        ),
        'markRead': _i1.MethodConnector(
          name: 'markRead',
          params: {
            'notifications': _i1.ParameterDescription(
              name: 'notifications',
              type: _i1.getType<List<_i21.Notification>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i7.NotificationEndpoint).markRead(
            session,
            params['notifications'],
          ),
        ),
        'fetchUserNotifications': _i1.MethodConnector(
          name: 'fetchUserNotifications',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i7.NotificationEndpoint)
                  .fetchUserNotifications(
            session,
            params['userId'],
          ),
        ),
      },
    );
    connectors['post'] = _i1.EndpointConnector(
      name: 'post',
      endpoint: endpoints['post']!,
      methodConnectors: {
        'createPost': _i1.MethodConnector(
          name: 'createPost',
          params: {
            'authorId': _i1.ParameterDescription(
              name: 'authorId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'mediaList': _i1.ParameterDescription(
              name: 'mediaList',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).createPost(
            session,
            params['authorId'],
            params['text'],
            params['mediaList'],
          ),
        ),
        'deletePost': _i1.MethodConnector(
          name: 'deletePost',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).deletePost(
            session,
            params['postId'],
          ),
        ),
        'retrieveAllPosts': _i1.MethodConnector(
          name: 'retrieveAllPosts',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).retrieveAllPosts(session),
        ),
        'retrievePost': _i1.MethodConnector(
          name: 'retrievePost',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).retrievePost(
            session,
            params['postId'],
          ),
        ),
        'fetchLastUserPost': _i1.MethodConnector(
          name: 'fetchLastUserPost',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).fetchLastUserPost(
            session,
            params['userId'],
          ),
        ),
        'fetchUserPosts': _i1.MethodConnector(
          name: 'fetchUserPosts',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).fetchUserPosts(
            session,
            params['userId'],
          ),
        ),
        'uploadComment': _i1.MethodConnector(
          name: 'uploadComment',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'authorId': _i1.ParameterDescription(
              name: 'authorId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'media': _i1.ParameterDescription(
              name: 'media',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).uploadComment(
            session,
            params['postId'],
            params['authorId'],
            params['text'],
            params['media'],
          ),
        ),
        'fetchReaction': _i1.MethodConnector(
          name: 'fetchReaction',
          params: {
            'objectType': _i1.ParameterDescription(
              name: 'objectType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'objectId': _i1.ParameterDescription(
              name: 'objectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).fetchReaction(
            session,
            params['objectType'],
            params['objectId'],
            params['userId'],
          ),
        ),
        'fetchReactionCount': _i1.MethodConnector(
          name: 'fetchReactionCount',
          params: {
            'objectId': _i1.ParameterDescription(
              name: 'objectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'objectType': _i1.ParameterDescription(
              name: 'objectType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).fetchReactionCount(
            session,
            params['objectId'],
            params['objectType'],
          ),
        ),
        'updateReaction': _i1.MethodConnector(
          name: 'updateReaction',
          params: {
            'objectId': _i1.ParameterDescription(
              name: 'objectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'authorId': _i1.ParameterDescription(
              name: 'authorId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reactablTtype': _i1.ParameterDescription(
              name: 'reactablTtype',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).updateReaction(
            session,
            params['objectId'],
            params['authorId'],
            params['reactablTtype'],
            params['userId'],
            type: params['type'],
          ),
        ),
        'fetchComments': _i1.MethodConnector(
          name: 'fetchComments',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).fetchComments(
            session,
            params['postId'],
          ),
        ),
        'deleteComment': _i1.MethodConnector(
          name: 'deleteComment',
          params: {
            'commentId': _i1.ParameterDescription(
              name: 'commentId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).deleteComment(
            session,
            params['commentId'],
          ),
        ),
        'uploadFile': _i1.MethodConnector(
          name: 'uploadFile',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageData': _i1.ParameterDescription(
              name: 'imageData',
              type: _i1.getType<_i17.ByteData>(),
              nullable: false,
            ),
            'filename': _i1.ParameterDescription(
              name: 'filename',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['post'] as _i8.PostEndpoint).uploadFile(
            session,
            params['userId'],
            params['imageData'],
            params['filename'],
          ),
        ),
      },
    );
    connectors['project'] = _i1.EndpointConnector(
      name: 'project',
      endpoint: endpoints['project']!,
      methodConnectors: {
        'removeProject': _i1.MethodConnector(
          name: 'removeProject',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).removeProject(
            session,
            params['spaceId'],
            params['projectId'],
          ),
        ),
        'changeProjectStatus': _i1.MethodConnector(
          name: 'changeProjectStatus',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newStatus': _i1.ParameterDescription(
              name: 'newStatus',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).changeProjectStatus(
            session,
            params['projectId'],
            params['newStatus'],
          ),
        ),
        'fetchExcludedProjectTeams': _i1.MethodConnector(
          name: 'fetchExcludedProjectTeams',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint)
                  .fetchExcludedProjectTeams(
            session,
            params['projectId'],
          ),
        ),
        'updateAssignedTeams': _i1.MethodConnector(
          name: 'updateAssignedTeams',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'deletedTeamsIds': _i1.ParameterDescription(
              name: 'deletedTeamsIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'addedTeamsIds': _i1.ParameterDescription(
              name: 'addedTeamsIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'deleteDocuments': _i1.ParameterDescription(
              name: 'deleteDocuments',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).updateAssignedTeams(
            session,
            params['projectId'],
            params['deletedTeamsIds'],
            params['addedTeamsIds'],
            params['deleteDocuments'],
          ),
        ),
        'uploadFile': _i1.MethodConnector(
          name: 'uploadFile',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fileData': _i1.ParameterDescription(
              name: 'fileData',
              type: _i1.getType<_i17.ByteData>(),
              nullable: false,
            ),
            'filename': _i1.ParameterDescription(
              name: 'filename',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).uploadFile(
            session,
            params['projectId'],
            params['memberId'],
            params['fileData'],
            params['filename'],
          ),
        ),
        'fetchDocuments': _i1.MethodConnector(
          name: 'fetchDocuments',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).fetchDocuments(
            session,
            params['projectId'],
          ),
        ),
        'deleteDocument': _i1.MethodConnector(
          name: 'deleteDocument',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).deleteDocument(
            session,
            params['documentId'],
          ),
        ),
        'createTask': _i1.MethodConnector(
          name: 'createTask',
          params: {
            'task': _i1.ParameterDescription(
              name: 'task',
              type: _i1.getType<_i22.Task>(),
              nullable: false,
            ),
            'assignedIds': _i1.ParameterDescription(
              name: 'assignedIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).createTask(
            session,
            params['task'],
            params['assignedIds'],
          ),
        ),
        'fetchMemberTasks': _i1.MethodConnector(
          name: 'fetchMemberTasks',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).fetchMemberTasks(
            session,
            params['memberId'],
          ),
        ),
        'fetchTasks': _i1.MethodConnector(
          name: 'fetchTasks',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).fetchTasks(
            session,
            params['projectId'],
          ),
        ),
        'fetchProject': _i1.MethodConnector(
          name: 'fetchProject',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).fetchProject(
            session,
            params['projectId'],
          ),
        ),
        'fetchProjectTeams': _i1.MethodConnector(
          name: 'fetchProjectTeams',
          params: {
            'projectIds': _i1.ParameterDescription(
              name: 'projectIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).fetchProjectTeams(
            session,
            params['projectIds'],
          ),
        ),
        'fetchProjectMembers': _i1.MethodConnector(
          name: 'fetchProjectMembers',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).fetchProjectMembers(
            session,
            params['projectId'],
          ),
        ),
        'updateTask': _i1.MethodConnector(
          name: 'updateTask',
          params: {
            'taskObj': _i1.ParameterDescription(
              name: 'taskObj',
              type: _i1.getType<_i22.Task>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).updateTask(
            session,
            params['taskObj'],
          ),
        ),
        'deleteTask': _i1.MethodConnector(
          name: 'deleteTask',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['project'] as _i9.ProjectEndpoint).deleteTask(
            session,
            params['taskId'],
          ),
        ),
      },
    );
    connectors['recommendation'] = _i1.EndpointConnector(
      name: 'recommendation',
      endpoint: endpoints['recommendation']!,
      methodConnectors: {
        'recommendPosts': _i1.MethodConnector(
          name: 'recommendPosts',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['recommendation'] as _i10.RecommendationEndpoint)
                  .recommendPosts(
            session,
            params['userId'],
          ),
        ),
        'recommendOffers': _i1.MethodConnector(
          name: 'recommendOffers',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['recommendation'] as _i10.RecommendationEndpoint)
                  .recommendOffers(
            session,
            params['userId'],
          ),
        ),
        'recommendOrganizations': _i1.MethodConnector(
          name: 'recommendOrganizations',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['recommendation'] as _i10.RecommendationEndpoint)
                  .recommendOrganizations(
            session,
            params['userId'],
          ),
        ),
        'recommendUsers': _i1.MethodConnector(
          name: 'recommendUsers',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['recommendation'] as _i10.RecommendationEndpoint)
                  .recommendUsers(
            session,
            params['userId'],
            limit: params['limit'],
          ),
        ),
      },
    );
    connectors['space'] = _i1.EndpointConnector(
      name: 'space',
      endpoint: endpoints['space']!,
      methodConnectors: {
        'createSpace': _i1.MethodConnector(
          name: 'createSpace',
          params: {
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'url': _i1.ParameterDescription(
              name: 'url',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'credentials': _i1.ParameterDescription(
              name: 'credentials',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).createSpace(
            session,
            params['creatorId'],
            params['title'],
            params['description'],
            params['url'],
            params['credentials'],
          ),
        ),
        'deleteSpace': _i1.MethodConnector(
          name: 'deleteSpace',
          params: {
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).deleteSpace(
            session,
            params['creatorId'],
            params['spaceId'],
          ),
        ),
        'createTeam': _i1.MethodConnector(
          name: 'createTeam',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'members': _i1.ParameterDescription(
              name: 'members',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).createTeam(
            session,
            params['spaceId'],
            params['title'],
            params['members'],
            params['role'],
          ),
        ),
        'createProject': _i1.MethodConnector(
          name: 'createProject',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'overview': _i1.ParameterDescription(
              name: 'overview',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'teamAssigned': _i1.ParameterDescription(
              name: 'teamAssigned',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).createProject(
            session,
            params['spaceId'],
            params['title'],
            params['overview'],
            params['teamAssigned'],
          ),
        ),
        'addOwner': _i1.MethodConnector(
          name: 'addOwner',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userview': _i1.ParameterDescription(
              name: 'userview',
              type: _i1.getType<_i15.UserView>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).addOwner(
            session,
            params['userId'],
            params['spaceId'],
            params['userview'],
          ),
        ),
        'createSpaceInvite': _i1.MethodConnector(
          name: 'createSpaceInvite',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'designation': _i1.ParameterDescription(
              name: 'designation',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'teamAndRoles': _i1.ParameterDescription(
              name: 'teamAndRoles',
              type: _i1.getType<List<List<String>>>(),
              nullable: false,
            ),
            'globalRole': _i1.ParameterDescription(
              name: 'globalRole',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sentBy': _i1.ParameterDescription(
              name: 'sentBy',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).createSpaceInvite(
            session,
            params['userId'],
            params['spaceId'],
            params['designation'],
            params['teamAndRoles'],
            params['globalRole'],
            params['sentBy'],
          ),
        ),
        'markInviteRead': _i1.MethodConnector(
          name: 'markInviteRead',
          params: {
            'invites': _i1.ParameterDescription(
              name: 'invites',
              type: _i1.getType<List<_i23.SpaceInvite>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).markInviteRead(
            session,
            params['invites'],
          ),
        ),
        'unreadInvites': _i1.MethodConnector(
          name: 'unreadInvites',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).unreadInvites(
            session,
            params['userId'],
          ),
        ),
        'acceptInvite': _i1.MethodConnector(
          name: 'acceptInvite',
          params: {
            'spaceInviteId': _i1.ParameterDescription(
              name: 'spaceInviteId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).acceptInvite(
            session,
            params['spaceInviteId'],
          ),
        ),
        'addMember': _i1.MethodConnector(
          name: 'addMember',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'spInvite': _i1.ParameterDescription(
              name: 'spInvite',
              type: _i1.getType<_i23.SpaceInvite>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).addMember(
            session,
            params['userId'],
            params['spInvite'],
          ),
        ),
        'removeMember': _i1.MethodConnector(
          name: 'removeMember',
          params: {
            'memberIds': _i1.ParameterDescription(
              name: 'memberIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).removeMember(
            session,
            params['memberIds'],
          ),
        ),
        'editMemberRoles': _i1.MethodConnector(
          name: 'editMemberRoles',
          params: {
            'members': _i1.ParameterDescription(
              name: 'members',
              type: _i1.getType<List<_i24.Member>>(),
              nullable: false,
            ),
            'teamRoles': _i1.ParameterDescription(
              name: 'teamRoles',
              type: _i1.getType<List<_i25.TeamMember>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).editMemberRoles(
            session,
            params['members'],
            params['teamRoles'],
          ),
        ),
        'fetchSpacesByUser': _i1.MethodConnector(
          name: 'fetchSpacesByUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchSpacesByUser(
            session,
            params['userId'],
          ),
        ),
        'fetchSpace': _i1.MethodConnector(
          name: 'fetchSpace',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchSpace(
            session,
            params['spaceId'],
          ),
        ),
        'fetchMember': _i1.MethodConnector(
          name: 'fetchMember',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchMember(
            session,
            params['userId'],
          ),
        ),
        'fetchTitles': _i1.MethodConnector(
          name: 'fetchTitles',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchTitles(
            session,
            params['spaceId'],
          ),
        ),
        'fetchProjectsByUser': _i1.MethodConnector(
          name: 'fetchProjectsByUser',
          params: {
            'teams': _i1.ParameterDescription(
              name: 'teams',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchProjectsByUser(
            session,
            params['teams'],
          ),
        ),
        'fetchSpaceTeams': _i1.MethodConnector(
          name: 'fetchSpaceTeams',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchSpaceTeams(
            session,
            params['spaceId'],
          ),
        ),
        'fetchSpaceProjects': _i1.MethodConnector(
          name: 'fetchSpaceProjects',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchSpaceProjects(
            session,
            params['spaceId'],
          ),
        ),
        'fetchMemberTeams': _i1.MethodConnector(
          name: 'fetchMemberTeams',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchMemberTeams(
            session,
            params['memberId'],
          ),
        ),
        'fetchMemberByUserId': _i1.MethodConnector(
          name: 'fetchMemberByUserId',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchMemberByUserId(
            session,
            params['spaceId'],
            params['userId'],
          ),
        ),
        'fetchMemberByMemberIds': _i1.MethodConnector(
          name: 'fetchMemberByMemberIds',
          params: {
            'memberIds': _i1.ParameterDescription(
              name: 'memberIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchMemberByMemberIds(
            session,
            params['memberIds'],
          ),
        ),
        'fetchSpaceMembers': _i1.MethodConnector(
          name: 'fetchSpaceMembers',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchSpaceMembers(
            session,
            params['spaceId'],
          ),
        ),
        'fetchSpaceInvites': _i1.MethodConnector(
          name: 'fetchSpaceInvites',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchSpaceInvites(
            session,
            params['userId'],
          ),
        ),
        'fetchSpaceCount': _i1.MethodConnector(
          name: 'fetchSpaceCount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['space'] as _i11.SpaceEndpoint).fetchSpaceCount(
            session,
            params['userId'],
          ),
        ),
        'searchMemberByName': _i1.MethodStreamConnector(
          name: 'searchMemberByName',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['space'] as _i11.SpaceEndpoint).searchMemberByName(
            session,
            params['spaceId'],
            params['query'],
          ),
        ),
      },
    );
    connectors['team'] = _i1.EndpointConnector(
      name: 'team',
      endpoint: endpoints['team']!,
      methodConnectors: {
        'removeTeam': _i1.MethodConnector(
          name: 'removeTeam',
          params: {
            'spaceId': _i1.ParameterDescription(
              name: 'spaceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'delDocs': _i1.ParameterDescription(
              name: 'delDocs',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).removeTeam(
            session,
            params['spaceId'],
            params['teamId'],
            params['delDocs'],
          ),
        ),
        'editTeamRole': _i1.MethodConnector(
          name: 'editTeamRole',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newRole': _i1.ParameterDescription(
              name: 'newRole',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).editTeamRole(
            session,
            params['memberId'],
            params['teamId'],
            params['newRole'],
          ),
        ),
        'fetchTeamRoles': _i1.MethodConnector(
          name: 'fetchTeamRoles',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).fetchTeamRoles(
            session,
            params['teamId'],
          ),
        ),
        'alertAffects': _i1.MethodConnector(
          name: 'alertAffects',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).alertAffects(
            session,
            params['memberId'],
            params['teamId'],
          ),
        ),
        'addTeamMember': _i1.MethodConnector(
          name: 'addTeamMember',
          params: {
            'newMembers': _i1.ParameterDescription(
              name: 'newMembers',
              type: _i1.getType<List<_i25.TeamMember>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).addTeamMember(
            session,
            params['newMembers'],
          ),
        ),
        'removeTeamMember': _i1.MethodConnector(
          name: 'removeTeamMember',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'deleteTasks': _i1.ParameterDescription(
              name: 'deleteTasks',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'deleteDocs': _i1.ParameterDescription(
              name: 'deleteDocs',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).removeTeamMember(
            session,
            params['memberId'],
            params['teamId'],
            params['deleteTasks'],
            params['deleteDocs'],
          ),
        ),
        'fetchTeamTitle': _i1.MethodConnector(
          name: 'fetchTeamTitle',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).fetchTeamTitle(
            session,
            params['teamId'],
          ),
        ),
        'fetchNonTeamMembers': _i1.MethodConnector(
          name: 'fetchNonTeamMembers',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).fetchNonTeamMembers(
            session,
            params['teamId'],
          ),
        ),
        'fetchTeamMembers': _i1.MethodConnector(
          name: 'fetchTeamMembers',
          params: {
            'teamIds': _i1.ParameterDescription(
              name: 'teamIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).fetchTeamMembers(
            session,
            params['teamIds'],
          ),
        ),
        'fetchTeamProjects': _i1.MethodConnector(
          name: 'fetchTeamProjects',
          params: {
            'teamIds': _i1.ParameterDescription(
              name: 'teamIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).fetchTeamProjects(
            session,
            params['teamIds'],
          ),
        ),
        'createMeeting': _i1.MethodConnector(
          name: 'createMeeting',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'agenda': _i1.ParameterDescription(
              name: 'agenda',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'url': _i1.ParameterDescription(
              name: 'url',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'time': _i1.ParameterDescription(
              name: 'time',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'duration': _i1.ParameterDescription(
              name: 'duration',
              type: _i1.getType<Duration>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'members': _i1.ParameterDescription(
              name: 'members',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).createMeeting(
            session,
            params['teamId'],
            params['agenda'],
            params['url'],
            params['time'],
            params['duration'],
            params['status'],
            params['creatorId'],
            params['members'],
          ),
        ),
        'fetchMeetings': _i1.MethodConnector(
          name: 'fetchMeetings',
          params: {
            'teamIds': _i1.ParameterDescription(
              name: 'teamIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).fetchMeetings(
            session,
            params['teamIds'],
          ),
        ),
        'updateMeeting': _i1.MethodConnector(
          name: 'updateMeeting',
          params: {
            'meeting': _i1.ParameterDescription(
              name: 'meeting',
              type: _i1.getType<_i26.Meetings>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).updateMeeting(
            session,
            params['meeting'],
          ),
        ),
        'deleteMeeting': _i1.MethodConnector(
          name: 'deleteMeeting',
          params: {
            'meetingId': _i1.ParameterDescription(
              name: 'meetingId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['team'] as _i12.TeamEndpoint).deleteMeeting(
            session,
            params['meetingId'],
          ),
        ),
      },
    );
    connectors['work'] = _i1.EndpointConnector(
      name: 'work',
      endpoint: endpoints['work']!,
      methodConnectors: {
        'createWorkOffer': _i1.MethodConnector(
          name: 'createWorkOffer',
          params: {
            'authorId': _i1.ParameterDescription(
              name: 'authorId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'authorName': _i1.ParameterDescription(
              name: 'authorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'pay': _i1.ParameterDescription(
              name: 'pay',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'offerType': _i1.ParameterDescription(
              name: 'offerType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'duration': _i1.ParameterDescription(
              name: 'duration',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'qualifications': _i1.ParameterDescription(
              name: 'qualifications',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).createWorkOffer(
            session,
            params['authorId'],
            params['authorName'],
            params['title'],
            params['pay'],
            params['offerType'],
            params['location'],
            params['description'],
            params['duration'],
            params['qualifications'],
          ),
        ),
        'fetchOffers': _i1.MethodConnector(
          name: 'fetchOffers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).fetchOffers(session),
        ),
        'haltApplications': _i1.MethodConnector(
          name: 'haltApplications',
          params: {
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'halt': _i1.ParameterDescription(
              name: 'halt',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).haltApplications(
            session,
            params['offerId'],
            params['halt'],
          ),
        ),
        'closeOffer': _i1.MethodConnector(
          name: 'closeOffer',
          params: {
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).closeOffer(
            session,
            params['offerId'],
          ),
        ),
        'deleteOffer': _i1.MethodConnector(
          name: 'deleteOffer',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).deleteOffer(
            session,
            params['userId'],
            params['offerId'],
          ),
        ),
        'submitApplication': _i1.MethodConnector(
          name: 'submitApplication',
          params: {
            'offerData': _i1.ParameterDescription(
              name: 'offerData',
              type: _i1.getType<_i27.Offers>(),
              nullable: false,
            ),
            'applicantId': _i1.ParameterDescription(
              name: 'applicantId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'qualifyIndices': _i1.ParameterDescription(
              name: 'qualifyIndices',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).submitApplication(
            session,
            params['offerData'],
            params['applicantId'],
            params['description'],
            params['qualifyIndices'],
          ),
        ),
        'withdrawApplication': _i1.MethodConnector(
          name: 'withdrawApplication',
          params: {
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'applicantId': _i1.ParameterDescription(
              name: 'applicantId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).withdrawApplication(
            session,
            params['offerId'],
            params['applicantId'],
          ),
        ),
        'fetchUserApplications': _i1.MethodConnector(
          name: 'fetchUserApplications',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).fetchUserApplications(
            session,
            params['userId'],
          ),
        ),
        'getOffersData': _i1.MethodConnector(
          name: 'getOffersData',
          params: {
            'offerIds': _i1.ParameterDescription(
              name: 'offerIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).getOffersData(
            session,
            params['offerIds'],
          ),
        ),
        'fetchSearchOffers': _i1.MethodConnector(
          name: 'fetchSearchOffers',
          params: {
            'pattern': _i1.ParameterDescription(
              name: 'pattern',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).fetchSearchOffers(
            session,
            params['pattern'],
          ),
        ),
        'fetchAuthorOffers': _i1.MethodConnector(
          name: 'fetchAuthorOffers',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).fetchAuthorOffers(
            session,
            params['userId'],
          ),
        ),
        'changeApplicationStatus': _i1.MethodConnector(
          name: 'changeApplicationStatus',
          params: {
            'application': _i1.ParameterDescription(
              name: 'application',
              type: _i1.getType<_i28.Applications>(),
              nullable: false,
            ),
            'newStatus': _i1.ParameterDescription(
              name: 'newStatus',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).changeApplicationStatus(
            session,
            params['application'],
            params['newStatus'],
          ),
        ),
        'fetchApplicationsForReview': _i1.MethodConnector(
          name: 'fetchApplicationsForReview',
          params: {
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint)
                  .fetchApplicationsForReview(
            session,
            params['offerId'],
          ),
        ),
        'hasApplied': _i1.MethodConnector(
          name: 'hasApplied',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['work'] as _i13.WorkEndpoint).hasApplied(
            session,
            params['userId'],
            params['offerId'],
          ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _i14.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    modules['serverpod_auth'] = _i29.Endpoints()..initializeEndpoints(server);
  }
}
