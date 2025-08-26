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
import 'invitations.dart' as _i2;

abstract class Connect
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Connect._({
    this.id,
    this.accountId,
    required this.activeConnections,
    this.receivedPending,
    this.sentPending,
  });

  factory Connect({
    int? id,
    int? accountId,
    required List<int> activeConnections,
    List<_i2.Invitation>? receivedPending,
    List<_i2.Invitation>? sentPending,
  }) = _ConnectImpl;

  factory Connect.fromJson(Map<String, dynamic> jsonSerialization) {
    return Connect(
      id: jsonSerialization['id'] as int?,
      accountId: jsonSerialization['accountId'] as int?,
      activeConnections: (jsonSerialization['activeConnections'] as List)
          .map((e) => e as int)
          .toList(),
      receivedPending: (jsonSerialization['receivedPending'] as List?)
          ?.map((e) => _i2.Invitation.fromJson((e as Map<String, dynamic>)))
          .toList(),
      sentPending: (jsonSerialization['sentPending'] as List?)
          ?.map((e) => _i2.Invitation.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = ConnectTable();

  static const db = ConnectRepository._();

  @override
  int? id;

  int? accountId;

  List<int> activeConnections;

  List<_i2.Invitation>? receivedPending;

  List<_i2.Invitation>? sentPending;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Connect]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Connect copyWith({
    int? id,
    int? accountId,
    List<int>? activeConnections,
    List<_i2.Invitation>? receivedPending,
    List<_i2.Invitation>? sentPending,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (accountId != null) 'accountId': accountId,
      'activeConnections': activeConnections.toJson(),
      if (receivedPending != null)
        'receivedPending':
            receivedPending?.toJson(valueToJson: (v) => v.toJson()),
      if (sentPending != null)
        'sentPending': sentPending?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (accountId != null) 'accountId': accountId,
      'activeConnections': activeConnections.toJson(),
      if (receivedPending != null)
        'receivedPending':
            receivedPending?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (sentPending != null)
        'sentPending':
            sentPending?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static ConnectInclude include() {
    return ConnectInclude._();
  }

  static ConnectIncludeList includeList({
    _i1.WhereExpressionBuilder<ConnectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConnectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConnectTable>? orderByList,
    ConnectInclude? include,
  }) {
    return ConnectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Connect.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Connect.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConnectImpl extends Connect {
  _ConnectImpl({
    int? id,
    int? accountId,
    required List<int> activeConnections,
    List<_i2.Invitation>? receivedPending,
    List<_i2.Invitation>? sentPending,
  }) : super._(
          id: id,
          accountId: accountId,
          activeConnections: activeConnections,
          receivedPending: receivedPending,
          sentPending: sentPending,
        );

  /// Returns a shallow copy of this [Connect]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Connect copyWith({
    Object? id = _Undefined,
    Object? accountId = _Undefined,
    List<int>? activeConnections,
    Object? receivedPending = _Undefined,
    Object? sentPending = _Undefined,
  }) {
    return Connect(
      id: id is int? ? id : this.id,
      accountId: accountId is int? ? accountId : this.accountId,
      activeConnections:
          activeConnections ?? this.activeConnections.map((e0) => e0).toList(),
      receivedPending: receivedPending is List<_i2.Invitation>?
          ? receivedPending
          : this.receivedPending?.map((e0) => e0.copyWith()).toList(),
      sentPending: sentPending is List<_i2.Invitation>?
          ? sentPending
          : this.sentPending?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class ConnectTable extends _i1.Table<int?> {
  ConnectTable({super.tableRelation}) : super(tableName: 'connect') {
    accountId = _i1.ColumnInt(
      'accountId',
      this,
    );
    activeConnections = _i1.ColumnSerializable(
      'activeConnections',
      this,
    );
    receivedPending = _i1.ColumnSerializable(
      'receivedPending',
      this,
    );
    sentPending = _i1.ColumnSerializable(
      'sentPending',
      this,
    );
  }

  late final _i1.ColumnInt accountId;

  late final _i1.ColumnSerializable activeConnections;

  late final _i1.ColumnSerializable receivedPending;

  late final _i1.ColumnSerializable sentPending;

  @override
  List<_i1.Column> get columns => [
        id,
        accountId,
        activeConnections,
        receivedPending,
        sentPending,
      ];
}

class ConnectInclude extends _i1.IncludeObject {
  ConnectInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Connect.t;
}

class ConnectIncludeList extends _i1.IncludeList {
  ConnectIncludeList._({
    _i1.WhereExpressionBuilder<ConnectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Connect.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Connect.t;
}

class ConnectRepository {
  const ConnectRepository._();

  /// Returns a list of [Connect]s matching the given query parameters.
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
  Future<List<Connect>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConnectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConnectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConnectTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Connect>(
      where: where?.call(Connect.t),
      orderBy: orderBy?.call(Connect.t),
      orderByList: orderByList?.call(Connect.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Connect] matching the given query parameters.
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
  Future<Connect?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConnectTable>? where,
    int? offset,
    _i1.OrderByBuilder<ConnectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConnectTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Connect>(
      where: where?.call(Connect.t),
      orderBy: orderBy?.call(Connect.t),
      orderByList: orderByList?.call(Connect.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Connect] by its [id] or null if no such row exists.
  Future<Connect?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Connect>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Connect]s in the list and returns the inserted rows.
  ///
  /// The returned [Connect]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Connect>> insert(
    _i1.Session session,
    List<Connect> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Connect>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Connect] and returns the inserted row.
  ///
  /// The returned [Connect] will have its `id` field set.
  Future<Connect> insertRow(
    _i1.Session session,
    Connect row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Connect>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Connect]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Connect>> update(
    _i1.Session session,
    List<Connect> rows, {
    _i1.ColumnSelections<ConnectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Connect>(
      rows,
      columns: columns?.call(Connect.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Connect]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Connect> updateRow(
    _i1.Session session,
    Connect row, {
    _i1.ColumnSelections<ConnectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Connect>(
      row,
      columns: columns?.call(Connect.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Connect]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Connect>> delete(
    _i1.Session session,
    List<Connect> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Connect>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Connect].
  Future<Connect> deleteRow(
    _i1.Session session,
    Connect row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Connect>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Connect>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ConnectTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Connect>(
      where: where(Connect.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConnectTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Connect>(
      where: where?.call(Connect.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
