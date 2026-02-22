import 'package:flutter/material.dart';
import 'package:onyx_restaurant/style/colors/onyx_colors.dart';
import 'package:onyx_restaurant/style/typography/onyx_text_styles.dart';

class OnyxTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: OnyxColors.purple.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: OnyxColors.purple.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: OnyxTextStyles.displayLarge,
      displayMedium: OnyxTextStyles.displayMedium,
      displaySmall: OnyxTextStyles.displaySmall,
      headlineLarge: OnyxTextStyles.headlineLarge,
      headlineMedium: OnyxTextStyles.headlineMedium,
      headlineSmall: OnyxTextStyles.headlineSmall,
      titleLarge: OnyxTextStyles.titleLarge,
      titleMedium: OnyxTextStyles.titleMedium,
      titleSmall: OnyxTextStyles.titleSmall,
      bodyLarge: OnyxTextStyles.bodyLargeBold,
      bodyMedium: OnyxTextStyles.bodyLargeMedium,
      bodySmall: OnyxTextStyles.bodyLargeRegular,
      labelLarge: OnyxTextStyles.labelLarge,
      labelMedium: OnyxTextStyles.labelMedium,
      labelSmall: OnyxTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
    );
  }
}
