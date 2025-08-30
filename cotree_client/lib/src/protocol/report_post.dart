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

abstract class ReportPost implements _i1.SerializableModel {
  ReportPost._({
    this.id,
    required this.reporterId,
    required this.postId,
    required this.reason,
  });

  factory ReportPost({
    int? id,
    required int reporterId,
    required int postId,
    required String reason,
  }) = _ReportPostImpl;

  factory ReportPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportPost(
      id: jsonSerialization['id'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      postId: jsonSerialization['postId'] as int,
      reason: jsonSerialization['reason'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int reporterId;

  int postId;

  String reason;

  /// Returns a shallow copy of this [ReportPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportPost copyWith({
    int? id,
    int? reporterId,
    int? postId,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'postId': postId,
      'reason': reason,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportPostImpl extends ReportPost {
  _ReportPostImpl({
    int? id,
    required int reporterId,
    required int postId,
    required String reason,
  }) : super._(
          id: id,
          reporterId: reporterId,
          postId: postId,
          reason: reason,
        );

  /// Returns a shallow copy of this [ReportPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportPost copyWith({
    Object? id = _Undefined,
    int? reporterId,
    int? postId,
    String? reason,
  }) {
    return ReportPost(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      postId: postId ?? this.postId,
      reason: reason ?? this.reason,
    );
  }
}
