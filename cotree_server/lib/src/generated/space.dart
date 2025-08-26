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

abstract class Space implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Space._({
    this.id,
    required this.ownerId,
    this.credentials,
    required this.avatar,
    required this.title,
    required this.description,
    required this.memberLimit,
  });

  factory Space({
    int? id,
    required int ownerId,
    String? credentials,
    required String avatar,
    required String title,
    required String description,
    required int memberLimit,
  }) = _SpaceImpl;

  factory Space.fromJson(Map<String, dynamic> jsonSerialization) {
    return Space(
      id: jsonSerialization['id'] as int?,
      ownerId: jsonSerialization['ownerId'] as int,
      credentials: jsonSerialization['credentials'] as String?,
      avatar: jsonSerialization['avatar'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      memberLimit: jsonSerialization['memberLimit'] as int,
    );
  }

  static final t = SpaceTable();

  static const db = SpaceRepository._();

  @override
  int? id;

  int ownerId;

  String? credentials;

  String avatar;

  String title;

  String description;

  int memberLimit;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Space]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Space copyWith({
    int? id,
    int? ownerId,
    String? credentials,
    String? avatar,
    String? title,
    String? description,
    int? memberLimit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'ownerId': ownerId,
      if (credentials != null) 'credentials': credentials,
      'avatar': avatar,
      'title': title,
      'description': description,
      'memberLimit': memberLimit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'ownerId': ownerId,
      if (credentials != null) 'credentials': credentials,
      'avatar': avatar,
      'title': title,
      'description': description,
      'memberLimit': memberLimit,
    };
  }

  static SpaceInclude include() {
    return SpaceInclude._();
  }

  static SpaceIncludeList includeList({
    _i1.WhereExpressionBuilder<SpaceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpaceTable>? orderByList,
    SpaceInclude? include,
  }) {
    return SpaceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Space.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Space.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpaceImpl extends Space {
  _SpaceImpl({
    int? id,
    required int ownerId,
    String? credentials,
    required String avatar,
    required String title,
    required String description,
    required int memberLimit,
  }) : super._(
          id: id,
          ownerId: ownerId,
          credentials: credentials,
          avatar: avatar,
          title: title,
          description: description,
          memberLimit: memberLimit,
        );

  /// Returns a shallow copy of this [Space]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Space copyWith({
    Object? id = _Undefined,
    int? ownerId,
    Object? credentials = _Undefined,
    String? avatar,
    String? title,
    String? description,
    int? memberLimit,
  }) {
    return Space(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      credentials: credentials is String? ? credentials : this.credentials,
      avatar: avatar ?? this.avatar,
      title: title ?? this.title,
      description: description ?? this.description,
      memberLimit: memberLimit ?? this.memberLimit,
    );
  }
}

class SpaceTable extends _i1.Table<int?> {
  SpaceTable({super.tableRelation}) : super(tableName: 'space') {
    ownerId = _i1.ColumnInt(
      'ownerId',
      this,
    );
    credentials = _i1.ColumnString(
      'credentials',
      this,
    );
    avatar = _i1.ColumnString(
      'avatar',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    memberLimit = _i1.ColumnInt(
      'memberLimit',
      this,
    );
  }

  late final _i1.ColumnInt ownerId;

  late final _i1.ColumnString credentials;

  late final _i1.ColumnString avatar;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt memberLimit;

  @override
  List<_i1.Column> get columns => [
        id,
        ownerId,
        credentials,
        avatar,
        title,
        description,
        memberLimit,
      ];
}

class SpaceInclude extends _i1.IncludeObject {
  SpaceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Space.t;
}

class SpaceIncludeList extends _i1.IncludeList {
  SpaceIncludeList._({
    _i1.WhereExpressionBuilder<SpaceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Space.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Space.t;
}

class SpaceRepository {
  const SpaceRepository._();

  /// Returns a list of [Space]s matching the given query parameters.
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
  Future<List<Space>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpaceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpaceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Space>(
      where: where?.call(Space.t),
      orderBy: orderBy?.call(Space.t),
      orderByList: orderByList?.call(Space.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Space] matching the given query parameters.
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
  Future<Space?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpaceTable>? where,
    int? offset,
    _i1.OrderByBuilder<SpaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpaceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Space>(
      where: where?.call(Space.t),
      orderBy: orderBy?.call(Space.t),
      orderByList: orderByList?.call(Space.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Space] by its [id] or null if no such row exists.
  Future<Space?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Space>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Space]s in the list and returns the inserted rows.
  ///
  /// The returned [Space]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Space>> insert(
    _i1.Session session,
    List<Space> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Space>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Space] and returns the inserted row.
  ///
  /// The returned [Space] will have its `id` field set.
  Future<Space> insertRow(
    _i1.Session session,
    Space row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Space>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Space]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Space>> update(
    _i1.Session session,
    List<Space> rows, {
    _i1.ColumnSelections<SpaceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Space>(
      rows,
      columns: columns?.call(Space.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Space]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Space> updateRow(
    _i1.Session session,
    Space row, {
    _i1.ColumnSelections<SpaceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Space>(
      row,
      columns: columns?.call(Space.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Space]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Space>> delete(
    _i1.Session session,
    List<Space> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Space>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Space].
  Future<Space> deleteRow(
    _i1.Session session,
    Space row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Space>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Space>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpaceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Space>(
      where: where(Space.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpaceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Space>(
      where: where?.call(Space.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
