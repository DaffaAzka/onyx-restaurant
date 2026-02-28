import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/models/Setting.dart';
import 'package:onyx_restaurant/provider/shared_preferences_provider.dart';
import 'package:onyx_restaurant/style/typography/onyx_text_styles.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<SharedPreferencesProvider>().getSettingValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sharedPreferencesProvider = context.watch<SharedPreferencesProvider>();

    final isDarkMode = sharedPreferencesProvider.setting?.isDarkMode ?? false;
    final isNotificationsEnabled = sharedPreferencesProvider.setting?.isNotificationsEnabled ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Dark Mode", style: OnyxTextStyles.titleMedium),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  context.read<SharedPreferencesProvider>().saveSettingValue(
                    Setting(isDarkMode: value, isNotificationsEnabled: isNotificationsEnabled),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Notifications", style: OnyxTextStyles.titleMedium),
              Switch(
                value: isNotificationsEnabled,
                onChanged: (value) {
                  context.read<SharedPreferencesProvider>().saveSettingValue(
                    Setting(isDarkMode: isDarkMode, isNotificationsEnabled: value),
                  );
                },
              ),
            ],
          ),
          if (sharedPreferencesProvider.message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(sharedPreferencesProvider.message, style: OnyxTextStyles.titleMedium),
            ),
        ],
      ),
    );
  }
}
