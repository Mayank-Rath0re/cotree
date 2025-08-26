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

abstract class Chat implements _i1.SerializableModel {
  Chat._({
    this.id,
    required this.isGroup,
    this.name,
  });

  factory Chat({
    int? id,
    required bool isGroup,
    String? name,
  }) = _ChatImpl;

  factory Chat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chat(
      id: jsonSerialization['id'] as int?,
      isGroup: jsonSerialization['isGroup'] as bool,
      name: jsonSerialization['name'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  bool isGroup;

  String? name;

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Chat copyWith({
    int? id,
    bool? isGroup,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'isGroup': isGroup,
      if (name != null) 'name': name,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatImpl extends Chat {
  _ChatImpl({
    int? id,
    required bool isGroup,
    String? name,
  }) : super._(
          id: id,
          isGroup: isGroup,
          name: name,
        );

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Chat copyWith({
    Object? id = _Undefined,
    bool? isGroup,
    Object? name = _Undefined,
  }) {
    return Chat(
      id: id is int? ? id : this.id,
      isGroup: isGroup ?? this.isGroup,
      name: name is String? ? name : this.name,
    );
  }
}
