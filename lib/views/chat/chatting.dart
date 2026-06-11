import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  late final String chatId;

  Future<void> markMessagesAsSeen() async {
    print("MARK AS SEEN CALLED");
    final messages = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where(
          'senderId',
          isNotEqualTo: widget.currentUserId,
        )
        .get();

    for (var doc in messages.docs) {
      final data = doc.data();

      if ((data['isSeen'] ?? false) == false) {
        await doc.reference.update({
          'isSeen': true,
        });
      }
    }

    final notifications = await FirebaseFirestore.instance
        .collection('notifications')
        .where(
          'receiverId',
          isEqualTo: widget.currentUserId,
        )
        .where(
          'senderId',
          isEqualTo: widget.receiverId,
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
    if (AuthService.role == "student") {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'unread_student': 0,
      });
    }

    if (AuthService.role == "doctor") {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'unread_doctor': 0,
      });
    }

    if (AuthService.role == "teachingAssistant") {
      await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'unread_ta': 0,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc('doctor_1')
        .get()
        .then((value) {
      print("exists = ${value.exists}");
      print("data = ${value.data()}");
    });
    chatId = getChatId(
      widget.currentUserId,
      widget.receiverId,
    );
    markMessagesAsSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          widget.receiverName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatId)
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var data = docs[index];

                      var messageData = data.data() as Map<String, dynamic>;

                      bool isSeen = messageData.containsKey('isSeen')
                          ? messageData['isSeen'] ?? false
                          : false;

                      return Column(
                        crossAxisAlignment:
                            data['senderId'] == widget.currentUserId
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          BubbleSpecialThree(
                            isSender: data['senderId'] == widget.currentUserId,
                            text: data['text'],
                            color: data['senderId'] == widget.currentUserId
                                ? const Color(0xFF1897F3)
                                : Colors.grey,
                            tail: true,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          if (data['senderId'] == widget.currentUserId)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 12,
                                top: 2,
                              ),
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
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFF1897F3),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFF1897F3),
                    child: IconButton(
                      onPressed: () async {
                        if (message.text.trim().isEmpty) return;

                        String text = message.text.trim();
                        message.clear();
                        await FirebaseFirestore.instance
                            .collection('chats')
                            .doc(chatId)
                            .set({
                          'participants': [
                            widget.currentUserId,
                            widget.receiverId,
                          ],
                          'participantNames': {
                            widget.currentUserId: widget.myName,
                            widget.receiverId: widget.receiverName,
                          },
                          'lastMessage': text,
                          'lastMessageTime': Timestamp.now(),
                          'unread_student': 0,
                          'unread_doctor': 0,
                          'unread_ta': 0,
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
                        await FirebaseFirestore.instance
                            .collection('notifications')
                            .add({
                          'receiverId': widget.receiverId,
                          'senderId': widget.currentUserId,
                          'senderName': widget.myName,
                          'message': text,
                          'type': 'chat',
                          'isRead': false,
                          'time': Timestamp.now(),
                        });
                        await FirebaseFirestore.instance
                            .collection('chats')
                            .doc(chatId)
                            .update({
                          'unread_doctor': FieldValue.increment(1),
                        });
                        await FirebaseFirestore.instance
                            .collection('chats')
                            .doc(chatId)
                            .update({
                          'unread_student': FieldValue.increment(1),
                        });

                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
