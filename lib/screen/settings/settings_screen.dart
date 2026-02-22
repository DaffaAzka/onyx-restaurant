import 'package:flutter/material.dart';
import 'package:onyx_restaurant/provider/theme_provider.dart';
import 'package:onyx_restaurant/style/typography/onyx_text_styles.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().getThemeMode == ThemeMode.dark;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Dark Mode?", style: OnyxTextStyles.titleMedium),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  ThemeMode theme = value ? ThemeMode.dark : ThemeMode.light;
                  Provider.of<ThemeProvider>(context, listen: false).setThemeMode(theme);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
