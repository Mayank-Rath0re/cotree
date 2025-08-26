import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    surface: Color(0xFFFDF8F4),
    primary: Color(0xFFEFEAE3),
    secondary: Color(0xFFD8D2CA),
    tertiary: Color(0xFFAF8864),
    inversePrimary: Color(0xFF2A1E14),
  ),
  snackBarTheme: SnackBarThemeData(backgroundColor: Color(0xFFD8D2CA)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xFFAF8864),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: "Sora",
        bodyColor: Colors.grey.shade900,
        displayColor: Colors.black,
      ),
);
