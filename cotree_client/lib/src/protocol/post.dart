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

abstract class Post implements _i1.SerializableModel {
  Post._({
    this.id,
    required this.authorId,
    required this.text,
    this.media,
    required this.createdAt,
  });

  factory Post({
    int? id,
    required int authorId,
    required String text,
    List<String>? media,
    required DateTime createdAt,
  }) = _PostImpl;

  factory Post.fromJson(Map<String, dynamic> jsonSerialization) {
    return Post(
      id: jsonSerialization['id'] as int?,
      authorId: jsonSerialization['authorId'] as int,
      text: jsonSerialization['text'] as String,
      media: (jsonSerialization['media'] as List?)
          ?.map((e) => e as String)
          .toList(),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int authorId;

  String text;

  List<String>? media;

  DateTime createdAt;

  /// Returns a shallow copy of this [Post]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Post copyWith({
    int? id,
    int? authorId,
    String? text,
    List<String>? media,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'authorId': authorId,
      'text': text,
      if (media != null) 'media': media?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostImpl extends Post {
  _PostImpl({
    int? id,
    required int authorId,
    required String text,
    List<String>? media,
    required DateTime createdAt,
  }) : super._(
          id: id,
          authorId: authorId,
          text: text,
          media: media,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Post]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Post copyWith({
    Object? id = _Undefined,
    int? authorId,
    String? text,
    Object? media = _Undefined,
    DateTime? createdAt,
  }) {
    return Post(
      id: id is int? ? id : this.id,
      authorId: authorId ?? this.authorId,
      text: text ?? this.text,
      media:
          media is List<String>? ? media : this.media?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
