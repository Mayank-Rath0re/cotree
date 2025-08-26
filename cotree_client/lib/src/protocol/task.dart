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
import 'task_assigned.dart' as _i2;

abstract class Task implements _i1.SerializableModel {
  Task._({
    this.id,
    required this.projectId,
    required this.taskName,
    required this.status,
    this.deadline,
    this.assigned,
  });

  factory Task({
    int? id,
    required int projectId,
    required String taskName,
    required String status,
    DateTime? deadline,
    List<_i2.TaskAssigned>? assigned,
  }) = _TaskImpl;

  factory Task.fromJson(Map<String, dynamic> jsonSerialization) {
    return Task(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      taskName: jsonSerialization['taskName'] as String,
      status: jsonSerialization['status'] as String,
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      assigned: (jsonSerialization['assigned'] as List?)
          ?.map((e) => _i2.TaskAssigned.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  String taskName;

  String status;

  DateTime? deadline;

  List<_i2.TaskAssigned>? assigned;

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Task copyWith({
    int? id,
    int? projectId,
    String? taskName,
    String? status,
    DateTime? deadline,
    List<_i2.TaskAssigned>? assigned,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'projectId': projectId,
      'taskName': taskName,
      'status': status,
      if (deadline != null) 'deadline': deadline?.toJson(),
      if (assigned != null)
        'assigned': assigned?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskImpl extends Task {
  _TaskImpl({
    int? id,
    required int projectId,
    required String taskName,
    required String status,
    DateTime? deadline,
    List<_i2.TaskAssigned>? assigned,
  }) : super._(
          id: id,
          projectId: projectId,
          taskName: taskName,
          status: status,
          deadline: deadline,
          assigned: assigned,
        );

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Task copyWith({
    Object? id = _Undefined,
    int? projectId,
    String? taskName,
    String? status,
    Object? deadline = _Undefined,
    Object? assigned = _Undefined,
  }) {
    return Task(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      taskName: taskName ?? this.taskName,
      status: status ?? this.status,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      assigned: assigned is List<_i2.TaskAssigned>?
          ? assigned
          : this.assigned?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
