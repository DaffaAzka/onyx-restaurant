import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/models/setting.dart';
import 'package:onyx_restaurant/data/shared_preferences_service.dart';
import 'package:onyx_restaurant/services/workmanager_service.dart';
import 'package:workmanager/workmanager.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  final WorkmanagerService _workmanagerService;

  SharedPreferencesProvider(this._service, this._workmanagerService) {
    getSettingValue();
  }

  String _message = "";
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  Future<void> saveSettingValue(Setting value) async {
    await Workmanager().cancelAll();
    try {
      await _service.saveSettingValue(value);
      _setting = value;
      _message = "Your data is saved";
      if (value.isDailyReminderEnabled) {
        await _workmanagerService.scheduleDailyReminder();
      } else {
        await _workmanagerService.cancelDailyReminder();
      }
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  void getSettingValue() {
    try {
      _setting = _service.getValue();
    } catch (e) {
      _setting = Setting(isDarkMode: false, isDailyReminderEnabled: false);
    }
    notifyListeners();
  }
}
