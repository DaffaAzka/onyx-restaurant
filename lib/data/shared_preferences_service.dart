import 'package:onyx_restaurant/data/models/Setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferencesService;

  SharedPreferencesService({required SharedPreferences preferencesService}) : _preferencesService = preferencesService;
  static const String _keyNotification = "MY_NOTIFICATION";
  static const String _keyTheme = "MY_THEME";

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _preferencesService.setBool(_keyNotification, setting.isNotificationsEnabled);
      await _preferencesService.setBool(_keyTheme, setting.isDarkMode);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  Setting getValue() {
    return Setting(
      isDarkMode: _preferencesService.getBool(_keyTheme) ?? false,
      isNotificationsEnabled: _preferencesService.getBool(_keyNotification) ?? true,
    );
  }
}
