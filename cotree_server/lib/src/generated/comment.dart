/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'reply.dart' as _i2;

abstract class Comment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Comment._({
    this.id,
    required this.responseToPost,
    required this.author,
    required this.text,
    required this.time,
    this.replies,
  });

  factory Comment({
    int? id,
    required int responseToPost,
    required int author,
    required String text,
    required DateTime time,
    List<_i2.Reply>? replies,
  }) = _CommentImpl;

  factory Comment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Comment(
      id: jsonSerialization['id'] as int?,
      responseToPost: jsonSerialization['responseToPost'] as int,
      author: jsonSerialization['author'] as int,
      text: jsonSerialization['text'] as String,
      time: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['time']),
      replies: (jsonSerialization['replies'] as List?)
          ?.map((e) => _i2.Reply.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = CommentTable();

  static const db = CommentRepository._();

  @override
  int? id;

  int responseToPost;

  int author;

  String text;

  DateTime time;

  List<_i2.Reply>? replies;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Comment copyWith({
    int? id,
    int? responseToPost,
    int? author,
    String? text,
    DateTime? time,
    List<_i2.Reply>? replies,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'responseToPost': responseToPost,
      'author': author,
      'text': text,
      'time': time.toJson(),
      if (replies != null)
        'replies': replies?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'responseToPost': responseToPost,
      'author': author,
      'text': text,
      'time': time.toJson(),
      if (replies != null)
        'replies': replies?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static CommentInclude include({_i2.ReplyIncludeList? replies}) {
    return CommentInclude._(replies: replies);
  }

  static CommentIncludeList includeList({
    _i1.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentTable>? orderByList,
    CommentInclude? include,
  }) {
    return CommentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Comment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Comment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentImpl extends Comment {
  _CommentImpl({
    int? id,
    required int responseToPost,
    required int author,
    required String text,
    required DateTime time,
    List<_i2.Reply>? replies,
  }) : super._(
          id: id,
          responseToPost: responseToPost,
          author: author,
          text: text,
          time: time,
          replies: replies,
        );

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Comment copyWith({
    Object? id = _Undefined,
    int? responseToPost,
    int? author,
    String? text,
    DateTime? time,
    Object? replies = _Undefined,
  }) {
    return Comment(
      id: id is int? ? id : this.id,
      responseToPost: responseToPost ?? this.responseToPost,
      author: author ?? this.author,
      text: text ?? this.text,
      time: time ?? this.time,
      replies: replies is List<_i2.Reply>?
          ? replies
          : this.replies?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CommentTable extends _i1.Table<int?> {
  CommentTable({super.tableRelation}) : super(tableName: 'comment') {
    responseToPost = _i1.ColumnInt(
      'responseToPost',
      this,
    );
    author = _i1.ColumnInt(
      'author',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    time = _i1.ColumnDateTime(
      'time',
      this,
    );
  }

  late final _i1.ColumnInt responseToPost;

  late final _i1.ColumnInt author;

  late final _i1.ColumnString text;

  late final _i1.ColumnDateTime time;

  _i2.ReplyTable? ___replies;

  _i1.ManyRelation<_i2.ReplyTable>? _replies;

  _i2.ReplyTable get __replies {
    if (___replies != null) return ___replies!;
    ___replies = _i1.createRelationTable(
      relationFieldName: '__replies',
      field: Comment.t.id,
      foreignField: _i2.Reply.t.$_commentRepliesCommentId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ReplyTable(tableRelation: foreignTableRelation),
    );
    return ___replies!;
  }

  _i1.ManyRelation<_i2.ReplyTable> get replies {
    if (_replies != null) return _replies!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'replies',
      field: Comment.t.id,
      foreignField: _i2.Reply.t.$_commentRepliesCommentId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ReplyTable(tableRelation: foreignTableRelation),
    );
    _replies = _i1.ManyRelation<_i2.ReplyTable>(
      tableWithRelations: relationTable,
      table: _i2.ReplyTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _replies!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        responseToPost,
        author,
        text,
        time,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'replies') {
      return __replies;
    }
    return null;
  }
}

class CommentInclude extends _i1.IncludeObject {
  CommentInclude._({_i2.ReplyIncludeList? replies}) {
    _replies = replies;
  }

  _i2.ReplyIncludeList? _replies;

  @override
  Map<String, _i1.Include?> get includes => {'replies': _replies};

  @override
  _i1.Table<int?> get table => Comment.t;
}

class CommentIncludeList extends _i1.IncludeList {
  CommentIncludeList._({
    _i1.WhereExpressionBuilder<CommentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Comment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Comment.t;
}

class CommentRepository {
  const CommentRepository._();

  final attach = const CommentAttachRepository._();

  final attachRow = const CommentAttachRowRepository._();

  final detach = const CommentDetachRepository._();

  final detachRow = const CommentDetachRowRepository._();

  /// Returns a list of [Comment]s matching the given query parameters.
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
  Future<List<Comment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentTable>? orderByList,
    _i1.Transaction? transaction,
    CommentInclude? include,
  }) async {
    return session.db.find<Comment>(
      where: where?.call(Comment.t),
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Comment] matching the given query parameters.
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
  Future<Comment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommentTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentTable>? orderByList,
    _i1.Transaction? transaction,
    CommentInclude? include,
  }) async {
    return session.db.findFirstRow<Comment>(
      where: where?.call(Comment.t),
      orderBy: orderBy?.call(Comment.t),
      orderByList: orderByList?.call(Comment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Comment] by its [id] or null if no such row exists.
  Future<Comment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CommentInclude? include,
  }) async {
    return session.db.findById<Comment>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Comment]s in the list and returns the inserted rows.
  ///
  /// The returned [Comment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Comment>> insert(
    _i1.Session session,
    List<Comment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Comment>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Comment] and returns the inserted row.
  ///
  /// The returned [Comment] will have its `id` field set.
  Future<Comment> insertRow(
    _i1.Session session,
    Comment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Comment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Comment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Comment>> update(
    _i1.Session session,
    List<Comment> rows, {
    _i1.ColumnSelections<CommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Comment>(
      rows,
      columns: columns?.call(Comment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Comment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Comment> updateRow(
    _i1.Session session,
    Comment row, {
    _i1.ColumnSelections<CommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Comment>(
      row,
      columns: columns?.call(Comment.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Comment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Comment>> delete(
    _i1.Session session,
    List<Comment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Comment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Comment].
  Future<Comment> deleteRow(
    _i1.Session session,
    Comment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Comment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Comment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CommentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Comment>(
      where: where(Comment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Comment>(
      where: where?.call(Comment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CommentAttachRepository {
  const CommentAttachRepository._();

  /// Creates a relation between this [Comment] and the given [Reply]s
  /// by setting each [Reply]'s foreign key `_commentRepliesCommentId` to refer to this [Comment].
  Future<void> replies(
    _i1.Session session,
    Comment comment,
    List<_i2.Reply> reply, {
    _i1.Transaction? transaction,
  }) async {
    if (reply.any((e) => e.id == null)) {
      throw ArgumentError.notNull('reply.id');
    }
    if (comment.id == null) {
      throw ArgumentError.notNull('comment.id');
    }

    var $reply = reply
        .map((e) => _i2.ReplyImplicit(
              e,
              $_commentRepliesCommentId: comment.id,
            ))
        .toList();
    await session.db.update<_i2.Reply>(
      $reply,
      columns: [_i2.Reply.t.$_commentRepliesCommentId],
      transaction: transaction,
    );
  }
}

class CommentAttachRowRepository {
  const CommentAttachRowRepository._();

  /// Creates a relation between this [Comment] and the given [Reply]
  /// by setting the [Reply]'s foreign key `_commentRepliesCommentId` to refer to this [Comment].
  Future<void> replies(
    _i1.Session session,
    Comment comment,
    _i2.Reply reply, {
    _i1.Transaction? transaction,
  }) async {
    if (reply.id == null) {
      throw ArgumentError.notNull('reply.id');
    }
    if (comment.id == null) {
      throw ArgumentError.notNull('comment.id');
    }

    var $reply = _i2.ReplyImplicit(
      reply,
      $_commentRepliesCommentId: comment.id,
    );
    await session.db.updateRow<_i2.Reply>(
      $reply,
      columns: [_i2.Reply.t.$_commentRepliesCommentId],
      transaction: transaction,
    );
  }
}

class CommentDetachRepository {
  const CommentDetachRepository._();

  /// Detaches the relation between this [Comment] and the given [Reply]
  /// by setting the [Reply]'s foreign key `_commentRepliesCommentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> replies(
    _i1.Session session,
    List<_i2.Reply> reply, {
    _i1.Transaction? transaction,
  }) async {
    if (reply.any((e) => e.id == null)) {
      throw ArgumentError.notNull('reply.id');
    }

    var $reply = reply
        .map((e) => _i2.ReplyImplicit(
              e,
              $_commentRepliesCommentId: null,
            ))
        .toList();
    await session.db.update<_i2.Reply>(
      $reply,
      columns: [_i2.Reply.t.$_commentRepliesCommentId],
      transaction: transaction,
    );
  }
}

class CommentDetachRowRepository {
  const CommentDetachRowRepository._();

  /// Detaches the relation between this [Comment] and the given [Reply]
  /// by setting the [Reply]'s foreign key `_commentRepliesCommentId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> replies(
    _i1.Session session,
    _i2.Reply reply, {
    _i1.Transaction? transaction,
  }) async {
    if (reply.id == null) {
      throw ArgumentError.notNull('reply.id');
    }

    var $reply = _i2.ReplyImplicit(
      reply,
      $_commentRepliesCommentId: null,
    );
    await session.db.updateRow<_i2.Reply>(
      $reply,
      columns: [_i2.Reply.t.$_commentRepliesCommentId],
      transaction: transaction,
    );
  }
}
