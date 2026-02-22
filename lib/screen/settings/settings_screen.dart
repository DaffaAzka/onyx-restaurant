import 'package:flutter/material.dart';
import 'package:onyx_restaurant/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;

  @override
  Widget build(BuildContext context) {
    _isDarkMode = context.watch<ThemeProvider>().getThemeMode == ThemeMode.dark;

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Dark Mode?"),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    ThemeMode theme = value ? ThemeMode.dark : ThemeMode.light;
                    Provider.of<ThemeProvider>(context, listen: false).setThemeMode(theme);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
