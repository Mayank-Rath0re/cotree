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

abstract class Offers implements _i1.SerializableModel {
  Offers._({
    this.id,
    required this.author,
    required this.authorName,
    required this.title,
    required this.acceptingApplications,
    required this.isActive,
    required this.pay,
    required this.offerType,
    required this.location,
    required this.description,
    required this.duration,
    required this.qualifications,
  });

  factory Offers({
    int? id,
    required int author,
    required String authorName,
    required String title,
    required bool acceptingApplications,
    required bool isActive,
    required String pay,
    required String offerType,
    required String location,
    required String description,
    required int duration,
    required List<String> qualifications,
  }) = _OffersImpl;

  factory Offers.fromJson(Map<String, dynamic> jsonSerialization) {
    return Offers(
      id: jsonSerialization['id'] as int?,
      author: jsonSerialization['author'] as int,
      authorName: jsonSerialization['authorName'] as String,
      title: jsonSerialization['title'] as String,
      acceptingApplications: jsonSerialization['acceptingApplications'] as bool,
      isActive: jsonSerialization['isActive'] as bool,
      pay: jsonSerialization['pay'] as String,
      offerType: jsonSerialization['offerType'] as String,
      location: jsonSerialization['location'] as String,
      description: jsonSerialization['description'] as String,
      duration: jsonSerialization['duration'] as int,
      qualifications: (jsonSerialization['qualifications'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int author;

  String authorName;

  String title;

  bool acceptingApplications;

  bool isActive;

  String pay;

  String offerType;

  String location;

  String description;

  int duration;

  List<String> qualifications;

  /// Returns a shallow copy of this [Offers]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Offers copyWith({
    int? id,
    int? author,
    String? authorName,
    String? title,
    bool? acceptingApplications,
    bool? isActive,
    String? pay,
    String? offerType,
    String? location,
    String? description,
    int? duration,
    List<String>? qualifications,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'author': author,
      'authorName': authorName,
      'title': title,
      'acceptingApplications': acceptingApplications,
      'isActive': isActive,
      'pay': pay,
      'offerType': offerType,
      'location': location,
      'description': description,
      'duration': duration,
      'qualifications': qualifications.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OffersImpl extends Offers {
  _OffersImpl({
    int? id,
    required int author,
    required String authorName,
    required String title,
    required bool acceptingApplications,
    required bool isActive,
    required String pay,
    required String offerType,
    required String location,
    required String description,
    required int duration,
    required List<String> qualifications,
  }) : super._(
          id: id,
          author: author,
          authorName: authorName,
          title: title,
          acceptingApplications: acceptingApplications,
          isActive: isActive,
          pay: pay,
          offerType: offerType,
          location: location,
          description: description,
          duration: duration,
          qualifications: qualifications,
        );

  /// Returns a shallow copy of this [Offers]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Offers copyWith({
    Object? id = _Undefined,
    int? author,
    String? authorName,
    String? title,
    bool? acceptingApplications,
    bool? isActive,
    String? pay,
    String? offerType,
    String? location,
    String? description,
    int? duration,
    List<String>? qualifications,
  }) {
    return Offers(
      id: id is int? ? id : this.id,
      author: author ?? this.author,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      acceptingApplications:
          acceptingApplications ?? this.acceptingApplications,
      isActive: isActive ?? this.isActive,
      pay: pay ?? this.pay,
      offerType: offerType ?? this.offerType,
      location: location ?? this.location,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      qualifications:
          qualifications ?? this.qualifications.map((e0) => e0).toList(),
    );
  }
}
