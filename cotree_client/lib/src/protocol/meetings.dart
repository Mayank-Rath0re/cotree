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

abstract class Meetings implements _i1.SerializableModel {
  Meetings._({
    this.id,
    required this.teamId,
    required this.agenda,
    required this.time,
    required this.duration,
    required this.status,
    required this.startedBy,
    required this.url,
    required this.members,
  });

  factory Meetings({
    int? id,
    required int teamId,
    required String agenda,
    required DateTime time,
    required Duration duration,
    required String status,
    required int startedBy,
    required String url,
    required List<int> members,
  }) = _MeetingsImpl;

  factory Meetings.fromJson(Map<String, dynamic> jsonSerialization) {
    return Meetings(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      agenda: jsonSerialization['agenda'] as String,
      time: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['time']),
      duration:
          _i1.DurationJsonExtension.fromJson(jsonSerialization['duration']),
      status: jsonSerialization['status'] as String,
      startedBy: jsonSerialization['startedBy'] as int,
      url: jsonSerialization['url'] as String,
      members:
          (jsonSerialization['members'] as List).map((e) => e as int).toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int teamId;

  String agenda;

  DateTime time;

  Duration duration;

  String status;

  int startedBy;

  String url;

  List<int> members;

  /// Returns a shallow copy of this [Meetings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Meetings copyWith({
    int? id,
    int? teamId,
    String? agenda,
    DateTime? time,
    Duration? duration,
    String? status,
    int? startedBy,
    String? url,
    List<int>? members,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'teamId': teamId,
      'agenda': agenda,
      'time': time.toJson(),
      'duration': duration.toJson(),
      'status': status,
      'startedBy': startedBy,
      'url': url,
      'members': members.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeetingsImpl extends Meetings {
  _MeetingsImpl({
    int? id,
    required int teamId,
    required String agenda,
    required DateTime time,
    required Duration duration,
    required String status,
    required int startedBy,
    required String url,
    required List<int> members,
  }) : super._(
          id: id,
          teamId: teamId,
          agenda: agenda,
          time: time,
          duration: duration,
          status: status,
          startedBy: startedBy,
          url: url,
          members: members,
        );

  /// Returns a shallow copy of this [Meetings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Meetings copyWith({
    Object? id = _Undefined,
    int? teamId,
    String? agenda,
    DateTime? time,
    Duration? duration,
    String? status,
    int? startedBy,
    String? url,
    List<int>? members,
  }) {
    return Meetings(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      agenda: agenda ?? this.agenda,
      time: time ?? this.time,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      startedBy: startedBy ?? this.startedBy,
      url: url ?? this.url,
      members: members ?? this.members.map((e0) => e0).toList(),
    );
  }
}
