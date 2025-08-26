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

abstract class Member implements _i1.SerializableModel {
  Member._({
    this.id,
    required this.userId,
    required this.workspaceId,
    required this.name,
    required this.designation,
    required this.globalRole,
    required this.avatar,
    required this.joinedAt,
  });

  factory Member({
    int? id,
    required int userId,
    required int workspaceId,
    required String name,
    required String designation,
    required String globalRole,
    required String avatar,
    required DateTime joinedAt,
  }) = _MemberImpl;

  factory Member.fromJson(Map<String, dynamic> jsonSerialization) {
    return Member(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      workspaceId: jsonSerialization['workspaceId'] as int,
      name: jsonSerialization['name'] as String,
      designation: jsonSerialization['designation'] as String,
      globalRole: jsonSerialization['globalRole'] as String,
      avatar: jsonSerialization['avatar'] as String,
      joinedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int workspaceId;

  String name;

  String designation;

  String globalRole;

  String avatar;

  DateTime joinedAt;

  /// Returns a shallow copy of this [Member]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Member copyWith({
    int? id,
    int? userId,
    int? workspaceId,
    String? name,
    String? designation,
    String? globalRole,
    String? avatar,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'workspaceId': workspaceId,
      'name': name,
      'designation': designation,
      'globalRole': globalRole,
      'avatar': avatar,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberImpl extends Member {
  _MemberImpl({
    int? id,
    required int userId,
    required int workspaceId,
    required String name,
    required String designation,
    required String globalRole,
    required String avatar,
    required DateTime joinedAt,
  }) : super._(
          id: id,
          userId: userId,
          workspaceId: workspaceId,
          name: name,
          designation: designation,
          globalRole: globalRole,
          avatar: avatar,
          joinedAt: joinedAt,
        );

  /// Returns a shallow copy of this [Member]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Member copyWith({
    Object? id = _Undefined,
    int? userId,
    int? workspaceId,
    String? name,
    String? designation,
    String? globalRole,
    String? avatar,
    DateTime? joinedAt,
  }) {
    return Member(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      globalRole: globalRole ?? this.globalRole,
      avatar: avatar ?? this.avatar,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
