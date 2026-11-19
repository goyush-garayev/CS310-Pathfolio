import 'package:flutter/material.dart';

/// Shared spacing, radius and size values.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Left/right padding of every screen.
  static const double screenH = 20;

  static const double buttonHeight = 54;
  static const double inputHeight = 48;

  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 20;
  static const double radiusPill = 100;

  static const EdgeInsets screenPadding =
      EdgeInsets.symmetric(horizontal: screenH, vertical: sm);

  /// Max width of content, so the layout still looks good on big phones/tablets.
  static const double maxContentWidth = 520;
}

/// Small helper widgets for vertical / horizontal gaps.
class Gap extends StatelessWidget {
  final double size;
  final bool horizontal;
  const Gap(this.size, {super.key}) : horizontal = false;
  const Gap.h(this.size, {super.key}) : horizontal = true;

  @override
  Widget build(BuildContext context) =>
      horizontal ? SizedBox(width: size) : SizedBox(height: size);
}
