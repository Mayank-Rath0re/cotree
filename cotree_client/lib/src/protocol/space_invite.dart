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

abstract class SpaceInvite implements _i1.SerializableModel {
  SpaceInvite._({
    this.id,
    required this.spaceId,
    required this.userId,
    required this.designation,
    required this.globalRole,
    required this.teams,
    required this.sentOn,
    required this.sentBy,
    required this.status,
    required this.unread,
  });

  factory SpaceInvite({
    int? id,
    required int spaceId,
    required int userId,
    required String designation,
    required String globalRole,
    required List<List<String>> teams,
    required DateTime sentOn,
    required int sentBy,
    required String status,
    required bool unread,
  }) = _SpaceInviteImpl;

  factory SpaceInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpaceInvite(
      id: jsonSerialization['id'] as int?,
      spaceId: jsonSerialization['spaceId'] as int,
      userId: jsonSerialization['userId'] as int,
      designation: jsonSerialization['designation'] as String,
      globalRole: jsonSerialization['globalRole'] as String,
      teams: (jsonSerialization['teams'] as List)
          .map((e) => (e as List).map((e) => e as String).toList())
          .toList(),
      sentOn: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentOn']),
      sentBy: jsonSerialization['sentBy'] as int,
      status: jsonSerialization['status'] as String,
      unread: jsonSerialization['unread'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int spaceId;

  int userId;

  String designation;

  String globalRole;

  List<List<String>> teams;

  DateTime sentOn;

  int sentBy;

  String status;

  bool unread;

  /// Returns a shallow copy of this [SpaceInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpaceInvite copyWith({
    int? id,
    int? spaceId,
    int? userId,
    String? designation,
    String? globalRole,
    List<List<String>>? teams,
    DateTime? sentOn,
    int? sentBy,
    String? status,
    bool? unread,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'spaceId': spaceId,
      'userId': userId,
      'designation': designation,
      'globalRole': globalRole,
      'teams': teams.toJson(valueToJson: (v) => v.toJson()),
      'sentOn': sentOn.toJson(),
      'sentBy': sentBy,
      'status': status,
      'unread': unread,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpaceInviteImpl extends SpaceInvite {
  _SpaceInviteImpl({
    int? id,
    required int spaceId,
    required int userId,
    required String designation,
    required String globalRole,
    required List<List<String>> teams,
    required DateTime sentOn,
    required int sentBy,
    required String status,
    required bool unread,
  }) : super._(
          id: id,
          spaceId: spaceId,
          userId: userId,
          designation: designation,
          globalRole: globalRole,
          teams: teams,
          sentOn: sentOn,
          sentBy: sentBy,
          status: status,
          unread: unread,
        );

  /// Returns a shallow copy of this [SpaceInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpaceInvite copyWith({
    Object? id = _Undefined,
    int? spaceId,
    int? userId,
    String? designation,
    String? globalRole,
    List<List<String>>? teams,
    DateTime? sentOn,
    int? sentBy,
    String? status,
    bool? unread,
  }) {
    return SpaceInvite(
      id: id is int? ? id : this.id,
      spaceId: spaceId ?? this.spaceId,
      userId: userId ?? this.userId,
      designation: designation ?? this.designation,
      globalRole: globalRole ?? this.globalRole,
      teams:
          teams ?? this.teams.map((e0) => e0.map((e1) => e1).toList()).toList(),
      sentOn: sentOn ?? this.sentOn,
      sentBy: sentBy ?? this.sentBy,
      status: status ?? this.status,
      unread: unread ?? this.unread,
    );
  }
}
