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

abstract class ProfessionalData implements _i1.SerializableModel {
  ProfessionalData._({
    this.id,
    required this.accountId,
    required this.type,
    required this.title,
    required this.institute,
    required this.startDate,
    this.endData,
    required this.supportingLink,
    required this.images,
  });

  factory ProfessionalData({
    int? id,
    required int accountId,
    required String type,
    required String title,
    required String institute,
    required DateTime startDate,
    DateTime? endData,
    required String supportingLink,
    required List<String> images,
  }) = _ProfessionalDataImpl;

  factory ProfessionalData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfessionalData(
      id: jsonSerialization['id'] as int?,
      accountId: jsonSerialization['accountId'] as int,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String,
      institute: jsonSerialization['institute'] as String,
      startDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endData: jsonSerialization['endData'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endData']),
      supportingLink: jsonSerialization['supportingLink'] as String,
      images: (jsonSerialization['images'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int accountId;

  String type;

  String title;

  String institute;

  DateTime startDate;

  DateTime? endData;

  String supportingLink;

  List<String> images;

  /// Returns a shallow copy of this [ProfessionalData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProfessionalData copyWith({
    int? id,
    int? accountId,
    String? type,
    String? title,
    String? institute,
    DateTime? startDate,
    DateTime? endData,
    String? supportingLink,
    List<String>? images,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'accountId': accountId,
      'type': type,
      'title': title,
      'institute': institute,
      'startDate': startDate.toJson(),
      if (endData != null) 'endData': endData?.toJson(),
      'supportingLink': supportingLink,
      'images': images.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfessionalDataImpl extends ProfessionalData {
  _ProfessionalDataImpl({
    int? id,
    required int accountId,
    required String type,
    required String title,
    required String institute,
    required DateTime startDate,
    DateTime? endData,
    required String supportingLink,
    required List<String> images,
  }) : super._(
          id: id,
          accountId: accountId,
          type: type,
          title: title,
          institute: institute,
          startDate: startDate,
          endData: endData,
          supportingLink: supportingLink,
          images: images,
        );

  /// Returns a shallow copy of this [ProfessionalData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProfessionalData copyWith({
    Object? id = _Undefined,
    int? accountId,
    String? type,
    String? title,
    String? institute,
    DateTime? startDate,
    Object? endData = _Undefined,
    String? supportingLink,
    List<String>? images,
  }) {
    return ProfessionalData(
      id: id is int? ? id : this.id,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      title: title ?? this.title,
      institute: institute ?? this.institute,
      startDate: startDate ?? this.startDate,
      endData: endData is DateTime? ? endData : this.endData,
      supportingLink: supportingLink ?? this.supportingLink,
      images: images ?? this.images.map((e0) => e0).toList(),
    );
  }
}
