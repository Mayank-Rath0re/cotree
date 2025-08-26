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

abstract class Individual
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Individual._({
    this.id,
    required this.bio,
    required this.accountId,
    required this.gender,
    this.residence,
    this.dob,
    required this.contact,
  });

  factory Individual({
    int? id,
    required String bio,
    required int accountId,
    required String gender,
    String? residence,
    DateTime? dob,
    required String contact,
  }) = _IndividualImpl;

  factory Individual.fromJson(Map<String, dynamic> jsonSerialization) {
    return Individual(
      id: jsonSerialization['id'] as int?,
      bio: jsonSerialization['bio'] as String,
      accountId: jsonSerialization['accountId'] as int,
      gender: jsonSerialization['gender'] as String,
      residence: jsonSerialization['residence'] as String?,
      dob: jsonSerialization['dob'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dob']),
      contact: jsonSerialization['contact'] as String,
    );
  }

  static final t = IndividualTable();

  static const db = IndividualRepository._();

  @override
  int? id;

  String bio;

  int accountId;

  String gender;

  String? residence;

  DateTime? dob;

  String contact;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Individual]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Individual copyWith({
    int? id,
    String? bio,
    int? accountId,
    String? gender,
    String? residence,
    DateTime? dob,
    String? contact,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bio': bio,
      'accountId': accountId,
      'gender': gender,
      if (residence != null) 'residence': residence,
      if (dob != null) 'dob': dob?.toJson(),
      'contact': contact,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'bio': bio,
      'accountId': accountId,
      'gender': gender,
      if (residence != null) 'residence': residence,
      if (dob != null) 'dob': dob?.toJson(),
      'contact': contact,
    };
  }

  static IndividualInclude include() {
    return IndividualInclude._();
  }

  static IndividualIncludeList includeList({
    _i1.WhereExpressionBuilder<IndividualTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IndividualTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IndividualTable>? orderByList,
    IndividualInclude? include,
  }) {
    return IndividualIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Individual.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Individual.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IndividualImpl extends Individual {
  _IndividualImpl({
    int? id,
    required String bio,
    required int accountId,
    required String gender,
    String? residence,
    DateTime? dob,
    required String contact,
  }) : super._(
          id: id,
          bio: bio,
          accountId: accountId,
          gender: gender,
          residence: residence,
          dob: dob,
          contact: contact,
        );

  /// Returns a shallow copy of this [Individual]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Individual copyWith({
    Object? id = _Undefined,
    String? bio,
    int? accountId,
    String? gender,
    Object? residence = _Undefined,
    Object? dob = _Undefined,
    String? contact,
  }) {
    return Individual(
      id: id is int? ? id : this.id,
      bio: bio ?? this.bio,
      accountId: accountId ?? this.accountId,
      gender: gender ?? this.gender,
      residence: residence is String? ? residence : this.residence,
      dob: dob is DateTime? ? dob : this.dob,
      contact: contact ?? this.contact,
    );
  }
}

class IndividualTable extends _i1.Table<int?> {
  IndividualTable({super.tableRelation}) : super(tableName: 'individual') {
    bio = _i1.ColumnString(
      'bio',
      this,
    );
    accountId = _i1.ColumnInt(
      'accountId',
      this,
    );
    gender = _i1.ColumnString(
      'gender',
      this,
    );
    residence = _i1.ColumnString(
      'residence',
      this,
    );
    dob = _i1.ColumnDateTime(
      'dob',
      this,
    );
    contact = _i1.ColumnString(
      'contact',
      this,
    );
  }

  late final _i1.ColumnString bio;

  late final _i1.ColumnInt accountId;

  late final _i1.ColumnString gender;

  late final _i1.ColumnString residence;

  late final _i1.ColumnDateTime dob;

  late final _i1.ColumnString contact;

  @override
  List<_i1.Column> get columns => [
        id,
        bio,
        accountId,
        gender,
        residence,
        dob,
        contact,
      ];
}

class IndividualInclude extends _i1.IncludeObject {
  IndividualInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Individual.t;
}

class IndividualIncludeList extends _i1.IncludeList {
  IndividualIncludeList._({
    _i1.WhereExpressionBuilder<IndividualTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Individual.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Individual.t;
}

class IndividualRepository {
  const IndividualRepository._();

  /// Returns a list of [Individual]s matching the given query parameters.
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
  Future<List<Individual>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IndividualTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IndividualTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IndividualTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Individual>(
      where: where?.call(Individual.t),
      orderBy: orderBy?.call(Individual.t),
      orderByList: orderByList?.call(Individual.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Individual] matching the given query parameters.
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
  Future<Individual?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IndividualTable>? where,
    int? offset,
    _i1.OrderByBuilder<IndividualTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IndividualTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Individual>(
      where: where?.call(Individual.t),
      orderBy: orderBy?.call(Individual.t),
      orderByList: orderByList?.call(Individual.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Individual] by its [id] or null if no such row exists.
  Future<Individual?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Individual>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Individual]s in the list and returns the inserted rows.
  ///
  /// The returned [Individual]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Individual>> insert(
    _i1.Session session,
    List<Individual> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Individual>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Individual] and returns the inserted row.
  ///
  /// The returned [Individual] will have its `id` field set.
  Future<Individual> insertRow(
    _i1.Session session,
    Individual row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Individual>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Individual]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Individual>> update(
    _i1.Session session,
    List<Individual> rows, {
    _i1.ColumnSelections<IndividualTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Individual>(
      rows,
      columns: columns?.call(Individual.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Individual]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Individual> updateRow(
    _i1.Session session,
    Individual row, {
    _i1.ColumnSelections<IndividualTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Individual>(
      row,
      columns: columns?.call(Individual.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Individual]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Individual>> delete(
    _i1.Session session,
    List<Individual> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Individual>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Individual].
  Future<Individual> deleteRow(
    _i1.Session session,
    Individual row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Individual>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Individual>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<IndividualTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Individual>(
      where: where(Individual.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IndividualTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Individual>(
      where: where?.call(Individual.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
