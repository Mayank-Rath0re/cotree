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

abstract class Teams implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Teams._({
    this.id,
    required this.spaceId,
    required this.teamTitle,
    required this.chatId,
  });

  factory Teams({
    int? id,
    required int spaceId,
    required String teamTitle,
    required int chatId,
  }) = _TeamsImpl;

  factory Teams.fromJson(Map<String, dynamic> jsonSerialization) {
    return Teams(
      id: jsonSerialization['id'] as int?,
      spaceId: jsonSerialization['spaceId'] as int,
      teamTitle: jsonSerialization['teamTitle'] as String,
      chatId: jsonSerialization['chatId'] as int,
    );
  }

  static final t = TeamsTable();

  static const db = TeamsRepository._();

  @override
  int? id;

  int spaceId;

  String teamTitle;

  int chatId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Teams]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Teams copyWith({
    int? id,
    int? spaceId,
    String? teamTitle,
    int? chatId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'spaceId': spaceId,
      'teamTitle': teamTitle,
      'chatId': chatId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'spaceId': spaceId,
      'teamTitle': teamTitle,
      'chatId': chatId,
    };
  }

  static TeamsInclude include() {
    return TeamsInclude._();
  }

  static TeamsIncludeList includeList({
    _i1.WhereExpressionBuilder<TeamsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamsTable>? orderByList,
    TeamsInclude? include,
  }) {
    return TeamsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Teams.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Teams.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TeamsImpl extends Teams {
  _TeamsImpl({
    int? id,
    required int spaceId,
    required String teamTitle,
    required int chatId,
  }) : super._(
          id: id,
          spaceId: spaceId,
          teamTitle: teamTitle,
          chatId: chatId,
        );

  /// Returns a shallow copy of this [Teams]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Teams copyWith({
    Object? id = _Undefined,
    int? spaceId,
    String? teamTitle,
    int? chatId,
  }) {
    return Teams(
      id: id is int? ? id : this.id,
      spaceId: spaceId ?? this.spaceId,
      teamTitle: teamTitle ?? this.teamTitle,
      chatId: chatId ?? this.chatId,
    );
  }
}

class TeamsTable extends _i1.Table<int?> {
  TeamsTable({super.tableRelation}) : super(tableName: 'teams') {
    spaceId = _i1.ColumnInt(
      'spaceId',
      this,
    );
    teamTitle = _i1.ColumnString(
      'teamTitle',
      this,
    );
    chatId = _i1.ColumnInt(
      'chatId',
      this,
    );
  }

  late final _i1.ColumnInt spaceId;

  late final _i1.ColumnString teamTitle;

  late final _i1.ColumnInt chatId;

  @override
  List<_i1.Column> get columns => [
        id,
        spaceId,
        teamTitle,
        chatId,
      ];
}

class TeamsInclude extends _i1.IncludeObject {
  TeamsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Teams.t;
}

class TeamsIncludeList extends _i1.IncludeList {
  TeamsIncludeList._({
    _i1.WhereExpressionBuilder<TeamsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Teams.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Teams.t;
}

class TeamsRepository {
  const TeamsRepository._();

  /// Returns a list of [Teams]s matching the given query parameters.
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
  Future<List<Teams>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TeamsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Teams>(
      where: where?.call(Teams.t),
      orderBy: orderBy?.call(Teams.t),
      orderByList: orderByList?.call(Teams.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Teams] matching the given query parameters.
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
  Future<Teams?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TeamsTable>? where,
    int? offset,
    _i1.OrderByBuilder<TeamsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Teams>(
      where: where?.call(Teams.t),
      orderBy: orderBy?.call(Teams.t),
      orderByList: orderByList?.call(Teams.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Teams] by its [id] or null if no such row exists.
  Future<Teams?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Teams>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Teams]s in the list and returns the inserted rows.
  ///
  /// The returned [Teams]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Teams>> insert(
    _i1.Session session,
    List<Teams> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Teams>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Teams] and returns the inserted row.
  ///
  /// The returned [Teams] will have its `id` field set.
  Future<Teams> insertRow(
    _i1.Session session,
    Teams row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Teams>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Teams]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Teams>> update(
    _i1.Session session,
    List<Teams> rows, {
    _i1.ColumnSelections<TeamsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Teams>(
      rows,
      columns: columns?.call(Teams.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Teams]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Teams> updateRow(
    _i1.Session session,
    Teams row, {
    _i1.ColumnSelections<TeamsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Teams>(
      row,
      columns: columns?.call(Teams.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Teams]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Teams>> delete(
    _i1.Session session,
    List<Teams> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Teams>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Teams].
  Future<Teams> deleteRow(
    _i1.Session session,
    Teams row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Teams>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Teams>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TeamsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Teams>(
      where: where(Teams.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TeamsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Teams>(
      where: where?.call(Teams.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
