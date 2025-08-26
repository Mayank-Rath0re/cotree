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

abstract class TaskAssigned implements _i1.SerializableModel {
  TaskAssigned._({
    this.id,
    required this.taskId,
    required this.memberId,
  });

  factory TaskAssigned({
    int? id,
    required int taskId,
    required int memberId,
  }) = _TaskAssignedImpl;

  factory TaskAssigned.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaskAssigned(
      id: jsonSerialization['id'] as int?,
      taskId: jsonSerialization['taskId'] as int,
      memberId: jsonSerialization['memberId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int taskId;

  int memberId;

  /// Returns a shallow copy of this [TaskAssigned]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TaskAssigned copyWith({
    int? id,
    int? taskId,
    int? memberId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'taskId': taskId,
      'memberId': memberId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskAssignedImpl extends TaskAssigned {
  _TaskAssignedImpl({
    int? id,
    required int taskId,
    required int memberId,
  }) : super._(
          id: id,
          taskId: taskId,
          memberId: memberId,
        );

  /// Returns a shallow copy of this [TaskAssigned]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TaskAssigned copyWith({
    Object? id = _Undefined,
    int? taskId,
    int? memberId,
  }) {
    return TaskAssigned(
      id: id is int? ? id : this.id,
      taskId: taskId ?? this.taskId,
      memberId: memberId ?? this.memberId,
    );
  }
}
