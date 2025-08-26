/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'invitations.dart' as _i2;

abstract class Connect implements _i1.SerializableModel {
  Connect._({
    this.id,
    this.accountId,
    required this.activeConnections,
    this.receivedPending,
    this.sentPending,
  });

  factory Connect({
    int? id,
    int? accountId,
    required List<int> activeConnections,
    List<_i2.Invitation>? receivedPending,
    List<_i2.Invitation>? sentPending,
  }) = _ConnectImpl;

  factory Connect.fromJson(Map<String, dynamic> jsonSerialization) {
    return Connect(
      id: jsonSerialization['id'] as int?,
      accountId: jsonSerialization['accountId'] as int?,
      activeConnections: (jsonSerialization['activeConnections'] as List)
          .map((e) => e as int)
          .toList(),
      receivedPending: (jsonSerialization['receivedPending'] as List?)
          ?.map((e) => _i2.Invitation.fromJson((e as Map<String, dynamic>)))
          .toList(),
      sentPending: (jsonSerialization['sentPending'] as List?)
          ?.map((e) => _i2.Invitation.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? accountId;

  List<int> activeConnections;

  List<_i2.Invitation>? receivedPending;

  List<_i2.Invitation>? sentPending;

  /// Returns a shallow copy of this [Connect]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Connect copyWith({
    int? id,
    int? accountId,
    List<int>? activeConnections,
    List<_i2.Invitation>? receivedPending,
    List<_i2.Invitation>? sentPending,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (accountId != null) 'accountId': accountId,
      'activeConnections': activeConnections.toJson(),
      if (receivedPending != null)
        'receivedPending':
            receivedPending?.toJson(valueToJson: (v) => v.toJson()),
      if (sentPending != null)
        'sentPending': sentPending?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConnectImpl extends Connect {
  _ConnectImpl({
    int? id,
    int? accountId,
    required List<int> activeConnections,
    List<_i2.Invitation>? receivedPending,
    List<_i2.Invitation>? sentPending,
  }) : super._(
          id: id,
          accountId: accountId,
          activeConnections: activeConnections,
          receivedPending: receivedPending,
          sentPending: sentPending,
        );

  /// Returns a shallow copy of this [Connect]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Connect copyWith({
    Object? id = _Undefined,
    Object? accountId = _Undefined,
    List<int>? activeConnections,
    Object? receivedPending = _Undefined,
    Object? sentPending = _Undefined,
  }) {
    return Connect(
      id: id is int? ? id : this.id,
      accountId: accountId is int? ? accountId : this.accountId,
      activeConnections:
          activeConnections ?? this.activeConnections.map((e0) => e0).toList(),
      receivedPending: receivedPending is List<_i2.Invitation>?
          ? receivedPending
          : this.receivedPending?.map((e0) => e0.copyWith()).toList(),
      sentPending: sentPending is List<_i2.Invitation>?
          ? sentPending
          : this.sentPending?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
