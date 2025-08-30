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

abstract class ReportPost
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ReportPost._({
    this.id,
    required this.reporterId,
    required this.postId,
    required this.reason,
  });

  factory ReportPost({
    int? id,
    required int reporterId,
    required int postId,
    required String reason,
  }) = _ReportPostImpl;

  factory ReportPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportPost(
      id: jsonSerialization['id'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      postId: jsonSerialization['postId'] as int,
      reason: jsonSerialization['reason'] as String,
    );
  }

  static final t = ReportPostTable();

  static const db = ReportPostRepository._();

  @override
  int? id;

  int reporterId;

  int postId;

  String reason;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReportPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReportPost copyWith({
    int? id,
    int? reporterId,
    int? postId,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'postId': postId,
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'postId': postId,
      'reason': reason,
    };
  }

  static ReportPostInclude include() {
    return ReportPostInclude._();
  }

  static ReportPostIncludeList includeList({
    _i1.WhereExpressionBuilder<ReportPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportPostTable>? orderByList,
    ReportPostInclude? include,
  }) {
    return ReportPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReportPost.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReportPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportPostImpl extends ReportPost {
  _ReportPostImpl({
    int? id,
    required int reporterId,
    required int postId,
    required String reason,
  }) : super._(
          id: id,
          reporterId: reporterId,
          postId: postId,
          reason: reason,
        );

  /// Returns a shallow copy of this [ReportPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReportPost copyWith({
    Object? id = _Undefined,
    int? reporterId,
    int? postId,
    String? reason,
  }) {
    return ReportPost(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      postId: postId ?? this.postId,
      reason: reason ?? this.reason,
    );
  }
}

class ReportPostTable extends _i1.Table<int?> {
  ReportPostTable({super.tableRelation}) : super(tableName: 'report_post') {
    reporterId = _i1.ColumnInt(
      'reporterId',
      this,
    );
    postId = _i1.ColumnInt(
      'postId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
  }

  late final _i1.ColumnInt reporterId;

  late final _i1.ColumnInt postId;

  late final _i1.ColumnString reason;

  @override
  List<_i1.Column> get columns => [
        id,
        reporterId,
        postId,
        reason,
      ];
}

class ReportPostInclude extends _i1.IncludeObject {
  ReportPostInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ReportPost.t;
}

class ReportPostIncludeList extends _i1.IncludeList {
  ReportPostIncludeList._({
    _i1.WhereExpressionBuilder<ReportPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReportPost.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReportPost.t;
}

class ReportPostRepository {
  const ReportPostRepository._();

  /// Returns a list of [ReportPost]s matching the given query parameters.
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
  Future<List<ReportPost>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ReportPost>(
      where: where?.call(ReportPost.t),
      orderBy: orderBy?.call(ReportPost.t),
      orderByList: orderByList?.call(ReportPost.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ReportPost] matching the given query parameters.
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
  Future<ReportPost?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportPostTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReportPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ReportPost>(
      where: where?.call(ReportPost.t),
      orderBy: orderBy?.call(ReportPost.t),
      orderByList: orderByList?.call(ReportPost.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ReportPost] by its [id] or null if no such row exists.
  Future<ReportPost?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ReportPost>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ReportPost]s in the list and returns the inserted rows.
  ///
  /// The returned [ReportPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ReportPost>> insert(
    _i1.Session session,
    List<ReportPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ReportPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ReportPost] and returns the inserted row.
  ///
  /// The returned [ReportPost] will have its `id` field set.
  Future<ReportPost> insertRow(
    _i1.Session session,
    ReportPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReportPost>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReportPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReportPost>> update(
    _i1.Session session,
    List<ReportPost> rows, {
    _i1.ColumnSelections<ReportPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReportPost>(
      rows,
      columns: columns?.call(ReportPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReportPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReportPost> updateRow(
    _i1.Session session,
    ReportPost row, {
    _i1.ColumnSelections<ReportPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReportPost>(
      row,
      columns: columns?.call(ReportPost.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ReportPost]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReportPost>> delete(
    _i1.Session session,
    List<ReportPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReportPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReportPost].
  Future<ReportPost> deleteRow(
    _i1.Session session,
    ReportPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReportPost>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReportPost>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReportPostTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReportPost>(
      where: where(ReportPost.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportPostTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReportPost>(
      where: where?.call(ReportPost.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
