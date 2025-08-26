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

abstract class TeamMember
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TeamMember._({
    this.id,
    required this.teamId,
    required this.memberId,
    required this.role,
  });

  factory TeamMember({
    int? id,
    required int teamId,
    required int memberId,
    required String role,
  }) = _TeamMemberImpl;

  factory TeamMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return TeamMember(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      memberId: jsonSerialization['memberId'] as int,
      role: jsonSerialization['role'] as String,
    );
  }

  static final t = TeamMemberTable();

  static const db = TeamMemberRepository._();

  @override
  int? id;

  int teamId;

  int memberId;

  String role;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TeamMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeamMember copyWith({
    int? id,
    int? teamId,
    int? memberId,
    String? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'teamId': teamId,
      'memberId': memberId,
      'role': role,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'teamId': teamId,
      'memberId': memberId,
      'role': role,
    };
  }

  static TeamMemberInclude include() {
    return TeamMemberInclude._();
  }

  static TeamMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<TeamMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamMemberTable>? orderByList,
    TeamMemberInclude? include,
  }) {
    return TeamMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TeamMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TeamMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TeamMemberImpl extends TeamMember {
  _TeamMemberImpl({
    int? id,
    required int teamId,
    required int memberId,
    required String role,
  }) : super._(
          id: id,
          teamId: teamId,
          memberId: memberId,
          role: role,
        );

  /// Returns a shallow copy of this [TeamMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeamMember copyWith({
    Object? id = _Undefined,
    int? teamId,
    int? memberId,
    String? role,
  }) {
    return TeamMember(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      memberId: memberId ?? this.memberId,
      role: role ?? this.role,
    );
  }
}

class TeamMemberTable extends _i1.Table<int?> {
  TeamMemberTable({super.tableRelation}) : super(tableName: 'team_member') {
    teamId = _i1.ColumnInt(
      'teamId',
      this,
    );
    memberId = _i1.ColumnInt(
      'memberId',
      this,
    );
    role = _i1.ColumnString(
      'role',
      this,
    );
  }

  late final _i1.ColumnInt teamId;

  late final _i1.ColumnInt memberId;

  late final _i1.ColumnString role;

  @override
  List<_i1.Column> get columns => [
        id,
        teamId,
        memberId,
        role,
      ];
}

class TeamMemberInclude extends _i1.IncludeObject {
  TeamMemberInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => TeamMember.t;
}

class TeamMemberIncludeList extends _i1.IncludeList {
  TeamMemberIncludeList._({
    _i1.WhereExpressionBuilder<TeamMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TeamMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TeamMember.t;
}

class TeamMemberRepository {
  const TeamMemberRepository._();

  /// Returns a list of [TeamMember]s matching the given query parameters.
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
  Future<List<TeamMember>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TeamMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamMemberTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<TeamMember>(
      where: where?.call(TeamMember.t),
      orderBy: orderBy?.call(TeamMember.t),
      orderByList: orderByList?.call(TeamMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [TeamMember] matching the given query parameters.
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
  Future<TeamMember?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TeamMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<TeamMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamMemberTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<TeamMember>(
      where: where?.call(TeamMember.t),
      orderBy: orderBy?.call(TeamMember.t),
      orderByList: orderByList?.call(TeamMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [TeamMember] by its [id] or null if no such row exists.
  Future<TeamMember?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<TeamMember>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [TeamMember]s in the list and returns the inserted rows.
  ///
  /// The returned [TeamMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TeamMember>> insert(
    _i1.Session session,
    List<TeamMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TeamMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TeamMember] and returns the inserted row.
  ///
  /// The returned [TeamMember] will have its `id` field set.
  Future<TeamMember> insertRow(
    _i1.Session session,
    TeamMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TeamMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TeamMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TeamMember>> update(
    _i1.Session session,
    List<TeamMember> rows, {
    _i1.ColumnSelections<TeamMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TeamMember>(
      rows,
      columns: columns?.call(TeamMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TeamMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TeamMember> updateRow(
    _i1.Session session,
    TeamMember row, {
    _i1.ColumnSelections<TeamMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TeamMember>(
      row,
      columns: columns?.call(TeamMember.t),
      transaction: transaction,
    );
  }

  /// Deletes all [TeamMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TeamMember>> delete(
    _i1.Session session,
    List<TeamMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TeamMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TeamMember].
  Future<TeamMember> deleteRow(
    _i1.Session session,
    TeamMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TeamMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TeamMember>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TeamMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TeamMember>(
      where: where(TeamMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TeamMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TeamMember>(
      where: where?.call(TeamMember.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
