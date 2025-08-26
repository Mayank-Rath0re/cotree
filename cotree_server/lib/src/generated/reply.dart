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

abstract class Reply implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Reply._({
    this.id,
    required this.author,
    required this.text,
    required this.react,
  }) : _commentRepliesCommentId = null;

  factory Reply({
    int? id,
    required int author,
    required String text,
    required int react,
  }) = _ReplyImpl;

  factory Reply.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReplyImplicit._(
      id: jsonSerialization['id'] as int?,
      author: jsonSerialization['author'] as int,
      text: jsonSerialization['text'] as String,
      react: jsonSerialization['react'] as int,
      $_commentRepliesCommentId:
          jsonSerialization['_commentRepliesCommentId'] as int?,
    );
  }

  static final t = ReplyTable();

  static const db = ReplyRepository._();

  @override
  int? id;

  int author;

  String text;

  int react;

  final int? _commentRepliesCommentId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Reply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Reply copyWith({
    int? id,
    int? author,
    String? text,
    int? react,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'author': author,
      'text': text,
      'react': react,
      if (_commentRepliesCommentId != null)
        '_commentRepliesCommentId': _commentRepliesCommentId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'author': author,
      'text': text,
      'react': react,
    };
  }

  static ReplyInclude include() {
    return ReplyInclude._();
  }

  static ReplyIncludeList includeList({
    _i1.WhereExpressionBuilder<ReplyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReplyTable>? orderByList,
    ReplyInclude? include,
  }) {
    return ReplyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reply.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Reply.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReplyImpl extends Reply {
  _ReplyImpl({
    int? id,
    required int author,
    required String text,
    required int react,
  }) : super._(
          id: id,
          author: author,
          text: text,
          react: react,
        );

  /// Returns a shallow copy of this [Reply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Reply copyWith({
    Object? id = _Undefined,
    int? author,
    String? text,
    int? react,
  }) {
    return ReplyImplicit._(
      id: id is int? ? id : this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      react: react ?? this.react,
      $_commentRepliesCommentId: this._commentRepliesCommentId,
    );
  }
}

class ReplyImplicit extends _ReplyImpl {
  ReplyImplicit._({
    int? id,
    required int author,
    required String text,
    required int react,
    int? $_commentRepliesCommentId,
  })  : _commentRepliesCommentId = $_commentRepliesCommentId,
        super(
          id: id,
          author: author,
          text: text,
          react: react,
        );

  factory ReplyImplicit(
    Reply reply, {
    int? $_commentRepliesCommentId,
  }) {
    return ReplyImplicit._(
      id: reply.id,
      author: reply.author,
      text: reply.text,
      react: reply.react,
      $_commentRepliesCommentId: $_commentRepliesCommentId,
    );
  }

  @override
  final int? _commentRepliesCommentId;
}

class ReplyTable extends _i1.Table<int?> {
  ReplyTable({super.tableRelation}) : super(tableName: 'reply') {
    author = _i1.ColumnInt(
      'author',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    react = _i1.ColumnInt(
      'react',
      this,
    );
    $_commentRepliesCommentId = _i1.ColumnInt(
      '_commentRepliesCommentId',
      this,
    );
  }

  late final _i1.ColumnInt author;

  late final _i1.ColumnString text;

  late final _i1.ColumnInt react;

  late final _i1.ColumnInt $_commentRepliesCommentId;

  @override
  List<_i1.Column> get columns => [
        id,
        author,
        text,
        react,
        $_commentRepliesCommentId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        author,
        text,
        react,
      ];
}

class ReplyInclude extends _i1.IncludeObject {
  ReplyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Reply.t;
}

class ReplyIncludeList extends _i1.IncludeList {
  ReplyIncludeList._({
    _i1.WhereExpressionBuilder<ReplyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Reply.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Reply.t;
}

class ReplyRepository {
  const ReplyRepository._();

  /// Returns a list of [Reply]s matching the given query parameters.
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
  Future<List<Reply>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReplyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReplyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Reply>(
      where: where?.call(Reply.t),
      orderBy: orderBy?.call(Reply.t),
      orderByList: orderByList?.call(Reply.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Reply] matching the given query parameters.
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
  Future<Reply?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReplyTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReplyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Reply>(
      where: where?.call(Reply.t),
      orderBy: orderBy?.call(Reply.t),
      orderByList: orderByList?.call(Reply.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Reply] by its [id] or null if no such row exists.
  Future<Reply?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Reply>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Reply]s in the list and returns the inserted rows.
  ///
  /// The returned [Reply]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Reply>> insert(
    _i1.Session session,
    List<Reply> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Reply>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Reply] and returns the inserted row.
  ///
  /// The returned [Reply] will have its `id` field set.
  Future<Reply> insertRow(
    _i1.Session session,
    Reply row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Reply>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Reply]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Reply>> update(
    _i1.Session session,
    List<Reply> rows, {
    _i1.ColumnSelections<ReplyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Reply>(
      rows,
      columns: columns?.call(Reply.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Reply]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Reply> updateRow(
    _i1.Session session,
    Reply row, {
    _i1.ColumnSelections<ReplyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Reply>(
      row,
      columns: columns?.call(Reply.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Reply]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Reply>> delete(
    _i1.Session session,
    List<Reply> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Reply>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Reply].
  Future<Reply> deleteRow(
    _i1.Session session,
    Reply row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Reply>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Reply>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReplyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Reply>(
      where: where(Reply.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReplyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Reply>(
      where: where?.call(Reply.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
