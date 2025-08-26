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

abstract class Documents implements _i1.SerializableModel {
  Documents._({
    this.id,
    required this.projectId,
    required this.title,
    required this.url,
    required this.uploadedBy,
    required this.uploadedAt,
  });

  factory Documents({
    int? id,
    required int projectId,
    required String title,
    required String url,
    required int uploadedBy,
    required DateTime uploadedAt,
  }) = _DocumentsImpl;

  factory Documents.fromJson(Map<String, dynamic> jsonSerialization) {
    return Documents(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      title: jsonSerialization['title'] as String,
      url: jsonSerialization['url'] as String,
      uploadedBy: jsonSerialization['uploadedBy'] as int,
      uploadedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  String title;

  String url;

  int uploadedBy;

  DateTime uploadedAt;

  /// Returns a shallow copy of this [Documents]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Documents copyWith({
    int? id,
    int? projectId,
    String? title,
    String? url,
    int? uploadedBy,
    DateTime? uploadedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'projectId': projectId,
      'title': title,
      'url': url,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentsImpl extends Documents {
  _DocumentsImpl({
    int? id,
    required int projectId,
    required String title,
    required String url,
    required int uploadedBy,
    required DateTime uploadedAt,
  }) : super._(
          id: id,
          projectId: projectId,
          title: title,
          url: url,
          uploadedBy: uploadedBy,
          uploadedAt: uploadedAt,
        );

  /// Returns a shallow copy of this [Documents]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Documents copyWith({
    Object? id = _Undefined,
    int? projectId,
    String? title,
    String? url,
    int? uploadedBy,
    DateTime? uploadedAt,
  }) {
    return Documents(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      url: url ?? this.url,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
