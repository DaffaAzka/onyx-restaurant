import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF9C27B0);
  static const Color primaryLight = Color(0xFFBA68C8);
  static const Color primaryDark = Color(0xFF7B1FA2);
  static const Color error = Color(0xFFf44336);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
}

enum OnyxColors {
  purple("Purple", AppColors.primary);

  const OnyxColors(this.name, this.color);

  final String name;
  final Color color;
}
