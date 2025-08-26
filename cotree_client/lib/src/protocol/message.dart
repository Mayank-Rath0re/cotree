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

abstract class Message implements _i1.SerializableModel {
  Message._({
    this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.sentAt,
  });

  factory Message({
    int? id,
    required int chatId,
    required int senderId,
    required String content,
    required DateTime sentAt,
  }) = _MessageImpl;

  factory Message.fromJson(Map<String, dynamic> jsonSerialization) {
    return Message(
      id: jsonSerialization['id'] as int?,
      chatId: jsonSerialization['chatId'] as int,
      senderId: jsonSerialization['senderId'] as int,
      content: jsonSerialization['content'] as String,
      sentAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int chatId;

  int senderId;

  String content;

  DateTime sentAt;

  /// Returns a shallow copy of this [Message]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Message copyWith({
    int? id,
    int? chatId,
    int? senderId,
    String? content,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'sentAt': sentAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessageImpl extends Message {
  _MessageImpl({
    int? id,
    required int chatId,
    required int senderId,
    required String content,
    required DateTime sentAt,
  }) : super._(
          id: id,
          chatId: chatId,
          senderId: senderId,
          content: content,
          sentAt: sentAt,
        );

  /// Returns a shallow copy of this [Message]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Message copyWith({
    Object? id = _Undefined,
    int? chatId,
    int? senderId,
    String? content,
    DateTime? sentAt,
  }) {
    return Message(
      id: id is int? ? id : this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
