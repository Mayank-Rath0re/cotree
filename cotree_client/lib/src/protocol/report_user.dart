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

abstract class ReportUser implements _i1.SerializableModel {
  ReportUser._({
    this.id,
    required this.reporterId,
    required this.reportedId,
    required this.reason,
  });

  factory ReportUser({
    int? id,
    required int reporterId,
    required int reportedId,
    required String reason,
  }) = _ReportUserImpl;

  factory ReportUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportUser(
      id: jsonSerialization['id'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      reportedId: jsonSerialization['reportedId'] as int,
      reason: jsonSerialization['reason'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int reporterId;

  int reportedId;

  String reason;

  /// Returns a shallow copy of this [ReportUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportUser copyWith({
    int? id,
    int? reporterId,
    int? reportedId,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'reportedId': reportedId,
      'reason': reason,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportUserImpl extends ReportUser {
  _ReportUserImpl({
    int? id,
    required int reporterId,
    required int reportedId,
    required String reason,
  }) : super._(
          id: id,
          reporterId: reporterId,
          reportedId: reportedId,
          reason: reason,
        );

  /// Returns a shallow copy of this [ReportUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportUser copyWith({
    Object? id = _Undefined,
    int? reporterId,
    int? reportedId,
    String? reason,
  }) {
    return ReportUser(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      reportedId: reportedId ?? this.reportedId,
      reason: reason ?? this.reason,
    );
  }
}
