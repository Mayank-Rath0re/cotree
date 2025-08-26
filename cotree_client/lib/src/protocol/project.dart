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

abstract class Project implements _i1.SerializableModel {
  Project._({
    this.id,
    required this.spaceId,
    required this.projectTitle,
    required this.projectOverview,
    required this.status,
  });

  factory Project({
    int? id,
    required int spaceId,
    required String projectTitle,
    required String projectOverview,
    required String status,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as int?,
      spaceId: jsonSerialization['spaceId'] as int,
      projectTitle: jsonSerialization['projectTitle'] as String,
      projectOverview: jsonSerialization['projectOverview'] as String,
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int spaceId;

  String projectTitle;

  String projectOverview;

  String status;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Project copyWith({
    int? id,
    int? spaceId,
    String? projectTitle,
    String? projectOverview,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'spaceId': spaceId,
      'projectTitle': projectTitle,
      'projectOverview': projectOverview,
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectImpl extends Project {
  _ProjectImpl({
    int? id,
    required int spaceId,
    required String projectTitle,
    required String projectOverview,
    required String status,
  }) : super._(
          id: id,
          spaceId: spaceId,
          projectTitle: projectTitle,
          projectOverview: projectOverview,
          status: status,
        );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Project copyWith({
    Object? id = _Undefined,
    int? spaceId,
    String? projectTitle,
    String? projectOverview,
    String? status,
  }) {
    return Project(
      id: id is int? ? id : this.id,
      spaceId: spaceId ?? this.spaceId,
      projectTitle: projectTitle ?? this.projectTitle,
      projectOverview: projectOverview ?? this.projectOverview,
      status: status ?? this.status,
    );
  }
}
