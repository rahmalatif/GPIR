import 'dart:async';
import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../services/auth_service.dart';
import '../model/chatModel.dart';

class ChattingView extends StatefulWidget {
  final String currentUserId;
  final String myName;
  final String receiverId;
  final String receiverName;

  const ChattingView({
    super.key,
    required this.myName,
    required this.currentUserId,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChattingView> createState() => _ChattingViewState();
}

String getChatId(String user1, String user2) {
  List<String> ids = [user1, user2];
  ids.sort();
  return ids.join('_');
}

class _ChattingViewState extends State<ChattingView> {
  TextEditingController message = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late final String chatId;
  StreamSubscription? _messagesSubscription;

  void listenToIncomingMessages() {
    _messagesSubscription = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('senderId', isNotEqualTo: widget.currentUserId)
        .where('isSeen', isEqualTo: false)
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        for (var doc in snapshot.docs) {
          batch.update(doc.reference, {'isSeen': true});
        }
        await batch.commit();

        final notifications = await FirebaseFirestore.instance
            .collection('notifications')
            .where('receiverId', isEqualTo: widget.currentUserId)
            .where('senderId', isEqualTo: widget.receiverId)
            .where('isRead', isEqualTo: false)
            .get();

        WriteBatch notificationBatch = FirebaseFirestore.instance.batch();
        for (var doc in notifications.docs) {
          notificationBatch.update(doc.reference, {'isRead': true});
        }
        await notificationBatch.commit();

        String unreadKey = '';
        if (AuthService.role == "student") unreadKey = 'unread_student';
        if (AuthService.role == "doctor") unreadKey = 'unread_doctor';
        if (AuthService.role == "teachingAssistant") unreadKey = 'unread_ta';

        if (unreadKey.isNotEmpty) {
          await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
            unreadKey: 0,
          });
        }
      }
    });
  }

  Future<void> clearUnreadOnEntry() async {
    String unreadKey = '';
    if (AuthService.role == "student") unreadKey = 'unread_student';
    if (AuthService.role == "doctor") unreadKey = 'unread_doctor';
    if (AuthService.role == "teachingAssistant") unreadKey = 'unread_ta';

    if (unreadKey.isNotEmpty) {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        unreadKey: 0,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    chatId = getChatId(widget.currentUserId, widget.receiverId);
    clearUnreadOnEntry();
    listenToIncomingMessages();
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    _scrollController.dispose();
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String baseUrl = "https://graduationbackend-production-ec83.up.railway.app";

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text(
          widget.receiverName,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var docs = snapshot.data!.docs;

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index];
                    var messageData = data.data() as Map<String, dynamic>;
                    bool isSeen = messageData['isSeen'] ?? false;
                    bool isMe = data['senderId'] == widget.currentUserId;

                    return Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        BubbleSpecialThree(
                          isSender: isMe,
                          text: data['text'],
                          color: isMe ? const Color(0xFF1897F3) : Colors.grey,
                          tail: true,
                          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        if (isMe)
                          Padding(
                            padding: const EdgeInsets.only(right: 12, top: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isSeen ? Icons.done_all : Icons.done,
                                  size: 14,
                                  color: isSeen ? Colors.blue : Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isSeen ? "Seen" : "Delivered",
                                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2)),
              ],
              borderRadius: BorderRadius.circular(36),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: message,
                    decoration: InputDecoration(
                      hintText: "Write a message...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFF1897F3), width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFF1897F3),
                  child: IconButton(
                    onPressed: () async {
                      if (message.text.trim().isEmpty) return;

                      String text = message.text.trim();
                      message.clear();

                      String receiverUnreadKey = 'unread_doctor';
                      if (AuthService.role == 'doctor' || AuthService.role == 'teachingAssistant') {
                        receiverUnreadKey = 'unread_student';
                      } else {
                        receiverUnreadKey = 'unread_doctor';
                      }

                      FirebaseFirestore.instance.collection('chats').doc(chatId).set({
                        'participants': [widget.currentUserId, widget.receiverId],
                        'participantNames': {
                          widget.currentUserId: widget.myName,
                          widget.receiverId: widget.receiverName,
                        },
                        'lastMessage': text,
                        'lastMessageTime': Timestamp.now(),
                        receiverUnreadKey: FieldValue.increment(1),
                      }, SetOptions(merge: true));

                      await FirebaseFirestore.instance
                          .collection('chats')
                          .doc(chatId)
                          .collection('messages')
                          .add({
                        'text': text,
                        'senderId': widget.currentUserId,
                        'senderName': widget.myName,
                        'time': Timestamp.now(),
                        'isSeen': false,
                      });

                      FirebaseFirestore.instance.collection('notifications').add({
                        'receiverId': widget.receiverId,
                        'senderId': widget.currentUserId,
                        'senderName': widget.myName,
                        'message': text,
                        'type': 'chat',
                        'isRead': false,
                        'time': Timestamp.now(),
                      });

                      http.post(
                        Uri.parse("$baseUrl/api/notifications/chat"),
                        headers: {
                          "Content-Type": "application/json",
                          "Authorization": "Bearer ${AuthService.token}",
                        },
                        body: jsonEncode({
                          "receiver_id": widget.receiverId,
                          "sender_name": widget.myName,
                          "message": text,
                        }),
                      ).catchError((e) => print(e));
                    },
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}