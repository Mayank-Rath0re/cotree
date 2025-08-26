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

abstract class CustomDetails implements _i1.SerializableModel {
  CustomDetails._({
    this.id,
    required this.title,
    required this.description,
    required this.images,
  });

  factory CustomDetails({
    int? id,
    required String title,
    required String description,
    required List<String> images,
  }) = _CustomDetailsImpl;

  factory CustomDetails.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomDetails(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      images: (jsonSerialization['images'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String description;

  List<String> images;

  /// Returns a shallow copy of this [CustomDetails]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CustomDetails copyWith({
    int? id,
    String? title,
    String? description,
    List<String>? images,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'images': images.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomDetailsImpl extends CustomDetails {
  _CustomDetailsImpl({
    int? id,
    required String title,
    required String description,
    required List<String> images,
  }) : super._(
          id: id,
          title: title,
          description: description,
          images: images,
        );

  /// Returns a shallow copy of this [CustomDetails]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CustomDetails copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    List<String>? images,
  }) {
    return CustomDetails(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images.map((e0) => e0).toList(),
    );
  }
}
