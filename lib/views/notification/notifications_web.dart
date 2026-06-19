import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_service.dart';

class NotificationsWebView extends StatefulWidget {
  const NotificationsWebView({super.key});

  @override
  State<NotificationsWebView> createState() => _NotificationsWebViewState();
}

class _NotificationsWebViewState extends State<NotificationsWebView> {
  StreamSubscription<QuerySnapshot>? _notificationSubscription;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    setupWebNotifications();
    markAllAsRead();
    listenForNewNotifications();
  }

  Future<void> setupWebNotifications() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token = await messaging.getToken(
          vapidKey: "YOUR_PUBLIC_VAPID_KEY_FROM_FIREBASE",
        );

        if (token != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(AuthService.userId)
              .update({'webToken': token});
        }
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  void listenForNewNotifications() {
    _notificationSubscription = FirebaseFirestore.instance
        .collection('notifications')
        .where(
      'receiverId',
      isEqualTo: AuthService.userId,
    )
        .snapshots()
        .listen((snapshot) {
      if (_isFirstLoad) {
        _isFirstLoad = false;
        return;
      }

      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data() as Map<String, dynamic>;

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
              dismissDirection: DismissDirection.up,
              backgroundColor: const Color(0xFF1B1E2B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFF1897F3), width: 1),
              ),
              content: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF1897F3),
                    radius: 16,
                    child: Icon(Icons.chat, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data['senderName'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          data['message'] ?? '',
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    });
  }

  Future<void> markAllAsRead() async {
    final notifications = await FirebaseFirestore.instance
        .collection('notifications')
        .where(
      'receiverId',
      isEqualTo: AuthService.userId,
    )
        .where(
      'isRead',
      isEqualTo: false,
    )
        .get();

    if (notifications.docs.isEmpty) return;

    final batch = FirebaseFirestore.instance.batch();
    for (var doc in notifications.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where(
          'receiverId',
          isEqualTo: AuthService.userId,
        )
            .orderBy(
          'time',
          descending: true,
        )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1897F3)),
              ),
            );
          }

          final notifications = snapshot.data!.docs;

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                "No Notifications",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final data =
              notifications[index].data() as Map<String, dynamic>;

              return Card(
                color: const Color(0xFF1B1E2B),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF1897F3),
                    child: Icon(
                      Icons.chat,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    "${data['senderName']} sent you a message",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      data['message'] ?? '',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}