import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/models/setting.dart';
import 'package:onyx_restaurant/provider/shared_preferences_provider.dart';
import 'package:onyx_restaurant/services/local_notification_service.dart';
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
    final isDailyReminderEnabled = sharedPreferencesProvider.setting?.isDailyReminderEnabled ?? false;

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
                    Setting(isDarkMode: value, isDailyReminderEnabled: isDailyReminderEnabled),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Daily Reminder", style: OnyxTextStyles.titleMedium),
              Switch(
                value: isDailyReminderEnabled,
                onChanged: (value) {
                  context.read<SharedPreferencesProvider>().saveSettingValue(
                    Setting(isDarkMode: isDarkMode, isDailyReminderEnabled: value),
                  );
                },
              ),
            ],
          ),

          ElevatedButton(
            onPressed: () async {
              await LocalNotificationService().showNotification(
                id: 1,
                title: "Test",
                body: "Notifikasi langsung berhasil!",
              );
            },
            child: Text("Test Notifikasi"),
          ),
        ],
      ),
    );
  }
}
