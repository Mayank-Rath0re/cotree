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

abstract class Offers implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Offers._({
    this.id,
    required this.author,
    required this.authorName,
    required this.title,
    required this.acceptingApplications,
    required this.isActive,
    required this.pay,
    required this.offerType,
    required this.location,
    required this.description,
    required this.duration,
    required this.qualifications,
  });

  factory Offers({
    int? id,
    required int author,
    required String authorName,
    required String title,
    required bool acceptingApplications,
    required bool isActive,
    required String pay,
    required String offerType,
    required String location,
    required String description,
    required int duration,
    required List<String> qualifications,
  }) = _OffersImpl;

  factory Offers.fromJson(Map<String, dynamic> jsonSerialization) {
    return Offers(
      id: jsonSerialization['id'] as int?,
      author: jsonSerialization['author'] as int,
      authorName: jsonSerialization['authorName'] as String,
      title: jsonSerialization['title'] as String,
      acceptingApplications: jsonSerialization['acceptingApplications'] as bool,
      isActive: jsonSerialization['isActive'] as bool,
      pay: jsonSerialization['pay'] as String,
      offerType: jsonSerialization['offerType'] as String,
      location: jsonSerialization['location'] as String,
      description: jsonSerialization['description'] as String,
      duration: jsonSerialization['duration'] as int,
      qualifications: (jsonSerialization['qualifications'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  static final t = OffersTable();

  static const db = OffersRepository._();

  @override
  int? id;

  int author;

  String authorName;

  String title;

  bool acceptingApplications;

  bool isActive;

  String pay;

  String offerType;

  String location;

  String description;

  int duration;

  List<String> qualifications;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Offers]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Offers copyWith({
    int? id,
    int? author,
    String? authorName,
    String? title,
    bool? acceptingApplications,
    bool? isActive,
    String? pay,
    String? offerType,
    String? location,
    String? description,
    int? duration,
    List<String>? qualifications,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'author': author,
      'authorName': authorName,
      'title': title,
      'acceptingApplications': acceptingApplications,
      'isActive': isActive,
      'pay': pay,
      'offerType': offerType,
      'location': location,
      'description': description,
      'duration': duration,
      'qualifications': qualifications.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'author': author,
      'authorName': authorName,
      'title': title,
      'acceptingApplications': acceptingApplications,
      'isActive': isActive,
      'pay': pay,
      'offerType': offerType,
      'location': location,
      'description': description,
      'duration': duration,
      'qualifications': qualifications.toJson(),
    };
  }

  static OffersInclude include() {
    return OffersInclude._();
  }

  static OffersIncludeList includeList({
    _i1.WhereExpressionBuilder<OffersTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OffersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OffersTable>? orderByList,
    OffersInclude? include,
  }) {
    return OffersIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Offers.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Offers.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OffersImpl extends Offers {
  _OffersImpl({
    int? id,
    required int author,
    required String authorName,
    required String title,
    required bool acceptingApplications,
    required bool isActive,
    required String pay,
    required String offerType,
    required String location,
    required String description,
    required int duration,
    required List<String> qualifications,
  }) : super._(
          id: id,
          author: author,
          authorName: authorName,
          title: title,
          acceptingApplications: acceptingApplications,
          isActive: isActive,
          pay: pay,
          offerType: offerType,
          location: location,
          description: description,
          duration: duration,
          qualifications: qualifications,
        );

  /// Returns a shallow copy of this [Offers]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Offers copyWith({
    Object? id = _Undefined,
    int? author,
    String? authorName,
    String? title,
    bool? acceptingApplications,
    bool? isActive,
    String? pay,
    String? offerType,
    String? location,
    String? description,
    int? duration,
    List<String>? qualifications,
  }) {
    return Offers(
      id: id is int? ? id : this.id,
      author: author ?? this.author,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      acceptingApplications:
          acceptingApplications ?? this.acceptingApplications,
      isActive: isActive ?? this.isActive,
      pay: pay ?? this.pay,
      offerType: offerType ?? this.offerType,
      location: location ?? this.location,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      qualifications:
          qualifications ?? this.qualifications.map((e0) => e0).toList(),
    );
  }
}

class OffersTable extends _i1.Table<int?> {
  OffersTable({super.tableRelation}) : super(tableName: 'offers') {
    author = _i1.ColumnInt(
      'author',
      this,
    );
    authorName = _i1.ColumnString(
      'authorName',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    acceptingApplications = _i1.ColumnBool(
      'acceptingApplications',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    pay = _i1.ColumnString(
      'pay',
      this,
    );
    offerType = _i1.ColumnString(
      'offerType',
      this,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    duration = _i1.ColumnInt(
      'duration',
      this,
    );
    qualifications = _i1.ColumnSerializable(
      'qualifications',
      this,
    );
  }

  late final _i1.ColumnInt author;

  late final _i1.ColumnString authorName;

  late final _i1.ColumnString title;

  late final _i1.ColumnBool acceptingApplications;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnString pay;

  late final _i1.ColumnString offerType;

  late final _i1.ColumnString location;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt duration;

  late final _i1.ColumnSerializable qualifications;

  @override
  List<_i1.Column> get columns => [
        id,
        author,
        authorName,
        title,
        acceptingApplications,
        isActive,
        pay,
        offerType,
        location,
        description,
        duration,
        qualifications,
      ];
}

class OffersInclude extends _i1.IncludeObject {
  OffersInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Offers.t;
}

class OffersIncludeList extends _i1.IncludeList {
  OffersIncludeList._({
    _i1.WhereExpressionBuilder<OffersTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Offers.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Offers.t;
}

class OffersRepository {
  const OffersRepository._();

  /// Returns a list of [Offers]s matching the given query parameters.
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
  Future<List<Offers>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OffersTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OffersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OffersTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Offers>(
      where: where?.call(Offers.t),
      orderBy: orderBy?.call(Offers.t),
      orderByList: orderByList?.call(Offers.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Offers] matching the given query parameters.
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
  Future<Offers?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OffersTable>? where,
    int? offset,
    _i1.OrderByBuilder<OffersTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OffersTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Offers>(
      where: where?.call(Offers.t),
      orderBy: orderBy?.call(Offers.t),
      orderByList: orderByList?.call(Offers.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Offers] by its [id] or null if no such row exists.
  Future<Offers?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Offers>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Offers]s in the list and returns the inserted rows.
  ///
  /// The returned [Offers]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Offers>> insert(
    _i1.Session session,
    List<Offers> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Offers>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Offers] and returns the inserted row.
  ///
  /// The returned [Offers] will have its `id` field set.
  Future<Offers> insertRow(
    _i1.Session session,
    Offers row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Offers>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Offers]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Offers>> update(
    _i1.Session session,
    List<Offers> rows, {
    _i1.ColumnSelections<OffersTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Offers>(
      rows,
      columns: columns?.call(Offers.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Offers]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Offers> updateRow(
    _i1.Session session,
    Offers row, {
    _i1.ColumnSelections<OffersTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Offers>(
      row,
      columns: columns?.call(Offers.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Offers]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Offers>> delete(
    _i1.Session session,
    List<Offers> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Offers>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Offers].
  Future<Offers> deleteRow(
    _i1.Session session,
    Offers row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Offers>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Offers>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OffersTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Offers>(
      where: where(Offers.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OffersTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Offers>(
      where: where?.call(Offers.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
