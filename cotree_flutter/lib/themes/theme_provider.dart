import 'package:cotree_flutter/themes/dark_theme.dart';
import 'package:cotree_flutter/themes/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkMode;
  final List<List<dynamic>> modes = [
    [Icons.sunny, Colors.black],
    [Icons.nights_stay, Colors.white],
  ];
  int selectedIndex = 0;

  ThemeData get themeData => _themeData;
  Color get contrastColor => _themeData.colorScheme.inversePrimary;
  Color get mainColor => _themeData.colorScheme.primary;
  Color get headColor => _themeData.colorScheme.tertiary;
  Color get secondaryColor => _themeData.colorScheme.secondary;
  Icons get themeIcon => modes[selectedIndex][0];

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    print("Changing theme: ");
    if (_themeData == lightMode) {
      _themeData = darkMode;
      selectedIndex = 1;
    } else {
      _themeData = lightMode;
      selectedIndex = 0;
    }
    notifyListeners();
  }
}
