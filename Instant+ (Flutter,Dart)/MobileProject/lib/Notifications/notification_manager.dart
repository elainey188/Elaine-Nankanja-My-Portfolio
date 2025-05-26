import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobileproject/Classes/vault.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> sendNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'milestone_channel_id',
    'Milestone Notifications',
    channelDescription: 'Notifications about your milestones',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformDetails,
    payload: 'Milestone Reached!',
  );
}

void checkAndNotifyForMilestone(Vault vault) {
  double milestone1 = vault.goalAmount * 0.25;
  double milestone2 = vault.goalAmount * 0.50;
  double milestone3 = vault.goalAmount * 0.75;

  String title = "";
  String body = "";

  if (vault.balanceAmount >= milestone1 && vault.balanceAmount < milestone2) {
    title = "25% Milestone Reached!";
    body = "You've reached 25% of your goal!";
    sendNotification(title, body);
  } else if (vault.balanceAmount >= milestone2 && vault.balanceAmount < milestone3) {
    title = "50% Milestone Reached!";
    body = "You're halfway there! 50% of your goal is complete!";
    sendNotification(title, body);
  } else if (vault.balanceAmount >= milestone3 && vault.balanceAmount < vault.goalAmount) {
    title = "75% Milestone Reached!";
    body = "You're 75% towards your goal!";
    sendNotification(title, body);
  }
}