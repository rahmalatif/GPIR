import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'auth_service.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> saveTokenToFirestore() async {
    String? token = await _messaging.getToken();

    if (token == null || AuthService.userId == null) {
      return;
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService.userId)
        .set({
      'name': AuthService.name,
      'role': AuthService.role,
      'fcmToken': token,
    }, SetOptions(merge: true));

    print("TOKEN SAVED");
  }

  static Future<void> initialize() async {
    NotificationSettings settings = await _messaging.requestPermission();

    print(
      "NOTIFICATION PERMISSION: "
      "${settings.authorizationStatus}",
    );

    String? token = await _messaging.getToken();

    print("FCM TOKEN = $token");

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print("NOTIFICATION CLICKED");

        print(message.data);
      },
    );
  }
}
