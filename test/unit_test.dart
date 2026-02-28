import 'package:flutter_test/flutter_test.dart';
import 'package:onyx_restaurant/data/models/Setting.dart';
import 'package:onyx_restaurant/provider/navigation_provider.dart';

void main() {
  group('Setting model', () {
    test('Setting menyimpan nilai yang diberikan dengan benar', () {
      final setting = Setting(
        isDarkMode: true,
        isDailyReminderEnabled: true,
      );

      expect(setting.isDarkMode, true);
      expect(setting.isDailyReminderEnabled, true);
    });

    test('Setting dengan semua nilai false', () {
      final setting = Setting(
        isDarkMode: false,
        isDailyReminderEnabled: false,
      );

      expect(setting.isDarkMode, false);
      expect(setting.isDailyReminderEnabled, false);
    });
  });

  group('NavigationProvider', () {
    test('index awal adalah 0', () {
      final provider = NavigationProvider();
      expect(provider.getIndexNavigationBar, 0);
    });

    test('setIndexNavigationBar mengubah index dengan benar', () {
      final provider = NavigationProvider();
      provider.setIndexNavigationBar(2);
      expect(provider.getIndexNavigationBar, 2);
    });
  });
}
