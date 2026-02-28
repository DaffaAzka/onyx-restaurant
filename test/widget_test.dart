import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onyx_restaurant/data/models/setting.dart';
import 'package:onyx_restaurant/provider/navigation_provider.dart';
import 'package:onyx_restaurant/provider/shared_preferences_provider.dart';
import 'package:onyx_restaurant/screen/settings/settings_screen.dart';
import 'package:onyx_restaurant/services/workmanager_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([SharedPreferencesProvider, WorkmanagerService])
void main() {
  late MockSharedPreferencesProvider mockProvider;

  setUp(() {
    mockProvider = MockSharedPreferencesProvider();
    when(mockProvider.setting).thenReturn(
      Setting(isDarkMode: false, isDailyReminderEnabled: false),
    );
    when(mockProvider.message).thenReturn('');
    when(mockProvider.getSettingValue()).thenReturn(null);
  });

  testWidgets('SettingsScreen menampilkan label Dark Mode', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<SharedPreferencesProvider>.value(
        value: mockProvider,
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Dark Mode'), findsOneWidget);
  });

  testWidgets('SettingsScreen menampilkan label Daily Reminder', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<SharedPreferencesProvider>.value(
        value: mockProvider,
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Daily Reminder'), findsOneWidget);
  });

  testWidgets('MainScreen menampilkan BottomNavigationBar dengan 3 item', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => NavigationProvider(),
        child: MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
                BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Bookmarks'), findsOneWidget);
  });
}
