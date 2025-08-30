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

abstract class Invitation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Invitation._({
    this.id,
    required this.sender,
    required this.receiver,
    bool? isRejected,
    this.personalText,
  }) : isRejected = isRejected ?? false;

  factory Invitation({
    int? id,
    required int sender,
    required int receiver,
    bool? isRejected,
    String? personalText,
  }) = _InvitationImpl;

  factory Invitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invitation(
      id: jsonSerialization['id'] as int?,
      sender: jsonSerialization['sender'] as int,
      receiver: jsonSerialization['receiver'] as int,
      isRejected: jsonSerialization['isRejected'] as bool,
      personalText: jsonSerialization['personalText'] as String?,
    );
  }

  static final t = InvitationTable();

  static const db = InvitationRepository._();

  @override
  int? id;

  int sender;

  int receiver;

  bool isRejected;

  String? personalText;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Invitation copyWith({
    int? id,
    int? sender,
    int? receiver,
    bool? isRejected,
    String? personalText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'sender': sender,
      'receiver': receiver,
      'isRejected': isRejected,
      if (personalText != null) 'personalText': personalText,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'sender': sender,
      'receiver': receiver,
      'isRejected': isRejected,
      if (personalText != null) 'personalText': personalText,
    };
  }

  static InvitationInclude include() {
    return InvitationInclude._();
  }

  static InvitationIncludeList includeList({
    _i1.WhereExpressionBuilder<InvitationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InvitationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InvitationTable>? orderByList,
    InvitationInclude? include,
  }) {
    return InvitationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invitation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Invitation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvitationImpl extends Invitation {
  _InvitationImpl({
    int? id,
    required int sender,
    required int receiver,
    bool? isRejected,
    String? personalText,
  }) : super._(
          id: id,
          sender: sender,
          receiver: receiver,
          isRejected: isRejected,
          personalText: personalText,
        );

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Invitation copyWith({
    Object? id = _Undefined,
    int? sender,
    int? receiver,
    bool? isRejected,
    Object? personalText = _Undefined,
  }) {
    return Invitation(
      id: id is int? ? id : this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      isRejected: isRejected ?? this.isRejected,
      personalText: personalText is String? ? personalText : this.personalText,
    );
  }
}

class InvitationTable extends _i1.Table<int?> {
  InvitationTable({super.tableRelation}) : super(tableName: 'invitation') {
    sender = _i1.ColumnInt(
      'sender',
      this,
    );
    receiver = _i1.ColumnInt(
      'receiver',
      this,
    );
    isRejected = _i1.ColumnBool(
      'isRejected',
      this,
      hasDefault: true,
    );
    personalText = _i1.ColumnString(
      'personalText',
      this,
    );
  }

  late final _i1.ColumnInt sender;

  late final _i1.ColumnInt receiver;

  late final _i1.ColumnBool isRejected;

  late final _i1.ColumnString personalText;

  @override
  List<_i1.Column> get columns => [
        id,
        sender,
        receiver,
        isRejected,
        personalText,
      ];
}

class InvitationInclude extends _i1.IncludeObject {
  InvitationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Invitation.t;
}

class InvitationIncludeList extends _i1.IncludeList {
  InvitationIncludeList._({
    _i1.WhereExpressionBuilder<InvitationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Invitation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Invitation.t;
}

class InvitationRepository {
  const InvitationRepository._();

  /// Returns a list of [Invitation]s matching the given query parameters.
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
  Future<List<Invitation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InvitationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InvitationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InvitationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Invitation>(
      where: where?.call(Invitation.t),
      orderBy: orderBy?.call(Invitation.t),
      orderByList: orderByList?.call(Invitation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Invitation] matching the given query parameters.
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
  Future<Invitation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InvitationTable>? where,
    int? offset,
    _i1.OrderByBuilder<InvitationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InvitationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Invitation>(
      where: where?.call(Invitation.t),
      orderBy: orderBy?.call(Invitation.t),
      orderByList: orderByList?.call(Invitation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Invitation] by its [id] or null if no such row exists.
  Future<Invitation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Invitation>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Invitation]s in the list and returns the inserted rows.
  ///
  /// The returned [Invitation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Invitation>> insert(
    _i1.Session session,
    List<Invitation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Invitation>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Invitation] and returns the inserted row.
  ///
  /// The returned [Invitation] will have its `id` field set.
  Future<Invitation> insertRow(
    _i1.Session session,
    Invitation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Invitation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Invitation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Invitation>> update(
    _i1.Session session,
    List<Invitation> rows, {
    _i1.ColumnSelections<InvitationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Invitation>(
      rows,
      columns: columns?.call(Invitation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Invitation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Invitation> updateRow(
    _i1.Session session,
    Invitation row, {
    _i1.ColumnSelections<InvitationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Invitation>(
      row,
      columns: columns?.call(Invitation.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Invitation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Invitation>> delete(
    _i1.Session session,
    List<Invitation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Invitation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Invitation].
  Future<Invitation> deleteRow(
    _i1.Session session,
    Invitation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Invitation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Invitation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InvitationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Invitation>(
      where: where(Invitation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InvitationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Invitation>(
      where: where?.call(Invitation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
