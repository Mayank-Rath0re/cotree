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

abstract class Individual implements _i1.SerializableModel {
  Individual._({
    this.id,
    required this.bio,
    required this.accountId,
    required this.gender,
    this.residence,
    this.dob,
    required this.contact,
  });

  factory Individual({
    int? id,
    required String bio,
    required int accountId,
    required String gender,
    String? residence,
    DateTime? dob,
    required String contact,
  }) = _IndividualImpl;

  factory Individual.fromJson(Map<String, dynamic> jsonSerialization) {
    return Individual(
      id: jsonSerialization['id'] as int?,
      bio: jsonSerialization['bio'] as String,
      accountId: jsonSerialization['accountId'] as int,
      gender: jsonSerialization['gender'] as String,
      residence: jsonSerialization['residence'] as String?,
      dob: jsonSerialization['dob'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dob']),
      contact: jsonSerialization['contact'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String bio;

  int accountId;

  String gender;

  String? residence;

  DateTime? dob;

  String contact;

  /// Returns a shallow copy of this [Individual]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Individual copyWith({
    int? id,
    String? bio,
    int? accountId,
    String? gender,
    String? residence,
    DateTime? dob,
    String? contact,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bio': bio,
      'accountId': accountId,
      'gender': gender,
      if (residence != null) 'residence': residence,
      if (dob != null) 'dob': dob?.toJson(),
      'contact': contact,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IndividualImpl extends Individual {
  _IndividualImpl({
    int? id,
    required String bio,
    required int accountId,
    required String gender,
    String? residence,
    DateTime? dob,
    required String contact,
  }) : super._(
          id: id,
          bio: bio,
          accountId: accountId,
          gender: gender,
          residence: residence,
          dob: dob,
          contact: contact,
        );

  /// Returns a shallow copy of this [Individual]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Individual copyWith({
    Object? id = _Undefined,
    String? bio,
    int? accountId,
    String? gender,
    Object? residence = _Undefined,
    Object? dob = _Undefined,
    String? contact,
  }) {
    return Individual(
      id: id is int? ? id : this.id,
      bio: bio ?? this.bio,
      accountId: accountId ?? this.accountId,
      gender: gender ?? this.gender,
      residence: residence is String? ? residence : this.residence,
      dob: dob is DateTime? ? dob : this.dob,
      contact: contact ?? this.contact,
    );
  }
}
