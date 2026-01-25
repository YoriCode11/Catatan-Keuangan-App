import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        // Logika ketika notifikasi diklik
      },
    );
  }

  // Fungsi Scheduling untuk UAS (20 Poin)
  Future<void> scheduleDailyReminder() async {
    await _notifications.zonedSchedule(
      0,
      'Catat Keuanganmu! 📝',
      'Jangan lupa catat pengeluaran dan pemasukan hari ini agar keuangan tetap terkontrol.',
      _nextInstanceOfTime(
        20,
        0,
      ), // Contoh: Notifikasi muncul jam 8 malam setiap hari
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Pengingat Harian',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents:
          DateTimeComponents.time, // Membuatnya berulang tiap hari
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
