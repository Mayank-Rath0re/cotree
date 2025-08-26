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

abstract class Reaction implements _i1.SerializableModel {
  Reaction._({
    this.id,
    required this.userId,
    required this.reactableId,
    required this.reactableType,
    required this.type,
  });

  factory Reaction({
    int? id,
    required int userId,
    required int reactableId,
    required String reactableType,
    required int type,
  }) = _ReactionImpl;

  factory Reaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reaction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      reactableId: jsonSerialization['reactableId'] as int,
      reactableType: jsonSerialization['reactableType'] as String,
      type: jsonSerialization['type'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int reactableId;

  String reactableType;

  int type;

  /// Returns a shallow copy of this [Reaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Reaction copyWith({
    int? id,
    int? userId,
    int? reactableId,
    String? reactableType,
    int? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'reactableId': reactableId,
      'reactableType': reactableType,
      'type': type,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReactionImpl extends Reaction {
  _ReactionImpl({
    int? id,
    required int userId,
    required int reactableId,
    required String reactableType,
    required int type,
  }) : super._(
          id: id,
          userId: userId,
          reactableId: reactableId,
          reactableType: reactableType,
          type: type,
        );

  /// Returns a shallow copy of this [Reaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Reaction copyWith({
    Object? id = _Undefined,
    int? userId,
    int? reactableId,
    String? reactableType,
    int? type,
  }) {
    return Reaction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      reactableId: reactableId ?? this.reactableId,
      reactableType: reactableType ?? this.reactableType,
      type: type ?? this.type,
    );
  }
}
