/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Meetings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = MeetingsTable();

  static const db = MeetingsRepository._();

  @override
  int? id;

  int teamId;

  String agenda;

  DateTime time;

  Duration duration;

  String status;

  int startedBy;

  String url;

  List<int> members;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static MeetingsInclude include() {
    return MeetingsInclude._();
  }

  static MeetingsIncludeList includeList({
    _i1.WhereExpressionBuilder<MeetingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MeetingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MeetingsTable>? orderByList,
    MeetingsInclude? include,
  }) {
    return MeetingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Meetings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Meetings.t),
      include: include,
    );
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

class MeetingsTable extends _i1.Table<int?> {
  MeetingsTable({super.tableRelation}) : super(tableName: 'meetings') {
    teamId = _i1.ColumnInt(
      'teamId',
      this,
    );
    agenda = _i1.ColumnString(
      'agenda',
      this,
    );
    time = _i1.ColumnDateTime(
      'time',
      this,
    );
    duration = _i1.ColumnDuration(
      'duration',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    startedBy = _i1.ColumnInt(
      'startedBy',
      this,
    );
    url = _i1.ColumnString(
      'url',
      this,
    );
    members = _i1.ColumnSerializable(
      'members',
      this,
    );
  }

  late final _i1.ColumnInt teamId;

  late final _i1.ColumnString agenda;

  late final _i1.ColumnDateTime time;

  late final _i1.ColumnDuration duration;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt startedBy;

  late final _i1.ColumnString url;

  late final _i1.ColumnSerializable members;

  @override
  List<_i1.Column> get columns => [
        id,
        teamId,
        agenda,
        time,
        duration,
        status,
        startedBy,
        url,
        members,
      ];
}

class MeetingsInclude extends _i1.IncludeObject {
  MeetingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Meetings.t;
}

class MeetingsIncludeList extends _i1.IncludeList {
  MeetingsIncludeList._({
    _i1.WhereExpressionBuilder<MeetingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Meetings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Meetings.t;
}

class MeetingsRepository {
  const MeetingsRepository._();

  /// Returns a list of [Meetings]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Meetings>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MeetingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MeetingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MeetingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Meetings>(
      where: where?.call(Meetings.t),
      orderBy: orderBy?.call(Meetings.t),
      orderByList: orderByList?.call(Meetings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Meetings] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Meetings?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MeetingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<MeetingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MeetingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Meetings>(
      where: where?.call(Meetings.t),
      orderBy: orderBy?.call(Meetings.t),
      orderByList: orderByList?.call(Meetings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Meetings] by its [id] or null if no such row exists.
  Future<Meetings?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Meetings>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Meetings]s in the list and returns the inserted rows.
  ///
  /// The returned [Meetings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Meetings>> insert(
    _i1.Session session,
    List<Meetings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Meetings>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Meetings] and returns the inserted row.
  ///
  /// The returned [Meetings] will have its `id` field set.
  Future<Meetings> insertRow(
    _i1.Session session,
    Meetings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Meetings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Meetings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Meetings>> update(
    _i1.Session session,
    List<Meetings> rows, {
    _i1.ColumnSelections<MeetingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Meetings>(
      rows,
      columns: columns?.call(Meetings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Meetings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Meetings> updateRow(
    _i1.Session session,
    Meetings row, {
    _i1.ColumnSelections<MeetingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Meetings>(
      row,
      columns: columns?.call(Meetings.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Meetings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Meetings>> delete(
    _i1.Session session,
    List<Meetings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Meetings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Meetings].
  Future<Meetings> deleteRow(
    _i1.Session session,
    Meetings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Meetings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Meetings>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MeetingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Meetings>(
      where: where(Meetings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MeetingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Meetings>(
      where: where?.call(Meetings.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
