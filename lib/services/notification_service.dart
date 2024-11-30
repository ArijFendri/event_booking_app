import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialisation des notifications
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); // Utilisation de l'icône par défaut de l'application

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Affichage d'une notification
  static Future<void> showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'event_channel', // Identifiant du canal de notification
      'Event Notifications',
      channelDescription: 'Canal pour les notifications des événements',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      id, // Identifiant unique pour chaque notification
      title,
      body,
      notificationDetails,
    );
  }
}
