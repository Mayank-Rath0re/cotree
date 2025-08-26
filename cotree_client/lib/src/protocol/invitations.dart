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
    required this.user,
    this.personalText,
    required this.type,
  });

  factory Invitation({
    int? id,
    required int user,
    String? personalText,
    required String type,
  }) = _InvitationImpl;

  factory Invitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invitation(
      id: jsonSerialization['id'] as int?,
      user: jsonSerialization['user'] as int,
      personalText: jsonSerialization['personalText'] as String?,
      type: jsonSerialization['type'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int user;

  String? personalText;

  String type;

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Invitation copyWith({
    int? id,
    int? user,
    String? personalText,
    String? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user': user,
      if (personalText != null) 'personalText': personalText,
      'type': type,
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
    required int user,
    String? personalText,
    required String type,
  }) : super._(
          id: id,
          user: user,
          personalText: personalText,
          type: type,
        );

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Invitation copyWith({
    Object? id = _Undefined,
    int? user,
    Object? personalText = _Undefined,
    String? type,
  }) {
    return Invitation(
      id: id is int? ? id : this.id,
      user: user ?? this.user,
      personalText: personalText is String? ? personalText : this.personalText,
      type: type ?? this.type,
    );
  }
}
