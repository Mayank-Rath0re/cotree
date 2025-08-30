import 'package:flutter/material.dart';
import 'package:cotree_flutter/themes/dark_theme.dart';
import 'package:cotree_flutter/themes/light_theme.dart';
import 'package:cotree_flutter/models/box_provider.dart';

class ThemeProvider with ChangeNotifier {
  final HiveBoxProvider cache;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider(this.cache) {
    // Load saved theme from Hive once
    final saved = cache.getValue<String>('themeMode', defaultValue: 'system');
    _themeMode = _parseThemeMode(saved);
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return; // ✅ no redundant writes
    _themeMode = mode;

    // Save compact value: "light" | "dark" | "system"
    final value = mode.toString().split('.').last;
    await cache.setValue('themeMode', value);

    notifyListeners();
  }

  bool get isDarkMode {
    switch (_themeMode) {
      case ThemeMode.dark:
        return true;
      case ThemeMode.light:
        return false;
      case ThemeMode.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark;
    }
  }

  void toggleTheme() {
    // ✅ cycle without async/await
    final nextMode = switch (_themeMode) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    setThemeMode(nextMode);
  }

  // --- Theme Resolution ---
  ThemeData get _activeTheme {
    switch (_themeMode) {
      case ThemeMode.light:
        return lightMode;
      case ThemeMode.dark:
        return darkMode;
      case ThemeMode.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark ? darkMode : lightMode;
    }
  }

  ThemeData get themeData => _activeTheme;

  // --- Shortcut Colors ---
  // Use `context.select` in widgets to avoid unnecessary rebuilds.
  Color get contrastColor => _activeTheme.colorScheme.inversePrimary;
  Color get mainColor => _activeTheme.colorScheme.primary;
  Color get headColor => _activeTheme.colorScheme.tertiary;
  Color get secondaryColor => _activeTheme.colorScheme.secondary;

  // --- Helpers ---
  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
