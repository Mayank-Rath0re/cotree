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

abstract class CustomDetails
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CustomDetails._({
    this.id,
    required this.title,
    required this.description,
    required this.images,
  });

  factory CustomDetails({
    int? id,
    required String title,
    required String description,
    required List<String> images,
  }) = _CustomDetailsImpl;

  factory CustomDetails.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomDetails(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      images: (jsonSerialization['images'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  static final t = CustomDetailsTable();

  static const db = CustomDetailsRepository._();

  @override
  int? id;

  String title;

  String description;

  List<String> images;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CustomDetails]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CustomDetails copyWith({
    int? id,
    String? title,
    String? description,
    List<String>? images,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'images': images.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'images': images.toJson(),
    };
  }

  static CustomDetailsInclude include() {
    return CustomDetailsInclude._();
  }

  static CustomDetailsIncludeList includeList({
    _i1.WhereExpressionBuilder<CustomDetailsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CustomDetailsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomDetailsTable>? orderByList,
    CustomDetailsInclude? include,
  }) {
    return CustomDetailsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CustomDetails.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CustomDetails.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomDetailsImpl extends CustomDetails {
  _CustomDetailsImpl({
    int? id,
    required String title,
    required String description,
    required List<String> images,
  }) : super._(
          id: id,
          title: title,
          description: description,
          images: images,
        );

  /// Returns a shallow copy of this [CustomDetails]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CustomDetails copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    List<String>? images,
  }) {
    return CustomDetails(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images.map((e0) => e0).toList(),
    );
  }
}

class CustomDetailsTable extends _i1.Table<int?> {
  CustomDetailsTable({super.tableRelation})
      : super(tableName: 'customdetails') {
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    images = _i1.ColumnSerializable(
      'images',
      this,
    );
  }

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable images;

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        description,
        images,
      ];
}

class CustomDetailsInclude extends _i1.IncludeObject {
  CustomDetailsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CustomDetails.t;
}

class CustomDetailsIncludeList extends _i1.IncludeList {
  CustomDetailsIncludeList._({
    _i1.WhereExpressionBuilder<CustomDetailsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CustomDetails.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CustomDetails.t;
}

class CustomDetailsRepository {
  const CustomDetailsRepository._();

  /// Returns a list of [CustomDetails]s matching the given query parameters.
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
  Future<List<CustomDetails>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CustomDetailsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CustomDetailsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomDetailsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CustomDetails>(
      where: where?.call(CustomDetails.t),
      orderBy: orderBy?.call(CustomDetails.t),
      orderByList: orderByList?.call(CustomDetails.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CustomDetails] matching the given query parameters.
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
  Future<CustomDetails?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CustomDetailsTable>? where,
    int? offset,
    _i1.OrderByBuilder<CustomDetailsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomDetailsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CustomDetails>(
      where: where?.call(CustomDetails.t),
      orderBy: orderBy?.call(CustomDetails.t),
      orderByList: orderByList?.call(CustomDetails.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CustomDetails] by its [id] or null if no such row exists.
  Future<CustomDetails?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CustomDetails>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CustomDetails]s in the list and returns the inserted rows.
  ///
  /// The returned [CustomDetails]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CustomDetails>> insert(
    _i1.Session session,
    List<CustomDetails> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CustomDetails>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CustomDetails] and returns the inserted row.
  ///
  /// The returned [CustomDetails] will have its `id` field set.
  Future<CustomDetails> insertRow(
    _i1.Session session,
    CustomDetails row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CustomDetails>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CustomDetails]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CustomDetails>> update(
    _i1.Session session,
    List<CustomDetails> rows, {
    _i1.ColumnSelections<CustomDetailsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CustomDetails>(
      rows,
      columns: columns?.call(CustomDetails.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CustomDetails]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CustomDetails> updateRow(
    _i1.Session session,
    CustomDetails row, {
    _i1.ColumnSelections<CustomDetailsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CustomDetails>(
      row,
      columns: columns?.call(CustomDetails.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CustomDetails]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CustomDetails>> delete(
    _i1.Session session,
    List<CustomDetails> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CustomDetails>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CustomDetails].
  Future<CustomDetails> deleteRow(
    _i1.Session session,
    CustomDetails row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CustomDetails>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CustomDetails>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CustomDetailsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CustomDetails>(
      where: where(CustomDetails.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CustomDetailsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CustomDetails>(
      where: where?.call(CustomDetails.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
