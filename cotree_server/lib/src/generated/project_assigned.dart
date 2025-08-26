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

abstract class ProjectAssigned
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProjectAssigned._({
    this.id,
    required this.projectId,
    required this.teamId,
  });

  factory ProjectAssigned({
    int? id,
    required int projectId,
    required int teamId,
  }) = _ProjectAssignedImpl;

  factory ProjectAssigned.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectAssigned(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      teamId: jsonSerialization['teamId'] as int,
    );
  }

  static final t = ProjectAssignedTable();

  static const db = ProjectAssignedRepository._();

  @override
  int? id;

  int projectId;

  int teamId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProjectAssigned]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProjectAssigned copyWith({
    int? id,
    int? projectId,
    int? teamId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'projectId': projectId,
      'teamId': teamId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'projectId': projectId,
      'teamId': teamId,
    };
  }

  static ProjectAssignedInclude include() {
    return ProjectAssignedInclude._();
  }

  static ProjectAssignedIncludeList includeList({
    _i1.WhereExpressionBuilder<ProjectAssignedTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProjectAssignedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProjectAssignedTable>? orderByList,
    ProjectAssignedInclude? include,
  }) {
    return ProjectAssignedIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProjectAssigned.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProjectAssigned.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectAssignedImpl extends ProjectAssigned {
  _ProjectAssignedImpl({
    int? id,
    required int projectId,
    required int teamId,
  }) : super._(
          id: id,
          projectId: projectId,
          teamId: teamId,
        );

  /// Returns a shallow copy of this [ProjectAssigned]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProjectAssigned copyWith({
    Object? id = _Undefined,
    int? projectId,
    int? teamId,
  }) {
    return ProjectAssigned(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      teamId: teamId ?? this.teamId,
    );
  }
}

class ProjectAssignedTable extends _i1.Table<int?> {
  ProjectAssignedTable({super.tableRelation})
      : super(tableName: 'project_assigned') {
    projectId = _i1.ColumnInt(
      'projectId',
      this,
    );
    teamId = _i1.ColumnInt(
      'teamId',
      this,
    );
  }

  late final _i1.ColumnInt projectId;

  late final _i1.ColumnInt teamId;

  @override
  List<_i1.Column> get columns => [
        id,
        projectId,
        teamId,
      ];
}

class ProjectAssignedInclude extends _i1.IncludeObject {
  ProjectAssignedInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProjectAssigned.t;
}

class ProjectAssignedIncludeList extends _i1.IncludeList {
  ProjectAssignedIncludeList._({
    _i1.WhereExpressionBuilder<ProjectAssignedTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProjectAssigned.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProjectAssigned.t;
}

class ProjectAssignedRepository {
  const ProjectAssignedRepository._();

  /// Returns a list of [ProjectAssigned]s matching the given query parameters.
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
  Future<List<ProjectAssigned>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProjectAssignedTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProjectAssignedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProjectAssignedTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ProjectAssigned>(
      where: where?.call(ProjectAssigned.t),
      orderBy: orderBy?.call(ProjectAssigned.t),
      orderByList: orderByList?.call(ProjectAssigned.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ProjectAssigned] matching the given query parameters.
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
  Future<ProjectAssigned?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProjectAssignedTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProjectAssignedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProjectAssignedTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ProjectAssigned>(
      where: where?.call(ProjectAssigned.t),
      orderBy: orderBy?.call(ProjectAssigned.t),
      orderByList: orderByList?.call(ProjectAssigned.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ProjectAssigned] by its [id] or null if no such row exists.
  Future<ProjectAssigned?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ProjectAssigned>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ProjectAssigned]s in the list and returns the inserted rows.
  ///
  /// The returned [ProjectAssigned]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ProjectAssigned>> insert(
    _i1.Session session,
    List<ProjectAssigned> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ProjectAssigned>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ProjectAssigned] and returns the inserted row.
  ///
  /// The returned [ProjectAssigned] will have its `id` field set.
  Future<ProjectAssigned> insertRow(
    _i1.Session session,
    ProjectAssigned row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProjectAssigned>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProjectAssigned]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProjectAssigned>> update(
    _i1.Session session,
    List<ProjectAssigned> rows, {
    _i1.ColumnSelections<ProjectAssignedTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProjectAssigned>(
      rows,
      columns: columns?.call(ProjectAssigned.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProjectAssigned]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProjectAssigned> updateRow(
    _i1.Session session,
    ProjectAssigned row, {
    _i1.ColumnSelections<ProjectAssignedTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProjectAssigned>(
      row,
      columns: columns?.call(ProjectAssigned.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ProjectAssigned]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProjectAssigned>> delete(
    _i1.Session session,
    List<ProjectAssigned> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProjectAssigned>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProjectAssigned].
  Future<ProjectAssigned> deleteRow(
    _i1.Session session,
    ProjectAssigned row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProjectAssigned>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProjectAssigned>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ProjectAssignedTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProjectAssigned>(
      where: where(ProjectAssigned.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProjectAssignedTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProjectAssigned>(
      where: where?.call(ProjectAssigned.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
