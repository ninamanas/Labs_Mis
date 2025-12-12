import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsService {
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();


  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(settings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notifDetails =
    NotificationDetails(android: androidDetails);

    await _plugin.show(
      0,
      title,
      body,
      notifDetails,
    );
  }


  static Future<void> scheduleOneTimeNotification({
    required DateTime dateTime,
    required String title,
    required String body,
  }) async {
    final tzDateTime = tz.TZDateTime.from(dateTime, tz.local);

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'one_time_channel',
      'One Time Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _plugin.zonedSchedule(
      2,
      title,
      body,
      tzDateTime,
      const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: null,
    );
  }
}
