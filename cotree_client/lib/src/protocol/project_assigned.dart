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

abstract class ProjectAssigned implements _i1.SerializableModel {
  ProjectAssigned._({
    this.id,
    required this.projectId,
    required this.teamId,
  });

  factory ProjectAssigned({
    int? id,
    required int projectId,
    required int teamId,
  }) = _ProjectAssignedImpl;

  factory ProjectAssigned.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectAssigned(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      teamId: jsonSerialization['teamId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  int teamId;

  /// Returns a shallow copy of this [ProjectAssigned]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProjectAssigned copyWith({
    int? id,
    int? projectId,
    int? teamId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'projectId': projectId,
      'teamId': teamId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectAssignedImpl extends ProjectAssigned {
  _ProjectAssignedImpl({
    int? id,
    required int projectId,
    required int teamId,
  }) : super._(
          id: id,
          projectId: projectId,
          teamId: teamId,
        );

  /// Returns a shallow copy of this [ProjectAssigned]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProjectAssigned copyWith({
    Object? id = _Undefined,
    int? projectId,
    int? teamId,
  }) {
    return ProjectAssigned(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      teamId: teamId ?? this.teamId,
    );
  }
}
