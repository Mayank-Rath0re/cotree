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

abstract class ReportUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ReportUser._({
    this.id,
    required this.reporterId,
    required this.reportedId,
    required this.reason,
  });

  factory ReportUser({
    int? id,
    required int reporterId,
    required int reportedId,
    required String reason,
  }) = _ReportUserImpl;

  factory ReportUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportUser(
      id: jsonSerialization['id'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      reportedId: jsonSerialization['reportedId'] as int,
      reason: jsonSerialization['reason'] as String,
    );
  }

  static final t = ReportUserTable();

  static const db = ReportUserRepository._();

  @override
  int? id;

  int reporterId;

  int reportedId;

  String reason;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReportUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportUser copyWith({
    int? id,
    int? reporterId,
    int? reportedId,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'reportedId': reportedId,
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'reportedId': reportedId,
      'reason': reason,
    };
  }

  static ReportUserInclude include() {
    return ReportUserInclude._();
  }

  static ReportUserIncludeList includeList({
    _i1.WhereExpressionBuilder<ReportUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportUserTable>? orderByList,
    ReportUserInclude? include,
  }) {
    return ReportUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReportUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReportUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportUserImpl extends ReportUser {
  _ReportUserImpl({
    int? id,
    required int reporterId,
    required int reportedId,
    required String reason,
  }) : super._(
          id: id,
          reporterId: reporterId,
          reportedId: reportedId,
          reason: reason,
        );

  /// Returns a shallow copy of this [ReportUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportUser copyWith({
    Object? id = _Undefined,
    int? reporterId,
    int? reportedId,
    String? reason,
  }) {
    return ReportUser(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      reportedId: reportedId ?? this.reportedId,
      reason: reason ?? this.reason,
    );
  }
}

class ReportUserTable extends _i1.Table<int?> {
  ReportUserTable({super.tableRelation}) : super(tableName: 'report_user') {
    reporterId = _i1.ColumnInt(
      'reporterId',
      this,
    );
    reportedId = _i1.ColumnInt(
      'reportedId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
  }

  late final _i1.ColumnInt reporterId;

  late final _i1.ColumnInt reportedId;

  late final _i1.ColumnString reason;

  @override
  List<_i1.Column> get columns => [
        id,
        reporterId,
        reportedId,
        reason,
      ];
}

class ReportUserInclude extends _i1.IncludeObject {
  ReportUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ReportUser.t;
}

class ReportUserIncludeList extends _i1.IncludeList {
  ReportUserIncludeList._({
    _i1.WhereExpressionBuilder<ReportUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReportUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReportUser.t;
}

class ReportUserRepository {
  const ReportUserRepository._();

  /// Returns a list of [ReportUser]s matching the given query parameters.
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
  Future<List<ReportUser>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ReportUser>(
      where: where?.call(ReportUser.t),
      orderBy: orderBy?.call(ReportUser.t),
      orderByList: orderByList?.call(ReportUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ReportUser] matching the given query parameters.
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
  Future<ReportUser?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReportUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ReportUser>(
      where: where?.call(ReportUser.t),
      orderBy: orderBy?.call(ReportUser.t),
      orderByList: orderByList?.call(ReportUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ReportUser] by its [id] or null if no such row exists.
  Future<ReportUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ReportUser>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ReportUser]s in the list and returns the inserted rows.
  ///
  /// The returned [ReportUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ReportUser>> insert(
    _i1.Session session,
    List<ReportUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ReportUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ReportUser] and returns the inserted row.
  ///
  /// The returned [ReportUser] will have its `id` field set.
  Future<ReportUser> insertRow(
    _i1.Session session,
    ReportUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReportUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReportUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReportUser>> update(
    _i1.Session session,
    List<ReportUser> rows, {
    _i1.ColumnSelections<ReportUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReportUser>(
      rows,
      columns: columns?.call(ReportUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReportUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReportUser> updateRow(
    _i1.Session session,
    ReportUser row, {
    _i1.ColumnSelections<ReportUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReportUser>(
      row,
      columns: columns?.call(ReportUser.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ReportUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReportUser>> delete(
    _i1.Session session,
    List<ReportUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReportUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReportUser].
  Future<ReportUser> deleteRow(
    _i1.Session session,
    ReportUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReportUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReportUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReportUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReportUser>(
      where: where(ReportUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReportUser>(
      where: where?.call(ReportUser.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
