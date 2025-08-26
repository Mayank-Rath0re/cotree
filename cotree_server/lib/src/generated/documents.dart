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

abstract class Documents
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Documents._({
    this.id,
    required this.projectId,
    required this.title,
    required this.url,
    required this.uploadedBy,
    required this.uploadedAt,
  });

  factory Documents({
    int? id,
    required int projectId,
    required String title,
    required String url,
    required int uploadedBy,
    required DateTime uploadedAt,
  }) = _DocumentsImpl;

  factory Documents.fromJson(Map<String, dynamic> jsonSerialization) {
    return Documents(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      title: jsonSerialization['title'] as String,
      url: jsonSerialization['url'] as String,
      uploadedBy: jsonSerialization['uploadedBy'] as int,
      uploadedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['uploadedAt']),
    );
  }

  static final t = DocumentsTable();

  static const db = DocumentsRepository._();

  @override
  int? id;

  int projectId;

  String title;

  String url;

  int uploadedBy;

  DateTime uploadedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Documents]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Documents copyWith({
    int? id,
    int? projectId,
    String? title,
    String? url,
    int? uploadedBy,
    DateTime? uploadedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'projectId': projectId,
      'title': title,
      'url': url,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'projectId': projectId,
      'title': title,
      'url': url,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt.toJson(),
    };
  }

  static DocumentsInclude include() {
    return DocumentsInclude._();
  }

  static DocumentsIncludeList includeList({
    _i1.WhereExpressionBuilder<DocumentsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentsTable>? orderByList,
    DocumentsInclude? include,
  }) {
    return DocumentsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Documents.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Documents.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentsImpl extends Documents {
  _DocumentsImpl({
    int? id,
    required int projectId,
    required String title,
    required String url,
    required int uploadedBy,
    required DateTime uploadedAt,
  }) : super._(
          id: id,
          projectId: projectId,
          title: title,
          url: url,
          uploadedBy: uploadedBy,
          uploadedAt: uploadedAt,
        );

  /// Returns a shallow copy of this [Documents]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Documents copyWith({
    Object? id = _Undefined,
    int? projectId,
    String? title,
    String? url,
    int? uploadedBy,
    DateTime? uploadedAt,
  }) {
    return Documents(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      url: url ?? this.url,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}

class DocumentsTable extends _i1.Table<int?> {
  DocumentsTable({super.tableRelation}) : super(tableName: 'documents') {
    projectId = _i1.ColumnInt(
      'projectId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    url = _i1.ColumnString(
      'url',
      this,
    );
    uploadedBy = _i1.ColumnInt(
      'uploadedBy',
      this,
    );
    uploadedAt = _i1.ColumnDateTime(
      'uploadedAt',
      this,
    );
  }

  late final _i1.ColumnInt projectId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString url;

  late final _i1.ColumnInt uploadedBy;

  late final _i1.ColumnDateTime uploadedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        projectId,
        title,
        url,
        uploadedBy,
        uploadedAt,
      ];
}

class DocumentsInclude extends _i1.IncludeObject {
  DocumentsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Documents.t;
}

class DocumentsIncludeList extends _i1.IncludeList {
  DocumentsIncludeList._({
    _i1.WhereExpressionBuilder<DocumentsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Documents.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Documents.t;
}

class DocumentsRepository {
  const DocumentsRepository._();

  /// Returns a list of [Documents]s matching the given query parameters.
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
  Future<List<Documents>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Documents>(
      where: where?.call(Documents.t),
      orderBy: orderBy?.call(Documents.t),
      orderByList: orderByList?.call(Documents.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Documents] matching the given query parameters.
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
  Future<Documents?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentsTable>? where,
    int? offset,
    _i1.OrderByBuilder<DocumentsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Documents>(
      where: where?.call(Documents.t),
      orderBy: orderBy?.call(Documents.t),
      orderByList: orderByList?.call(Documents.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Documents] by its [id] or null if no such row exists.
  Future<Documents?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Documents>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Documents]s in the list and returns the inserted rows.
  ///
  /// The returned [Documents]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Documents>> insert(
    _i1.Session session,
    List<Documents> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Documents>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Documents] and returns the inserted row.
  ///
  /// The returned [Documents] will have its `id` field set.
  Future<Documents> insertRow(
    _i1.Session session,
    Documents row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Documents>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Documents]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Documents>> update(
    _i1.Session session,
    List<Documents> rows, {
    _i1.ColumnSelections<DocumentsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Documents>(
      rows,
      columns: columns?.call(Documents.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Documents]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Documents> updateRow(
    _i1.Session session,
    Documents row, {
    _i1.ColumnSelections<DocumentsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Documents>(
      row,
      columns: columns?.call(Documents.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Documents]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Documents>> delete(
    _i1.Session session,
    List<Documents> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Documents>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Documents].
  Future<Documents> deleteRow(
    _i1.Session session,
    Documents row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Documents>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Documents>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DocumentsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Documents>(
      where: where(Documents.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocumentsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Documents>(
      where: where?.call(Documents.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
