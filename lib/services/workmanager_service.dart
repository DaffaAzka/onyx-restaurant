import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onyx_restaurant/data/api/api_service.dart';
import 'package:workmanager/workmanager.dart';

const String dailyReminderTask = 'dailyReminderTask';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == dailyReminderTask) {
      try {
        final apiService = ApiService();
        final result = await apiService.getRestaurantListing();
        final restaurants = result.restaurants;
        final random = Random();
        final picked = restaurants[random.nextInt(restaurants.length)];
        final name = picked.name;
        final city = picked.city;

        final plugin = FlutterLocalNotificationsPlugin();
        const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
        const iosInit = DarwinInitializationSettings();
        await plugin.initialize(
          onDidReceiveNotificationResponse: (details) {},
          onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
          settings: InitializationSettings(android: androidInit, iOS: iosInit),
        );
        const androidDetails = AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminder',
          channelDescription: 'Notifikasi pengingat restoran harian',
          importance: Importance.max,
          priority: Priority.high,
        );
        const details = NotificationDetails(android: androidDetails, iOS: DarwinNotificationDetails());

        await plugin.show(
          id: 0,
          title: "Rekomendasi restoran hari ini",
          body: "$name di $city",
          notificationDetails: details,
        );
      } catch (_) {
        return false;
      }
    }
    return true;
  });
}

class WorkmanagerService {
  Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher);
  }

  Future<void> scheduleDailyReminder() async {
    final now = DateTime.now();
    var next11AM = DateTime(now.year, now.month, now.day, 11, 0, 0);

    if (now.isAfter(next11AM)) {
      next11AM = next11AM.add(const Duration(days: 1));
    }

    final initialDelay = next11AM.difference(now);

    await Workmanager().registerPeriodicTask(
      dailyReminderTask,
      dailyReminderTask,
      frequency: const Duration(hours: 24),
      initialDelay: initialDelay,
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    );
  }

  Future<void> cancelDailyReminder() async {
    await Workmanager().cancelByUniqueName(dailyReminderTask);
  }
}
