import 'package:flutter/material.dart';

class Appcolors {
  static const Color primaryGreen = Color.fromARGB(255, 50, 163, 72);
  static const Color lightGreen = Color(0xff9CD323);
  static const Color texColor = Colors.black87;
  static const Color background = Color.fromARGB(255, 247, 247, 247);
  static const Color darkGreen = Color.fromARGB(255, 13, 85, 43);
  static const Color gradientColor1 = Color.fromARGB(255, 103, 203, 147);
  static Color gradientColor2 = const Color.fromARGB(
    255,
    10,
    72,
    36,
  ).withOpacity(0.78);
}

/// ─── STATUS CONFIG MODEL ──────────────────────────────────────────────────

class StatusConfig {
  final Color color;
  final Color bg;
  final IconData icon;
  final String label;

  StatusConfig({
    required this.color,
    required this.bg,
    required this.icon,
    required this.label,
  });
}