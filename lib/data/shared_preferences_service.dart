import 'package:onyx_restaurant/data/models/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferencesService;

  SharedPreferencesService({required SharedPreferences preferencesService}) : _preferencesService = preferencesService;

  static const String _keyTheme = "MY_THEME";
  static const String _keyDailyReminder = "MY_DAILY_REMINDER";

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _preferencesService.setBool(_keyTheme, setting.isDarkMode);
      await _preferencesService.setBool(_keyDailyReminder, setting.isDailyReminderEnabled);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  Setting getValue() {
    return Setting(
      isDarkMode: _preferencesService.getBool(_keyTheme) ?? false,
      isDailyReminderEnabled: _preferencesService.getBool(_keyDailyReminder) ?? false,
    );
  }
}
