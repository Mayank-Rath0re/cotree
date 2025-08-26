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

abstract class Notification
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Notification._({
    this.id,
    required this.forUser,
    required this.content,
    required this.referencedUser,
    required this.triggeredAt,
    required this.unread,
    this.objectId,
    this.objectType,
  });

  factory Notification({
    int? id,
    required int forUser,
    required String content,
    required int referencedUser,
    required DateTime triggeredAt,
    required bool unread,
    int? objectId,
    String? objectType,
  }) = _NotificationImpl;

  factory Notification.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notification(
      id: jsonSerialization['id'] as int?,
      forUser: jsonSerialization['forUser'] as int,
      content: jsonSerialization['content'] as String,
      referencedUser: jsonSerialization['referencedUser'] as int,
      triggeredAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['triggeredAt']),
      unread: jsonSerialization['unread'] as bool,
      objectId: jsonSerialization['objectId'] as int?,
      objectType: jsonSerialization['objectType'] as String?,
    );
  }

  static final t = NotificationTable();

  static const db = NotificationRepository._();

  @override
  int? id;

  int forUser;

  String content;

  int referencedUser;

  DateTime triggeredAt;

  bool unread;

  int? objectId;

  String? objectType;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Notification copyWith({
    int? id,
    int? forUser,
    String? content,
    int? referencedUser,
    DateTime? triggeredAt,
    bool? unread,
    int? objectId,
    String? objectType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'forUser': forUser,
      'content': content,
      'referencedUser': referencedUser,
      'triggeredAt': triggeredAt.toJson(),
      'unread': unread,
      if (objectId != null) 'objectId': objectId,
      if (objectType != null) 'objectType': objectType,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'forUser': forUser,
      'content': content,
      'referencedUser': referencedUser,
      'triggeredAt': triggeredAt.toJson(),
      'unread': unread,
      if (objectId != null) 'objectId': objectId,
      if (objectType != null) 'objectType': objectType,
    };
  }

  static NotificationInclude include() {
    return NotificationInclude._();
  }

  static NotificationIncludeList includeList({
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    NotificationInclude? include,
  }) {
    return NotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Notification.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Notification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationImpl extends Notification {
  _NotificationImpl({
    int? id,
    required int forUser,
    required String content,
    required int referencedUser,
    required DateTime triggeredAt,
    required bool unread,
    int? objectId,
    String? objectType,
  }) : super._(
          id: id,
          forUser: forUser,
          content: content,
          referencedUser: referencedUser,
          triggeredAt: triggeredAt,
          unread: unread,
          objectId: objectId,
          objectType: objectType,
        );

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Notification copyWith({
    Object? id = _Undefined,
    int? forUser,
    String? content,
    int? referencedUser,
    DateTime? triggeredAt,
    bool? unread,
    Object? objectId = _Undefined,
    Object? objectType = _Undefined,
  }) {
    return Notification(
      id: id is int? ? id : this.id,
      forUser: forUser ?? this.forUser,
      content: content ?? this.content,
      referencedUser: referencedUser ?? this.referencedUser,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      unread: unread ?? this.unread,
      objectId: objectId is int? ? objectId : this.objectId,
      objectType: objectType is String? ? objectType : this.objectType,
    );
  }
}

class NotificationTable extends _i1.Table<int?> {
  NotificationTable({super.tableRelation}) : super(tableName: 'notification') {
    forUser = _i1.ColumnInt(
      'forUser',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    referencedUser = _i1.ColumnInt(
      'referencedUser',
      this,
    );
    triggeredAt = _i1.ColumnDateTime(
      'triggeredAt',
      this,
    );
    unread = _i1.ColumnBool(
      'unread',
      this,
    );
    objectId = _i1.ColumnInt(
      'objectId',
      this,
    );
    objectType = _i1.ColumnString(
      'objectType',
      this,
    );
  }

  late final _i1.ColumnInt forUser;

  late final _i1.ColumnString content;

  late final _i1.ColumnInt referencedUser;

  late final _i1.ColumnDateTime triggeredAt;

  late final _i1.ColumnBool unread;

  late final _i1.ColumnInt objectId;

  late final _i1.ColumnString objectType;

  @override
  List<_i1.Column> get columns => [
        id,
        forUser,
        content,
        referencedUser,
        triggeredAt,
        unread,
        objectId,
        objectType,
      ];
}

class NotificationInclude extends _i1.IncludeObject {
  NotificationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Notification.t;
}

class NotificationIncludeList extends _i1.IncludeList {
  NotificationIncludeList._({
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Notification.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Notification.t;
}

class NotificationRepository {
  const NotificationRepository._();

  /// Returns a list of [Notification]s matching the given query parameters.
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
  Future<List<Notification>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Notification>(
      where: where?.call(Notification.t),
      orderBy: orderBy?.call(Notification.t),
      orderByList: orderByList?.call(Notification.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Notification] matching the given query parameters.
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
  Future<Notification?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? offset,
    _i1.OrderByBuilder<NotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<NotificationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Notification>(
      where: where?.call(Notification.t),
      orderBy: orderBy?.call(Notification.t),
      orderByList: orderByList?.call(Notification.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Notification] by its [id] or null if no such row exists.
  Future<Notification?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Notification>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Notification]s in the list and returns the inserted rows.
  ///
  /// The returned [Notification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Notification>> insert(
    _i1.Session session,
    List<Notification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Notification>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Notification] and returns the inserted row.
  ///
  /// The returned [Notification] will have its `id` field set.
  Future<Notification> insertRow(
    _i1.Session session,
    Notification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Notification>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Notification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Notification>> update(
    _i1.Session session,
    List<Notification> rows, {
    _i1.ColumnSelections<NotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Notification>(
      rows,
      columns: columns?.call(Notification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Notification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Notification> updateRow(
    _i1.Session session,
    Notification row, {
    _i1.ColumnSelections<NotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Notification>(
      row,
      columns: columns?.call(Notification.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Notification]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Notification>> delete(
    _i1.Session session,
    List<Notification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Notification>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Notification].
  Future<Notification> deleteRow(
    _i1.Session session,
    Notification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Notification>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Notification>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<NotificationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Notification>(
      where: where(Notification.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<NotificationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Notification>(
      where: where?.call(Notification.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
