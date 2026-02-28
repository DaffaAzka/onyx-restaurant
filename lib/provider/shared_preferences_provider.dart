import 'package:flutter/material.dart';
import 'package:onyx_restaurant/data/models/Setting.dart';
import 'package:onyx_restaurant/data/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SharedPreferencesProvider(this._service) {
    getSettingValue();
  }

  String _message = "";
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  Future<void> saveSettingValue(Setting value) async {
    try {
      await _service.saveSettingValue(value);
      _setting = value;
      _message = "Your data is saved";
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  void getSettingValue() async {
    try {
      _setting = _service.getValue();
    } catch (e) {
      _setting = Setting(isDarkMode: false, isNotificationsEnabled: false);
    }
    notifyListeners();
  }
}
