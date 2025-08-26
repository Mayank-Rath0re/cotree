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
import 'custom_details.dart' as _i2;

abstract class Organization implements _i1.SerializableModel {
  Organization._({
    this.id,
    required this.accountId,
    required this.founded,
    required this.about,
    required this.events,
    required this.jobOpenings,
    required this.customFields,
  });

  factory Organization({
    int? id,
    required int accountId,
    required DateTime founded,
    required String about,
    required List<int> events,
    required List<int> jobOpenings,
    required List<_i2.CustomDetails> customFields,
  }) = _OrganizationImpl;

  factory Organization.fromJson(Map<String, dynamic> jsonSerialization) {
    return Organization(
      id: jsonSerialization['id'] as int?,
      accountId: jsonSerialization['accountId'] as int,
      founded: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['founded']),
      about: jsonSerialization['about'] as String,
      events:
          (jsonSerialization['events'] as List).map((e) => e as int).toList(),
      jobOpenings: (jsonSerialization['jobOpenings'] as List)
          .map((e) => e as int)
          .toList(),
      customFields: (jsonSerialization['customFields'] as List)
          .map((e) => _i2.CustomDetails.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int accountId;

  DateTime founded;

  String about;

  List<int> events;

  List<int> jobOpenings;

  List<_i2.CustomDetails> customFields;

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Organization copyWith({
    int? id,
    int? accountId,
    DateTime? founded,
    String? about,
    List<int>? events,
    List<int>? jobOpenings,
    List<_i2.CustomDetails>? customFields,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'accountId': accountId,
      'founded': founded.toJson(),
      'about': about,
      'events': events.toJson(),
      'jobOpenings': jobOpenings.toJson(),
      'customFields': customFields.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationImpl extends Organization {
  _OrganizationImpl({
    int? id,
    required int accountId,
    required DateTime founded,
    required String about,
    required List<int> events,
    required List<int> jobOpenings,
    required List<_i2.CustomDetails> customFields,
  }) : super._(
          id: id,
          accountId: accountId,
          founded: founded,
          about: about,
          events: events,
          jobOpenings: jobOpenings,
          customFields: customFields,
        );

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Organization copyWith({
    Object? id = _Undefined,
    int? accountId,
    DateTime? founded,
    String? about,
    List<int>? events,
    List<int>? jobOpenings,
    List<_i2.CustomDetails>? customFields,
  }) {
    return Organization(
      id: id is int? ? id : this.id,
      accountId: accountId ?? this.accountId,
      founded: founded ?? this.founded,
      about: about ?? this.about,
      events: events ?? this.events.map((e0) => e0).toList(),
      jobOpenings: jobOpenings ?? this.jobOpenings.map((e0) => e0).toList(),
      customFields:
          customFields ?? this.customFields.map((e0) => e0.copyWith()).toList(),
    );
  }
}
