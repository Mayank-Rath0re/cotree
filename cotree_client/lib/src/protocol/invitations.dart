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

abstract class Invitation implements _i1.SerializableModel {
  Invitation._({
    this.id,
    required this.sender,
    required this.receiver,
    bool? isRejected,
    this.personalText,
  }) : isRejected = isRejected ?? false;

  factory Invitation({
    int? id,
    required int sender,
    required int receiver,
    bool? isRejected,
    String? personalText,
  }) = _InvitationImpl;

  factory Invitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invitation(
      id: jsonSerialization['id'] as int?,
      sender: jsonSerialization['sender'] as int,
      receiver: jsonSerialization['receiver'] as int,
      isRejected: jsonSerialization['isRejected'] as bool,
      personalText: jsonSerialization['personalText'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int sender;

  int receiver;

  bool isRejected;

  String? personalText;

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Invitation copyWith({
    int? id,
    int? sender,
    int? receiver,
    bool? isRejected,
    String? personalText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'sender': sender,
      'receiver': receiver,
      'isRejected': isRejected,
      if (personalText != null) 'personalText': personalText,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvitationImpl extends Invitation {
  _InvitationImpl({
    int? id,
    required int sender,
    required int receiver,
    bool? isRejected,
    String? personalText,
  }) : super._(
          id: id,
          sender: sender,
          receiver: receiver,
          isRejected: isRejected,
          personalText: personalText,
        );

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Invitation copyWith({
    Object? id = _Undefined,
    int? sender,
    int? receiver,
    bool? isRejected,
    Object? personalText = _Undefined,
  }) {
    return Invitation(
      id: id is int? ? id : this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      isRejected: isRejected ?? this.isRejected,
      personalText: personalText is String? ? personalText : this.personalText,
    );
  }
}
