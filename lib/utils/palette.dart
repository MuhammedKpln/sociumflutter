import 'package:flutter/material.dart';

abstract class ColorPalette {
  static const Color primary = Color(0xFFFE7949);
  static const Color background = Color(0xFF1E2226);
  static const Color surface = Color(0xFF232528);
  static const Color grey = Color(0xFFF3F5F7);
  static const Color green = Color(0xFF91F5AD);
  static const Color red = Color(0xFFF26F70);
  static LinearGradient bgLinearGradient = LinearGradient(colors: [
    ColorPalette.primary,
    Colors.orange.shade300,
  ]);
  static LinearGradient surfaceLinearGradient = const LinearGradient(
      colors: [Color(0xFF33383F), Color(0xFF131416)],
      begin: Alignment.centerLeft,
      tileMode: TileMode.decal,
      end: Alignment.centerRight);
  static LinearGradient shimmerGradient =
      LinearGradient(colors: [Colors.white.withOpacity(0.5), Colors.white]);
}
