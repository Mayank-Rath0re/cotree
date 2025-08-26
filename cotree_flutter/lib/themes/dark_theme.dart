import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        surface: Color(0xFF12100E),
        primary: Color(0xFF1E1A17),
        secondary: Color(0xFF3C332C),
        tertiary: Color(0xFFAF8864),
        inversePrimary: Color(0xFFF1EBE4)),
    snackBarTheme: SnackBarThemeData(backgroundColor: Color(0xFF1E1A17)),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xFFAF8864),
    ),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: "Sora",
          bodyColor: Colors.grey.shade100,
          displayColor: Colors.white,
        ));
