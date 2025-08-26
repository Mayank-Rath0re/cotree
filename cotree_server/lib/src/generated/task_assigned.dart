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

abstract class TaskAssigned
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TaskAssigned._({
    this.id,
    required this.taskId,
    required this.memberId,
  });

  factory TaskAssigned({
    int? id,
    required int taskId,
    required int memberId,
  }) = _TaskAssignedImpl;

  factory TaskAssigned.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaskAssigned(
      id: jsonSerialization['id'] as int?,
      taskId: jsonSerialization['taskId'] as int,
      memberId: jsonSerialization['memberId'] as int,
    );
  }

  static final t = TaskAssignedTable();

  static const db = TaskAssignedRepository._();

  @override
  int? id;

  int taskId;

  int memberId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TaskAssigned]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TaskAssigned copyWith({
    int? id,
    int? taskId,
    int? memberId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'taskId': taskId,
      'memberId': memberId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'taskId': taskId,
      'memberId': memberId,
    };
  }

  static TaskAssignedInclude include() {
    return TaskAssignedInclude._();
  }

  static TaskAssignedIncludeList includeList({
    _i1.WhereExpressionBuilder<TaskAssignedTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaskAssignedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskAssignedTable>? orderByList,
    TaskAssignedInclude? include,
  }) {
    return TaskAssignedIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TaskAssigned.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TaskAssigned.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskAssignedImpl extends TaskAssigned {
  _TaskAssignedImpl({
    int? id,
    required int taskId,
    required int memberId,
  }) : super._(
          id: id,
          taskId: taskId,
          memberId: memberId,
        );

  /// Returns a shallow copy of this [TaskAssigned]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TaskAssigned copyWith({
    Object? id = _Undefined,
    int? taskId,
    int? memberId,
  }) {
    return TaskAssigned(
      id: id is int? ? id : this.id,
      taskId: taskId ?? this.taskId,
      memberId: memberId ?? this.memberId,
    );
  }
}

class TaskAssignedTable extends _i1.Table<int?> {
  TaskAssignedTable({super.tableRelation}) : super(tableName: 'task_assigned') {
    taskId = _i1.ColumnInt(
      'taskId',
      this,
    );
    memberId = _i1.ColumnInt(
      'memberId',
      this,
    );
  }

  late final _i1.ColumnInt taskId;

  late final _i1.ColumnInt memberId;

  @override
  List<_i1.Column> get columns => [
        id,
        taskId,
        memberId,
      ];
}

class TaskAssignedInclude extends _i1.IncludeObject {
  TaskAssignedInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => TaskAssigned.t;
}

class TaskAssignedIncludeList extends _i1.IncludeList {
  TaskAssignedIncludeList._({
    _i1.WhereExpressionBuilder<TaskAssignedTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TaskAssigned.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TaskAssigned.t;
}

class TaskAssignedRepository {
  const TaskAssignedRepository._();

  /// Returns a list of [TaskAssigned]s matching the given query parameters.
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
  Future<List<TaskAssigned>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskAssignedTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaskAssignedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskAssignedTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<TaskAssigned>(
      where: where?.call(TaskAssigned.t),
      orderBy: orderBy?.call(TaskAssigned.t),
      orderByList: orderByList?.call(TaskAssigned.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [TaskAssigned] matching the given query parameters.
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
  Future<TaskAssigned?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskAssignedTable>? where,
    int? offset,
    _i1.OrderByBuilder<TaskAssignedTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaskAssignedTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<TaskAssigned>(
      where: where?.call(TaskAssigned.t),
      orderBy: orderBy?.call(TaskAssigned.t),
      orderByList: orderByList?.call(TaskAssigned.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [TaskAssigned] by its [id] or null if no such row exists.
  Future<TaskAssigned?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<TaskAssigned>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [TaskAssigned]s in the list and returns the inserted rows.
  ///
  /// The returned [TaskAssigned]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TaskAssigned>> insert(
    _i1.Session session,
    List<TaskAssigned> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TaskAssigned>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TaskAssigned] and returns the inserted row.
  ///
  /// The returned [TaskAssigned] will have its `id` field set.
  Future<TaskAssigned> insertRow(
    _i1.Session session,
    TaskAssigned row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TaskAssigned>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TaskAssigned]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TaskAssigned>> update(
    _i1.Session session,
    List<TaskAssigned> rows, {
    _i1.ColumnSelections<TaskAssignedTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TaskAssigned>(
      rows,
      columns: columns?.call(TaskAssigned.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TaskAssigned]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TaskAssigned> updateRow(
    _i1.Session session,
    TaskAssigned row, {
    _i1.ColumnSelections<TaskAssignedTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TaskAssigned>(
      row,
      columns: columns?.call(TaskAssigned.t),
      transaction: transaction,
    );
  }

  /// Deletes all [TaskAssigned]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TaskAssigned>> delete(
    _i1.Session session,
    List<TaskAssigned> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TaskAssigned>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TaskAssigned].
  Future<TaskAssigned> deleteRow(
    _i1.Session session,
    TaskAssigned row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TaskAssigned>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TaskAssigned>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TaskAssignedTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TaskAssigned>(
      where: where(TaskAssigned.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TaskAssignedTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TaskAssigned>(
      where: where?.call(TaskAssigned.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
