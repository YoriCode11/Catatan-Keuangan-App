import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_data.initializeTimeZones();

    // 1. Minta Izin secara eksplisit untuk Android 13+
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _notifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    // Meminta izin notifikasi (Muncul pop-up di HP)
    await androidImplementation?.requestNotificationsPermission();
    // Meminta izin untuk alarm yang presisi
    await androidImplementation?.requestExactAlarmsPermission();

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        // Logika ketika notifikasi diklik (bisa diarahkan ke halaman tertentu)
      },
    );
  }

  // Fungsi Scheduling untuk UAS
  Future<void> scheduleDailyReminder() async {
    await _notifications.zonedSchedule(
      0,
      'Catat Keuanganmu! 📝',
      'Jangan lupa catat pengeluaran dan pemasukan hari ini agar keuangan tetap terkontrol.',
      _nextInstanceOfTime(
        DateTime.now().hour,
        DateTime.now().minute + 1,
      ), // Default: Jam 8 Malam
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Pengingat Harian',
          channelDescription:
              'Channel untuk pengingat mencatat keuangan harian',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
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
