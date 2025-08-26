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

abstract class SpaceInvite
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SpaceInvite._({
    this.id,
    required this.spaceId,
    required this.userId,
    required this.designation,
    required this.globalRole,
    required this.teams,
    required this.sentOn,
    required this.sentBy,
    required this.status,
    required this.unread,
  });

  factory SpaceInvite({
    int? id,
    required int spaceId,
    required int userId,
    required String designation,
    required String globalRole,
    required List<List<String>> teams,
    required DateTime sentOn,
    required int sentBy,
    required String status,
    required bool unread,
  }) = _SpaceInviteImpl;

  factory SpaceInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpaceInvite(
      id: jsonSerialization['id'] as int?,
      spaceId: jsonSerialization['spaceId'] as int,
      userId: jsonSerialization['userId'] as int,
      designation: jsonSerialization['designation'] as String,
      globalRole: jsonSerialization['globalRole'] as String,
      teams: (jsonSerialization['teams'] as List)
          .map((e) => (e as List).map((e) => e as String).toList())
          .toList(),
      sentOn: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentOn']),
      sentBy: jsonSerialization['sentBy'] as int,
      status: jsonSerialization['status'] as String,
      unread: jsonSerialization['unread'] as bool,
    );
  }

  static final t = SpaceInviteTable();

  static const db = SpaceInviteRepository._();

  @override
  int? id;

  int spaceId;

  int userId;

  String designation;

  String globalRole;

  List<List<String>> teams;

  DateTime sentOn;

  int sentBy;

  String status;

  bool unread;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SpaceInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpaceInvite copyWith({
    int? id,
    int? spaceId,
    int? userId,
    String? designation,
    String? globalRole,
    List<List<String>>? teams,
    DateTime? sentOn,
    int? sentBy,
    String? status,
    bool? unread,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'spaceId': spaceId,
      'userId': userId,
      'designation': designation,
      'globalRole': globalRole,
      'teams': teams.toJson(valueToJson: (v) => v.toJson()),
      'sentOn': sentOn.toJson(),
      'sentBy': sentBy,
      'status': status,
      'unread': unread,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'spaceId': spaceId,
      'userId': userId,
      'designation': designation,
      'globalRole': globalRole,
      'teams': teams.toJson(valueToJson: (v) => v.toJson()),
      'sentOn': sentOn.toJson(),
      'sentBy': sentBy,
      'status': status,
      'unread': unread,
    };
  }

  static SpaceInviteInclude include() {
    return SpaceInviteInclude._();
  }

  static SpaceInviteIncludeList includeList({
    _i1.WhereExpressionBuilder<SpaceInviteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpaceInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpaceInviteTable>? orderByList,
    SpaceInviteInclude? include,
  }) {
    return SpaceInviteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpaceInvite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SpaceInvite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpaceInviteImpl extends SpaceInvite {
  _SpaceInviteImpl({
    int? id,
    required int spaceId,
    required int userId,
    required String designation,
    required String globalRole,
    required List<List<String>> teams,
    required DateTime sentOn,
    required int sentBy,
    required String status,
    required bool unread,
  }) : super._(
          id: id,
          spaceId: spaceId,
          userId: userId,
          designation: designation,
          globalRole: globalRole,
          teams: teams,
          sentOn: sentOn,
          sentBy: sentBy,
          status: status,
          unread: unread,
        );

  /// Returns a shallow copy of this [SpaceInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpaceInvite copyWith({
    Object? id = _Undefined,
    int? spaceId,
    int? userId,
    String? designation,
    String? globalRole,
    List<List<String>>? teams,
    DateTime? sentOn,
    int? sentBy,
    String? status,
    bool? unread,
  }) {
    return SpaceInvite(
      id: id is int? ? id : this.id,
      spaceId: spaceId ?? this.spaceId,
      userId: userId ?? this.userId,
      designation: designation ?? this.designation,
      globalRole: globalRole ?? this.globalRole,
      teams:
          teams ?? this.teams.map((e0) => e0.map((e1) => e1).toList()).toList(),
      sentOn: sentOn ?? this.sentOn,
      sentBy: sentBy ?? this.sentBy,
      status: status ?? this.status,
      unread: unread ?? this.unread,
    );
  }
}

class SpaceInviteTable extends _i1.Table<int?> {
  SpaceInviteTable({super.tableRelation}) : super(tableName: 'space_invite') {
    spaceId = _i1.ColumnInt(
      'spaceId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    designation = _i1.ColumnString(
      'designation',
      this,
    );
    globalRole = _i1.ColumnString(
      'globalRole',
      this,
    );
    teams = _i1.ColumnSerializable(
      'teams',
      this,
    );
    sentOn = _i1.ColumnDateTime(
      'sentOn',
      this,
    );
    sentBy = _i1.ColumnInt(
      'sentBy',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    unread = _i1.ColumnBool(
      'unread',
      this,
    );
  }

  late final _i1.ColumnInt spaceId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString designation;

  late final _i1.ColumnString globalRole;

  late final _i1.ColumnSerializable teams;

  late final _i1.ColumnDateTime sentOn;

  late final _i1.ColumnInt sentBy;

  late final _i1.ColumnString status;

  late final _i1.ColumnBool unread;

  @override
  List<_i1.Column> get columns => [
        id,
        spaceId,
        userId,
        designation,
        globalRole,
        teams,
        sentOn,
        sentBy,
        status,
        unread,
      ];
}

class SpaceInviteInclude extends _i1.IncludeObject {
  SpaceInviteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SpaceInvite.t;
}

class SpaceInviteIncludeList extends _i1.IncludeList {
  SpaceInviteIncludeList._({
    _i1.WhereExpressionBuilder<SpaceInviteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SpaceInvite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SpaceInvite.t;
}

class SpaceInviteRepository {
  const SpaceInviteRepository._();

  /// Returns a list of [SpaceInvite]s matching the given query parameters.
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
  Future<List<SpaceInvite>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpaceInviteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpaceInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpaceInviteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SpaceInvite>(
      where: where?.call(SpaceInvite.t),
      orderBy: orderBy?.call(SpaceInvite.t),
      orderByList: orderByList?.call(SpaceInvite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SpaceInvite] matching the given query parameters.
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
  Future<SpaceInvite?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpaceInviteTable>? where,
    int? offset,
    _i1.OrderByBuilder<SpaceInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpaceInviteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SpaceInvite>(
      where: where?.call(SpaceInvite.t),
      orderBy: orderBy?.call(SpaceInvite.t),
      orderByList: orderByList?.call(SpaceInvite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SpaceInvite] by its [id] or null if no such row exists.
  Future<SpaceInvite?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SpaceInvite>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SpaceInvite]s in the list and returns the inserted rows.
  ///
  /// The returned [SpaceInvite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SpaceInvite>> insert(
    _i1.Session session,
    List<SpaceInvite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SpaceInvite>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SpaceInvite] and returns the inserted row.
  ///
  /// The returned [SpaceInvite] will have its `id` field set.
  Future<SpaceInvite> insertRow(
    _i1.Session session,
    SpaceInvite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SpaceInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SpaceInvite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SpaceInvite>> update(
    _i1.Session session,
    List<SpaceInvite> rows, {
    _i1.ColumnSelections<SpaceInviteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SpaceInvite>(
      rows,
      columns: columns?.call(SpaceInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpaceInvite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SpaceInvite> updateRow(
    _i1.Session session,
    SpaceInvite row, {
    _i1.ColumnSelections<SpaceInviteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SpaceInvite>(
      row,
      columns: columns?.call(SpaceInvite.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SpaceInvite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SpaceInvite>> delete(
    _i1.Session session,
    List<SpaceInvite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SpaceInvite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SpaceInvite].
  Future<SpaceInvite> deleteRow(
    _i1.Session session,
    SpaceInvite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SpaceInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SpaceInvite>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpaceInviteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SpaceInvite>(
      where: where(SpaceInvite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpaceInviteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SpaceInvite>(
      where: where?.call(SpaceInvite.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
