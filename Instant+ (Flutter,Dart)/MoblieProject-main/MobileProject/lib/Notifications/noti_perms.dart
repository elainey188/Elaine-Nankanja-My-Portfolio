import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  // Check if the notification permission is granted
  PermissionStatus status = await Permission.notification.status;

  // If the permission is not granted, request it
  if (!status.isGranted) {
    PermissionStatus newStatus = await Permission.notification.request();

    if (newStatus.isGranted) {
      print("Notification permission granted!");
    } else {
      print("Notification permission denied!");
    }
  }
}