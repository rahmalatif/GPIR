import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentNotificationsView extends StatelessWidget {
  const StudentNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text("Notifications"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/studentDashboard'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("notifications")
            .where("userId", isEqualTo: uid)
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final n = docs[i];
              final seen = n["seen"] ?? false;

              return GestureDetector(

                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection("notifications")
                      .doc(n.id)
                      .update({"seen": true});

                  final assignedId = n.data().toString().contains("assignedId")
                      ? n["assignedId"]
                      : null;

                  if (assignedId != null) {
                    context.push(
                      '/projectAssigned',
                      extra: {
                        "projectId": assignedId,
                        "status": "accepted",
                      },
                    );
                  }
                },



                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: seen
                        ? const Color(0xFF1A1D2E)
                        : const Color(0xFF4699A8).withOpacity(.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n["title"] ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: seen ? FontWeight.w400 : FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        n["body"] ?? "",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
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
