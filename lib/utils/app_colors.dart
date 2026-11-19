import 'package:flutter/material.dart';

/// All colors used in the app. Same values as the Figma color variables.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0A3F2C); // dark green
  static const Color primarySoft = Color(0xFFE3F9B8); // light lime (selected chips)
  static const Color accent = Color(0xFF00E676); // bright green (main buttons)
  static const Color accentSoft = Color(0xFFD2F76B); // lime (banners, cards)
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF0B2A1C);
  static const Color textMuted = Color(0xFF5C6B63);
  static const Color border = Color(0xFFC5CEC9);
  static const Color success = Color(0xFF0FA958);
  static const Color error = Color(0xFFD93025);
  static const Color white = Color(0xFFFFFFFF);

  // Logo colors
  static const Color logoLime = Color(0xFFBDFF66);
  static const Color logoDark = Color(0xFF172305);

  // Soft shadow for cards and the nav bar
  static const Color shadow = Color(0x1A0B2A1C); // 10% of text color
}
