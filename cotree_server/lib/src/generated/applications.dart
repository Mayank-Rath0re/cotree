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

abstract class Applications
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Applications._({
    this.id,
    required this.individualId,
    required this.offerId,
    required this.shortDescription,
    required this.qualifyIndices,
    required this.status,
  });

  factory Applications({
    int? id,
    required int individualId,
    required int offerId,
    required String shortDescription,
    required List<int> qualifyIndices,
    required String status,
  }) = _ApplicationsImpl;

  factory Applications.fromJson(Map<String, dynamic> jsonSerialization) {
    return Applications(
      id: jsonSerialization['id'] as int?,
      individualId: jsonSerialization['individualId'] as int,
      offerId: jsonSerialization['offerId'] as int,
      shortDescription: jsonSerialization['shortDescription'] as String,
      qualifyIndices: (jsonSerialization['qualifyIndices'] as List)
          .map((e) => e as int)
          .toList(),
      status: jsonSerialization['status'] as String,
    );
  }

  static final t = ApplicationsTable();

  static const db = ApplicationsRepository._();

  @override
  int? id;

  int individualId;

  int offerId;

  String shortDescription;

  List<int> qualifyIndices;

  String status;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Applications]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Applications copyWith({
    int? id,
    int? individualId,
    int? offerId,
    String? shortDescription,
    List<int>? qualifyIndices,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'individualId': individualId,
      'offerId': offerId,
      'shortDescription': shortDescription,
      'qualifyIndices': qualifyIndices.toJson(),
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'individualId': individualId,
      'offerId': offerId,
      'shortDescription': shortDescription,
      'qualifyIndices': qualifyIndices.toJson(),
      'status': status,
    };
  }

  static ApplicationsInclude include() {
    return ApplicationsInclude._();
  }

  static ApplicationsIncludeList includeList({
    _i1.WhereExpressionBuilder<ApplicationsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ApplicationsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApplicationsTable>? orderByList,
    ApplicationsInclude? include,
  }) {
    return ApplicationsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Applications.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Applications.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ApplicationsImpl extends Applications {
  _ApplicationsImpl({
    int? id,
    required int individualId,
    required int offerId,
    required String shortDescription,
    required List<int> qualifyIndices,
    required String status,
  }) : super._(
          id: id,
          individualId: individualId,
          offerId: offerId,
          shortDescription: shortDescription,
          qualifyIndices: qualifyIndices,
          status: status,
        );

  /// Returns a shallow copy of this [Applications]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Applications copyWith({
    Object? id = _Undefined,
    int? individualId,
    int? offerId,
    String? shortDescription,
    List<int>? qualifyIndices,
    String? status,
  }) {
    return Applications(
      id: id is int? ? id : this.id,
      individualId: individualId ?? this.individualId,
      offerId: offerId ?? this.offerId,
      shortDescription: shortDescription ?? this.shortDescription,
      qualifyIndices:
          qualifyIndices ?? this.qualifyIndices.map((e0) => e0).toList(),
      status: status ?? this.status,
    );
  }
}

class ApplicationsTable extends _i1.Table<int?> {
  ApplicationsTable({super.tableRelation}) : super(tableName: 'applications') {
    individualId = _i1.ColumnInt(
      'individualId',
      this,
    );
    offerId = _i1.ColumnInt(
      'offerId',
      this,
    );
    shortDescription = _i1.ColumnString(
      'shortDescription',
      this,
    );
    qualifyIndices = _i1.ColumnSerializable(
      'qualifyIndices',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
  }

  late final _i1.ColumnInt individualId;

  late final _i1.ColumnInt offerId;

  late final _i1.ColumnString shortDescription;

  late final _i1.ColumnSerializable qualifyIndices;

  late final _i1.ColumnString status;

  @override
  List<_i1.Column> get columns => [
        id,
        individualId,
        offerId,
        shortDescription,
        qualifyIndices,
        status,
      ];
}

class ApplicationsInclude extends _i1.IncludeObject {
  ApplicationsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Applications.t;
}

class ApplicationsIncludeList extends _i1.IncludeList {
  ApplicationsIncludeList._({
    _i1.WhereExpressionBuilder<ApplicationsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Applications.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Applications.t;
}

class ApplicationsRepository {
  const ApplicationsRepository._();

  /// Returns a list of [Applications]s matching the given query parameters.
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
  Future<List<Applications>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ApplicationsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ApplicationsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApplicationsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Applications>(
      where: where?.call(Applications.t),
      orderBy: orderBy?.call(Applications.t),
      orderByList: orderByList?.call(Applications.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Applications] matching the given query parameters.
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
  Future<Applications?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ApplicationsTable>? where,
    int? offset,
    _i1.OrderByBuilder<ApplicationsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApplicationsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Applications>(
      where: where?.call(Applications.t),
      orderBy: orderBy?.call(Applications.t),
      orderByList: orderByList?.call(Applications.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Applications] by its [id] or null if no such row exists.
  Future<Applications?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Applications>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Applications]s in the list and returns the inserted rows.
  ///
  /// The returned [Applications]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Applications>> insert(
    _i1.Session session,
    List<Applications> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Applications>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Applications] and returns the inserted row.
  ///
  /// The returned [Applications] will have its `id` field set.
  Future<Applications> insertRow(
    _i1.Session session,
    Applications row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Applications>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Applications]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Applications>> update(
    _i1.Session session,
    List<Applications> rows, {
    _i1.ColumnSelections<ApplicationsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Applications>(
      rows,
      columns: columns?.call(Applications.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Applications]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Applications> updateRow(
    _i1.Session session,
    Applications row, {
    _i1.ColumnSelections<ApplicationsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Applications>(
      row,
      columns: columns?.call(Applications.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Applications]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Applications>> delete(
    _i1.Session session,
    List<Applications> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Applications>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Applications].
  Future<Applications> deleteRow(
    _i1.Session session,
    Applications row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Applications>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Applications>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ApplicationsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Applications>(
      where: where(Applications.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ApplicationsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Applications>(
      where: where?.call(Applications.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
