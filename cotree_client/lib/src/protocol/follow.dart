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

abstract class Follow implements _i1.SerializableModel {
  Follow._({
    this.id,
    required this.orgId,
    required this.followedBy,
  });

  factory Follow({
    int? id,
    required int orgId,
    required int followedBy,
  }) = _FollowImpl;

  factory Follow.fromJson(Map<String, dynamic> jsonSerialization) {
    return Follow(
      id: jsonSerialization['id'] as int?,
      orgId: jsonSerialization['orgId'] as int,
      followedBy: jsonSerialization['followedBy'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orgId;

  int followedBy;

  /// Returns a shallow copy of this [Follow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Follow copyWith({
    int? id,
    int? orgId,
    int? followedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'orgId': orgId,
      'followedBy': followedBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FollowImpl extends Follow {
  _FollowImpl({
    int? id,
    required int orgId,
    required int followedBy,
  }) : super._(
          id: id,
          orgId: orgId,
          followedBy: followedBy,
        );

  /// Returns a shallow copy of this [Follow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Follow copyWith({
    Object? id = _Undefined,
    int? orgId,
    int? followedBy,
  }) {
    return Follow(
      id: id is int? ? id : this.id,
      orgId: orgId ?? this.orgId,
      followedBy: followedBy ?? this.followedBy,
    );
  }
}
