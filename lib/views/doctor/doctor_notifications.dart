import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/notification_service.dart';

class DoctorNotificationsView extends StatelessWidget {
  final String doctorId;

  const DoctorNotificationsView({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text("Notifications" , style: TextStyle(color: Colors.white),) ,
        leading: IconButton(
            onPressed: () {
              context.go('/doctorDashboard');
            },
            icon: Icon(Icons.keyboard_backspace , color: Colors.white,)),
      ),
      body: StreamBuilder(
        stream: NotificationService.stream(doctorId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final n = docs[i];

              return GestureDetector(
                onTap: () {
                  context.push('/ideaDetails', extra: n["projectId"]);
                },

                child: Card(
                  color: const Color(0xFF1A1D2E),
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          n["title"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          n["body"],
                          style: const TextStyle(color: Colors.grey),
                        ),

                      ],
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
