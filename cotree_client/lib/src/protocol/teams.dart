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

abstract class Teams implements _i1.SerializableModel {
  Teams._({
    this.id,
    required this.spaceId,
    required this.teamTitle,
    required this.chatId,
  });

  factory Teams({
    int? id,
    required int spaceId,
    required String teamTitle,
    required int chatId,
  }) = _TeamsImpl;

  factory Teams.fromJson(Map<String, dynamic> jsonSerialization) {
    return Teams(
      id: jsonSerialization['id'] as int?,
      spaceId: jsonSerialization['spaceId'] as int,
      teamTitle: jsonSerialization['teamTitle'] as String,
      chatId: jsonSerialization['chatId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int spaceId;

  String teamTitle;

  int chatId;

  /// Returns a shallow copy of this [Teams]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Teams copyWith({
    int? id,
    int? spaceId,
    String? teamTitle,
    int? chatId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'spaceId': spaceId,
      'teamTitle': teamTitle,
      'chatId': chatId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TeamsImpl extends Teams {
  _TeamsImpl({
    int? id,
    required int spaceId,
    required String teamTitle,
    required int chatId,
  }) : super._(
          id: id,
          spaceId: spaceId,
          teamTitle: teamTitle,
          chatId: chatId,
        );

  /// Returns a shallow copy of this [Teams]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Teams copyWith({
    Object? id = _Undefined,
    int? spaceId,
    String? teamTitle,
    int? chatId,
  }) {
    return Teams(
      id: id is int? ? id : this.id,
      spaceId: spaceId ?? this.spaceId,
      teamTitle: teamTitle ?? this.teamTitle,
      chatId: chatId ?? this.chatId,
    );
  }
}
