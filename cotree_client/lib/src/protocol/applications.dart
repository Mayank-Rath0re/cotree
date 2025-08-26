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

abstract class Applications implements _i1.SerializableModel {
  Applications._({
    this.id,
    required this.individualId,
    required this.offerId,
    required this.shortDescription,
    required this.qualifyIndices,
    required this.status,
  });

  factory Applications({
    int? id,
    required int individualId,
    required int offerId,
    required String shortDescription,
    required List<int> qualifyIndices,
    required String status,
  }) = _ApplicationsImpl;

  factory Applications.fromJson(Map<String, dynamic> jsonSerialization) {
    return Applications(
      id: jsonSerialization['id'] as int?,
      individualId: jsonSerialization['individualId'] as int,
      offerId: jsonSerialization['offerId'] as int,
      shortDescription: jsonSerialization['shortDescription'] as String,
      qualifyIndices: (jsonSerialization['qualifyIndices'] as List)
          .map((e) => e as int)
          .toList(),
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int individualId;

  int offerId;

  String shortDescription;

  List<int> qualifyIndices;

  String status;

  /// Returns a shallow copy of this [Applications]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Applications copyWith({
    int? id,
    int? individualId,
    int? offerId,
    String? shortDescription,
    List<int>? qualifyIndices,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'individualId': individualId,
      'offerId': offerId,
      'shortDescription': shortDescription,
      'qualifyIndices': qualifyIndices.toJson(),
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ApplicationsImpl extends Applications {
  _ApplicationsImpl({
    int? id,
    required int individualId,
    required int offerId,
    required String shortDescription,
    required List<int> qualifyIndices,
    required String status,
  }) : super._(
          id: id,
          individualId: individualId,
          offerId: offerId,
          shortDescription: shortDescription,
          qualifyIndices: qualifyIndices,
          status: status,
        );

  /// Returns a shallow copy of this [Applications]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Applications copyWith({
    Object? id = _Undefined,
    int? individualId,
    int? offerId,
    String? shortDescription,
    List<int>? qualifyIndices,
    String? status,
  }) {
    return Applications(
      id: id is int? ? id : this.id,
      individualId: individualId ?? this.individualId,
      offerId: offerId ?? this.offerId,
      shortDescription: shortDescription ?? this.shortDescription,
      qualifyIndices:
          qualifyIndices ?? this.qualifyIndices.map((e0) => e0).toList(),
      status: status ?? this.status,
    );
  }
}
