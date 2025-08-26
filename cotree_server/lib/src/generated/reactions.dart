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

abstract class Reaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Reaction._({
    this.id,
    required this.userId,
    required this.reactableId,
    required this.reactableType,
    required this.type,
  });

  factory Reaction({
    int? id,
    required int userId,
    required int reactableId,
    required String reactableType,
    required int type,
  }) = _ReactionImpl;

  factory Reaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reaction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      reactableId: jsonSerialization['reactableId'] as int,
      reactableType: jsonSerialization['reactableType'] as String,
      type: jsonSerialization['type'] as int,
    );
  }

  static final t = ReactionTable();

  static const db = ReactionRepository._();

  @override
  int? id;

  int userId;

  int reactableId;

  String reactableType;

  int type;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Reaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Reaction copyWith({
    int? id,
    int? userId,
    int? reactableId,
    String? reactableType,
    int? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'reactableId': reactableId,
      'reactableType': reactableType,
      'type': type,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'reactableId': reactableId,
      'reactableType': reactableType,
      'type': type,
    };
  }

  static ReactionInclude include() {
    return ReactionInclude._();
  }

  static ReactionIncludeList includeList({
    _i1.WhereExpressionBuilder<ReactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReactionTable>? orderByList,
    ReactionInclude? include,
  }) {
    return ReactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Reaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReactionImpl extends Reaction {
  _ReactionImpl({
    int? id,
    required int userId,
    required int reactableId,
    required String reactableType,
    required int type,
  }) : super._(
          id: id,
          userId: userId,
          reactableId: reactableId,
          reactableType: reactableType,
          type: type,
        );

  /// Returns a shallow copy of this [Reaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Reaction copyWith({
    Object? id = _Undefined,
    int? userId,
    int? reactableId,
    String? reactableType,
    int? type,
  }) {
    return Reaction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      reactableId: reactableId ?? this.reactableId,
      reactableType: reactableType ?? this.reactableType,
      type: type ?? this.type,
    );
  }
}

class ReactionTable extends _i1.Table<int?> {
  ReactionTable({super.tableRelation}) : super(tableName: 'reaction') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    reactableId = _i1.ColumnInt(
      'reactableId',
      this,
    );
    reactableType = _i1.ColumnString(
      'reactableType',
      this,
    );
    type = _i1.ColumnInt(
      'type',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt reactableId;

  late final _i1.ColumnString reactableType;

  late final _i1.ColumnInt type;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        reactableId,
        reactableType,
        type,
      ];
}

class ReactionInclude extends _i1.IncludeObject {
  ReactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Reaction.t;
}

class ReactionIncludeList extends _i1.IncludeList {
  ReactionIncludeList._({
    _i1.WhereExpressionBuilder<ReactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Reaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Reaction.t;
}

class ReactionRepository {
  const ReactionRepository._();

  /// Returns a list of [Reaction]s matching the given query parameters.
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
  Future<List<Reaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Reaction>(
      where: where?.call(Reaction.t),
      orderBy: orderBy?.call(Reaction.t),
      orderByList: orderByList?.call(Reaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Reaction] matching the given query parameters.
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
  Future<Reaction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Reaction>(
      where: where?.call(Reaction.t),
      orderBy: orderBy?.call(Reaction.t),
      orderByList: orderByList?.call(Reaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Reaction] by its [id] or null if no such row exists.
  Future<Reaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Reaction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Reaction]s in the list and returns the inserted rows.
  ///
  /// The returned [Reaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Reaction>> insert(
    _i1.Session session,
    List<Reaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Reaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Reaction] and returns the inserted row.
  ///
  /// The returned [Reaction] will have its `id` field set.
  Future<Reaction> insertRow(
    _i1.Session session,
    Reaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Reaction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Reaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Reaction>> update(
    _i1.Session session,
    List<Reaction> rows, {
    _i1.ColumnSelections<ReactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Reaction>(
      rows,
      columns: columns?.call(Reaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Reaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Reaction> updateRow(
    _i1.Session session,
    Reaction row, {
    _i1.ColumnSelections<ReactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Reaction>(
      row,
      columns: columns?.call(Reaction.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Reaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Reaction>> delete(
    _i1.Session session,
    List<Reaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Reaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Reaction].
  Future<Reaction> deleteRow(
    _i1.Session session,
    Reaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Reaction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Reaction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Reaction>(
      where: where(Reaction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Reaction>(
      where: where?.call(Reaction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
