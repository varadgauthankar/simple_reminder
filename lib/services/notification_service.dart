import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService();

  init() async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_notification');

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  getAndroidNotificationDetails() {
    return AndroidNotificationDetails(
      'reminder',
      'Reminder Notification',
      'Notification sent as reminder',
      importance: Importance.defaultImportance,
      enableVibration: true,
      groupKey: 'com.varadgauthankar.simple_reminder.REMINDER',
    );
  }

  getIosNotificationDetails() {
    return IOSNotificationDetails();
  }

  getNotificationDetails() {
    return NotificationDetails(
      android: getAndroidNotificationDetails(),
      iOS: getIosNotificationDetails(),
    );
  }

  Future scheduleNotification({
    required int id,
    required String title,
    required String description,
    required DateTime dateTime,
  }) async {
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      description,
      notificationTime(dateTime),
      getNotificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );

    print('notification set at $dateTime');
  }

  Future<bool> goalHasNotification(int key) async {
    var pendingNotifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications.any((notification) => notification.id == key);
  }

  void cancelNotification({required int id}) {
    flutterLocalNotificationsPlugin.cancel(id);
    print('$id canceled');
  }

  tz.TZDateTime notificationTime(DateTime dateTime) {
    return tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );
  }
}
