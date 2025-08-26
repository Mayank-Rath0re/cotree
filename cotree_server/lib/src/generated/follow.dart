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

abstract class Follow implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Follow._({
    this.id,
    required this.orgId,
    required this.followedBy,
  });

  factory Follow({
    int? id,
    required int orgId,
    required int followedBy,
  }) = _FollowImpl;

  factory Follow.fromJson(Map<String, dynamic> jsonSerialization) {
    return Follow(
      id: jsonSerialization['id'] as int?,
      orgId: jsonSerialization['orgId'] as int,
      followedBy: jsonSerialization['followedBy'] as int,
    );
  }

  static final t = FollowTable();

  static const db = FollowRepository._();

  @override
  int? id;

  int orgId;

  int followedBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Follow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Follow copyWith({
    int? id,
    int? orgId,
    int? followedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'orgId': orgId,
      'followedBy': followedBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'orgId': orgId,
      'followedBy': followedBy,
    };
  }

  static FollowInclude include() {
    return FollowInclude._();
  }

  static FollowIncludeList includeList({
    _i1.WhereExpressionBuilder<FollowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FollowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FollowTable>? orderByList,
    FollowInclude? include,
  }) {
    return FollowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Follow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Follow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FollowImpl extends Follow {
  _FollowImpl({
    int? id,
    required int orgId,
    required int followedBy,
  }) : super._(
          id: id,
          orgId: orgId,
          followedBy: followedBy,
        );

  /// Returns a shallow copy of this [Follow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Follow copyWith({
    Object? id = _Undefined,
    int? orgId,
    int? followedBy,
  }) {
    return Follow(
      id: id is int? ? id : this.id,
      orgId: orgId ?? this.orgId,
      followedBy: followedBy ?? this.followedBy,
    );
  }
}

class FollowTable extends _i1.Table<int?> {
  FollowTable({super.tableRelation}) : super(tableName: 'follow') {
    orgId = _i1.ColumnInt(
      'orgId',
      this,
    );
    followedBy = _i1.ColumnInt(
      'followedBy',
      this,
    );
  }

  late final _i1.ColumnInt orgId;

  late final _i1.ColumnInt followedBy;

  @override
  List<_i1.Column> get columns => [
        id,
        orgId,
        followedBy,
      ];
}

class FollowInclude extends _i1.IncludeObject {
  FollowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Follow.t;
}

class FollowIncludeList extends _i1.IncludeList {
  FollowIncludeList._({
    _i1.WhereExpressionBuilder<FollowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Follow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Follow.t;
}

class FollowRepository {
  const FollowRepository._();

  /// Returns a list of [Follow]s matching the given query parameters.
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
  Future<List<Follow>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FollowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FollowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FollowTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Follow>(
      where: where?.call(Follow.t),
      orderBy: orderBy?.call(Follow.t),
      orderByList: orderByList?.call(Follow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Follow] matching the given query parameters.
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
  Future<Follow?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FollowTable>? where,
    int? offset,
    _i1.OrderByBuilder<FollowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FollowTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Follow>(
      where: where?.call(Follow.t),
      orderBy: orderBy?.call(Follow.t),
      orderByList: orderByList?.call(Follow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Follow] by its [id] or null if no such row exists.
  Future<Follow?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Follow>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Follow]s in the list and returns the inserted rows.
  ///
  /// The returned [Follow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Follow>> insert(
    _i1.Session session,
    List<Follow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Follow>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Follow] and returns the inserted row.
  ///
  /// The returned [Follow] will have its `id` field set.
  Future<Follow> insertRow(
    _i1.Session session,
    Follow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Follow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Follow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Follow>> update(
    _i1.Session session,
    List<Follow> rows, {
    _i1.ColumnSelections<FollowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Follow>(
      rows,
      columns: columns?.call(Follow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Follow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Follow> updateRow(
    _i1.Session session,
    Follow row, {
    _i1.ColumnSelections<FollowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Follow>(
      row,
      columns: columns?.call(Follow.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Follow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Follow>> delete(
    _i1.Session session,
    List<Follow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Follow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Follow].
  Future<Follow> deleteRow(
    _i1.Session session,
    Follow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Follow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Follow>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FollowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Follow>(
      where: where(Follow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FollowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Follow>(
      where: where?.call(Follow.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
