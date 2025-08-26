import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxProvider extends ChangeNotifier {
  final Box box;

  HiveBoxProvider(this.box) {
    box.listenable().addListener(() {
      notifyListeners();
    });
  }

  /// Get a value by key
  /// If [fromJson] is provided and the stored value is a String,
  /// it will be parsed as JSON and converted.
  T? getValue<T>(
    String key, {
    T? defaultValue,
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    final storedValue = box.get(key);
    if (storedValue == null) return defaultValue;

    // If decoding from JSON string
    if (fromJson != null) {
      if (storedValue is String) {
        try {
          final decoded = jsonDecode(storedValue);
          if (decoded is Map<String, dynamic>) {
            return fromJson(decoded);
          }
        } catch (e) {
          debugPrint('HiveBoxProvider: JSON decode error for $key → $e');
          return defaultValue;
        }
      }
      // If already a Map (stored that way)
      if (storedValue is Map<String, dynamic>) {
        return fromJson(storedValue);
      }
    }

    // No JSON decoding — just return as-is if the type matches
    if (storedValue is T) {
      return storedValue;
    }

    return defaultValue;
  }

  /// Set a value for a key
  /// If the value has a `toJson()` method, store it as a JSON string.
  Future<void> setValue<T>(String key, T value) async {
    if (value != null) {
      try {
        final dynamic dyn = value;
        if (dyn is! String &&
            dyn is! num &&
            dyn is! bool &&
            dyn is! List &&
            dyn is! Map) {
          if (dyn.toJson is Function) {
            await box.put(key, jsonEncode(dyn.toJson()));
            return;
          }
        }
      } catch (e) {
        debugPrint('HiveBoxProvider: Failed to encode $key → $e');
      }
    }
    await box.put(key, value);
  }

  Future<void> deleteValue(String key) async => box.delete(key);

  bool containsKey(String key) => box.containsKey(key);

  Future<void> clear() async => box.clear();

  Iterable<dynamic> get keys => box.keys;

  Map<dynamic, dynamic> get allValues => Map.from(box.toMap());
}
