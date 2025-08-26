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

abstract class Notification implements _i1.SerializableModel {
  Notification._({
    this.id,
    required this.forUser,
    required this.content,
    required this.referencedUser,
    required this.triggeredAt,
    required this.unread,
    this.objectId,
    this.objectType,
  });

  factory Notification({
    int? id,
    required int forUser,
    required String content,
    required int referencedUser,
    required DateTime triggeredAt,
    required bool unread,
    int? objectId,
    String? objectType,
  }) = _NotificationImpl;

  factory Notification.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notification(
      id: jsonSerialization['id'] as int?,
      forUser: jsonSerialization['forUser'] as int,
      content: jsonSerialization['content'] as String,
      referencedUser: jsonSerialization['referencedUser'] as int,
      triggeredAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['triggeredAt']),
      unread: jsonSerialization['unread'] as bool,
      objectId: jsonSerialization['objectId'] as int?,
      objectType: jsonSerialization['objectType'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int forUser;

  String content;

  int referencedUser;

  DateTime triggeredAt;

  bool unread;

  int? objectId;

  String? objectType;

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Notification copyWith({
    int? id,
    int? forUser,
    String? content,
    int? referencedUser,
    DateTime? triggeredAt,
    bool? unread,
    int? objectId,
    String? objectType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'forUser': forUser,
      'content': content,
      'referencedUser': referencedUser,
      'triggeredAt': triggeredAt.toJson(),
      'unread': unread,
      if (objectId != null) 'objectId': objectId,
      if (objectType != null) 'objectType': objectType,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationImpl extends Notification {
  _NotificationImpl({
    int? id,
    required int forUser,
    required String content,
    required int referencedUser,
    required DateTime triggeredAt,
    required bool unread,
    int? objectId,
    String? objectType,
  }) : super._(
          id: id,
          forUser: forUser,
          content: content,
          referencedUser: referencedUser,
          triggeredAt: triggeredAt,
          unread: unread,
          objectId: objectId,
          objectType: objectType,
        );

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Notification copyWith({
    Object? id = _Undefined,
    int? forUser,
    String? content,
    int? referencedUser,
    DateTime? triggeredAt,
    bool? unread,
    Object? objectId = _Undefined,
    Object? objectType = _Undefined,
  }) {
    return Notification(
      id: id is int? ? id : this.id,
      forUser: forUser ?? this.forUser,
      content: content ?? this.content,
      referencedUser: referencedUser ?? this.referencedUser,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      unread: unread ?? this.unread,
      objectId: objectId is int? ? objectId : this.objectId,
      objectType: objectType is String? ? objectType : this.objectType,
    );
  }
}
