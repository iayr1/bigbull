import 'package:flutter/material.dart';

class BB {
  static const green = Color(0xFF1FA64A);
  static const cream = Color(0xFFFFF5D1);
  static const card = Color(0xFFFFFBE8);
  static const ink = Color(0xFF141414);
  static const yellow = Color(0xFFFFD93D);
  static const lavender = Color(0xFFC9B8FF);
  static const muted = Color(0xFF5E5A4E);
  static const mono = 'monospace';

  static ThemeData theme() => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: cream,
    colorScheme: ColorScheme.fromSeed(seedColor: green, surface: cream),
    fontFamily: 'Roboto',
    textTheme: const TextTheme().apply(bodyColor: ink, displayColor: ink),
    splashFactory: InkRipple.splashFactory,
  );
}
