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
import 'reply.dart' as _i2;

abstract class Comment implements _i1.SerializableModel {
  Comment._({
    this.id,
    required this.responseToPost,
    required this.author,
    required this.text,
    required this.time,
    this.replies,
  });

  factory Comment({
    int? id,
    required int responseToPost,
    required int author,
    required String text,
    required DateTime time,
    List<_i2.Reply>? replies,
  }) = _CommentImpl;

  factory Comment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Comment(
      id: jsonSerialization['id'] as int?,
      responseToPost: jsonSerialization['responseToPost'] as int,
      author: jsonSerialization['author'] as int,
      text: jsonSerialization['text'] as String,
      time: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['time']),
      replies: (jsonSerialization['replies'] as List?)
          ?.map((e) => _i2.Reply.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int responseToPost;

  int author;

  String text;

  DateTime time;

  List<_i2.Reply>? replies;

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Comment copyWith({
    int? id,
    int? responseToPost,
    int? author,
    String? text,
    DateTime? time,
    List<_i2.Reply>? replies,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'responseToPost': responseToPost,
      'author': author,
      'text': text,
      'time': time.toJson(),
      if (replies != null)
        'replies': replies?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentImpl extends Comment {
  _CommentImpl({
    int? id,
    required int responseToPost,
    required int author,
    required String text,
    required DateTime time,
    List<_i2.Reply>? replies,
  }) : super._(
          id: id,
          responseToPost: responseToPost,
          author: author,
          text: text,
          time: time,
          replies: replies,
        );

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Comment copyWith({
    Object? id = _Undefined,
    int? responseToPost,
    int? author,
    String? text,
    DateTime? time,
    Object? replies = _Undefined,
  }) {
    return Comment(
      id: id is int? ? id : this.id,
      responseToPost: responseToPost ?? this.responseToPost,
      author: author ?? this.author,
      text: text ?? this.text,
      time: time ?? this.time,
      replies: replies is List<_i2.Reply>?
          ? replies
          : this.replies?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
