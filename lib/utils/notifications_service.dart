import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSetting =
        AndroidInitializationSettings('@mipamp/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSetting,
    );

    await _notificationsPlugin.initialize(settings);
  }

  static Future<void> showNotifications({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'description',
          priority: Priority.high,
          importance: Importance.high,
          playSound: true,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails
    );
  }
}
