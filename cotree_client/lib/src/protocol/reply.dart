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

abstract class Reply implements _i1.SerializableModel {
  Reply._({
    this.id,
    required this.author,
    required this.text,
    required this.react,
  });

  factory Reply({
    int? id,
    required int author,
    required String text,
    required int react,
  }) = _ReplyImpl;

  factory Reply.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reply(
      id: jsonSerialization['id'] as int?,
      author: jsonSerialization['author'] as int,
      text: jsonSerialization['text'] as String,
      react: jsonSerialization['react'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int author;

  String text;

  int react;

  /// Returns a shallow copy of this [Reply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Reply copyWith({
    int? id,
    int? author,
    String? text,
    int? react,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'author': author,
      'text': text,
      'react': react,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReplyImpl extends Reply {
  _ReplyImpl({
    int? id,
    required int author,
    required String text,
    required int react,
  }) : super._(
          id: id,
          author: author,
          text: text,
          react: react,
        );

  /// Returns a shallow copy of this [Reply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Reply copyWith({
    Object? id = _Undefined,
    int? author,
    String? text,
    int? react,
  }) {
    return Reply(
      id: id is int? ? id : this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      react: react ?? this.react,
    );
  }
}
