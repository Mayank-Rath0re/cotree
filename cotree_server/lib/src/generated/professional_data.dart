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

abstract class ProfessionalData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProfessionalData._({
    this.id,
    required this.accountId,
    required this.type,
    required this.title,
    required this.institute,
    required this.startDate,
    this.endData,
    required this.supportingLink,
    required this.images,
  });

  factory ProfessionalData({
    int? id,
    required int accountId,
    required String type,
    required String title,
    required String institute,
    required DateTime startDate,
    DateTime? endData,
    required String supportingLink,
    required List<String> images,
  }) = _ProfessionalDataImpl;

  factory ProfessionalData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfessionalData(
      id: jsonSerialization['id'] as int?,
      accountId: jsonSerialization['accountId'] as int,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String,
      institute: jsonSerialization['institute'] as String,
      startDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endData: jsonSerialization['endData'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endData']),
      supportingLink: jsonSerialization['supportingLink'] as String,
      images: (jsonSerialization['images'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  static final t = ProfessionalDataTable();

  static const db = ProfessionalDataRepository._();

  @override
  int? id;

  int accountId;

  String type;

  String title;

  String institute;

  DateTime startDate;

  DateTime? endData;

  String supportingLink;

  List<String> images;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProfessionalData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProfessionalData copyWith({
    int? id,
    int? accountId,
    String? type,
    String? title,
    String? institute,
    DateTime? startDate,
    DateTime? endData,
    String? supportingLink,
    List<String>? images,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'accountId': accountId,
      'type': type,
      'title': title,
      'institute': institute,
      'startDate': startDate.toJson(),
      if (endData != null) 'endData': endData?.toJson(),
      'supportingLink': supportingLink,
      'images': images.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'accountId': accountId,
      'type': type,
      'title': title,
      'institute': institute,
      'startDate': startDate.toJson(),
      if (endData != null) 'endData': endData?.toJson(),
      'supportingLink': supportingLink,
      'images': images.toJson(),
    };
  }

  static ProfessionalDataInclude include() {
    return ProfessionalDataInclude._();
  }

  static ProfessionalDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ProfessionalDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfessionalDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfessionalDataTable>? orderByList,
    ProfessionalDataInclude? include,
  }) {
    return ProfessionalDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProfessionalData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProfessionalData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfessionalDataImpl extends ProfessionalData {
  _ProfessionalDataImpl({
    int? id,
    required int accountId,
    required String type,
    required String title,
    required String institute,
    required DateTime startDate,
    DateTime? endData,
    required String supportingLink,
    required List<String> images,
  }) : super._(
          id: id,
          accountId: accountId,
          type: type,
          title: title,
          institute: institute,
          startDate: startDate,
          endData: endData,
          supportingLink: supportingLink,
          images: images,
        );

  /// Returns a shallow copy of this [ProfessionalData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProfessionalData copyWith({
    Object? id = _Undefined,
    int? accountId,
    String? type,
    String? title,
    String? institute,
    DateTime? startDate,
    Object? endData = _Undefined,
    String? supportingLink,
    List<String>? images,
  }) {
    return ProfessionalData(
      id: id is int? ? id : this.id,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      title: title ?? this.title,
      institute: institute ?? this.institute,
      startDate: startDate ?? this.startDate,
      endData: endData is DateTime? ? endData : this.endData,
      supportingLink: supportingLink ?? this.supportingLink,
      images: images ?? this.images.map((e0) => e0).toList(),
    );
  }
}

class ProfessionalDataTable extends _i1.Table<int?> {
  ProfessionalDataTable({super.tableRelation})
      : super(tableName: 'professional_data') {
    accountId = _i1.ColumnInt(
      'accountId',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    institute = _i1.ColumnString(
      'institute',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endData = _i1.ColumnDateTime(
      'endData',
      this,
    );
    supportingLink = _i1.ColumnString(
      'supportingLink',
      this,
    );
    images = _i1.ColumnSerializable(
      'images',
      this,
    );
  }

  late final _i1.ColumnInt accountId;

  late final _i1.ColumnString type;

  late final _i1.ColumnString title;

  late final _i1.ColumnString institute;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endData;

  late final _i1.ColumnString supportingLink;

  late final _i1.ColumnSerializable images;

  @override
  List<_i1.Column> get columns => [
        id,
        accountId,
        type,
        title,
        institute,
        startDate,
        endData,
        supportingLink,
        images,
      ];
}

class ProfessionalDataInclude extends _i1.IncludeObject {
  ProfessionalDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProfessionalData.t;
}

class ProfessionalDataIncludeList extends _i1.IncludeList {
  ProfessionalDataIncludeList._({
    _i1.WhereExpressionBuilder<ProfessionalDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProfessionalData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProfessionalData.t;
}

class ProfessionalDataRepository {
  const ProfessionalDataRepository._();

  /// Returns a list of [ProfessionalData]s matching the given query parameters.
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
  Future<List<ProfessionalData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfessionalDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProfessionalDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfessionalDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ProfessionalData>(
      where: where?.call(ProfessionalData.t),
      orderBy: orderBy?.call(ProfessionalData.t),
      orderByList: orderByList?.call(ProfessionalData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ProfessionalData] matching the given query parameters.
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
  Future<ProfessionalData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfessionalDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProfessionalDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProfessionalDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ProfessionalData>(
      where: where?.call(ProfessionalData.t),
      orderBy: orderBy?.call(ProfessionalData.t),
      orderByList: orderByList?.call(ProfessionalData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ProfessionalData] by its [id] or null if no such row exists.
  Future<ProfessionalData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ProfessionalData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ProfessionalData]s in the list and returns the inserted rows.
  ///
  /// The returned [ProfessionalData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ProfessionalData>> insert(
    _i1.Session session,
    List<ProfessionalData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ProfessionalData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ProfessionalData] and returns the inserted row.
  ///
  /// The returned [ProfessionalData] will have its `id` field set.
  Future<ProfessionalData> insertRow(
    _i1.Session session,
    ProfessionalData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProfessionalData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProfessionalData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProfessionalData>> update(
    _i1.Session session,
    List<ProfessionalData> rows, {
    _i1.ColumnSelections<ProfessionalDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProfessionalData>(
      rows,
      columns: columns?.call(ProfessionalData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProfessionalData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProfessionalData> updateRow(
    _i1.Session session,
    ProfessionalData row, {
    _i1.ColumnSelections<ProfessionalDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProfessionalData>(
      row,
      columns: columns?.call(ProfessionalData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ProfessionalData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProfessionalData>> delete(
    _i1.Session session,
    List<ProfessionalData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProfessionalData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProfessionalData].
  Future<ProfessionalData> deleteRow(
    _i1.Session session,
    ProfessionalData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProfessionalData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProfessionalData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ProfessionalDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProfessionalData>(
      where: where(ProfessionalData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProfessionalDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProfessionalData>(
      where: where?.call(ProfessionalData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
