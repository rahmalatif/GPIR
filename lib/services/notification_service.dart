import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final _db = FirebaseFirestore.instance;

  static Future send({
    required String userId,
    required String title,
    required String body,
    required String type,
    required String projectId,
  }) async {
    await _db.collection("notifications").add({
      "userId": userId,
      "title": title,
      "body": body,
      "type": type,
      "projectId": projectId,
      "seen": false,
      "createdAt": DateTime.now(),
    });
  }

  static Stream<QuerySnapshot> stream(String userId) {
    return FirebaseFirestore.instance
        .collection("notifications")
        .where("userId", isEqualTo: userId)
        .snapshots();
  }

}
