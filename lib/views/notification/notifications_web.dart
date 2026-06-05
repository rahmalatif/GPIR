import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class NotificationsWebView extends StatefulWidget {
  const NotificationsWebView({super.key});

  @override
  State<NotificationsWebView> createState() => _NotificationsWebViewState();
}

class _NotificationsWebViewState extends State<NotificationsWebView> {
  @override
  void initState() {
    super.initState();
    markAllAsRead();
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

    for (var doc in notifications.docs) {
      await doc.reference.update({
        'isRead': true,
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
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
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var notifications = snapshot.data!.docs;

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                "No Notifications",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var data = notifications[index].data() as Map<String, dynamic>;

              return Card(
                color: const Color(0xFF1B1E2B),
                margin: const EdgeInsets.all(10),
                child: ListTile(
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
                    ),
                  ),
                  subtitle: Text(
                    data['message'],
                    style: const TextStyle(
                      color: Colors.grey,
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
