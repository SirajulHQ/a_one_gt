import 'package:flutter/material.dart';

class Appcolors {
  static const Color primaryGreen = Color.fromARGB(255, 50, 163, 72);
  static const Color lightGreen =  Color(0xff9CD323);
  static const Color texColor = Colors.black87;
  static const Color background = Color.fromARGB(255, 247, 247, 247);
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