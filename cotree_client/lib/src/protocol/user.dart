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

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    this.userInfoId,
    required this.name,
    required this.accountType,
    required this.password,
    required this.email,
    required this.spaceLimit,
  });

  factory User({
    int? id,
    int? userInfoId,
    required String name,
    required String accountType,
    required String password,
    required String email,
    required int spaceLimit,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int?,
      name: jsonSerialization['name'] as String,
      accountType: jsonSerialization['accountType'] as String,
      password: jsonSerialization['password'] as String,
      email: jsonSerialization['email'] as String,
      spaceLimit: jsonSerialization['spaceLimit'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? userInfoId;

  String name;

  String accountType;

  String password;

  String email;

  int spaceLimit;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    int? userInfoId,
    String? name,
    String? accountType,
    String? password,
    String? email,
    int? spaceLimit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (userInfoId != null) 'userInfoId': userInfoId,
      'name': name,
      'accountType': accountType,
      'password': password,
      'email': email,
      'spaceLimit': spaceLimit,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    int? userInfoId,
    required String name,
    required String accountType,
    required String password,
    required String email,
    required int spaceLimit,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          name: name,
          accountType: accountType,
          password: password,
          email: email,
          spaceLimit: spaceLimit,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    Object? userInfoId = _Undefined,
    String? name,
    String? accountType,
    String? password,
    String? email,
    int? spaceLimit,
  }) {
    return User(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId is int? ? userInfoId : this.userInfoId,
      name: name ?? this.name,
      accountType: accountType ?? this.accountType,
      password: password ?? this.password,
      email: email ?? this.email,
      spaceLimit: spaceLimit ?? this.spaceLimit,
    );
  }
}
