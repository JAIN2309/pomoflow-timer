import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFF1E1E2C);
  static const Color surfaceColor = Color(0xFF2A2A3E);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFF5252),
        brightness: Brightness.dark,
        surface: surfaceColor,
      ),
    );
  }
}
