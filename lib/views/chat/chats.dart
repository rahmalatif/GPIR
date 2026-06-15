import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import 'chatting.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  String get currentUserId => AuthService.userId ?? "";

  @override
  Widget build(BuildContext context) {
    if (currentUserId.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D0F1A),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF1897F3)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "Chats",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participants', arrayContains: currentUserId)
            .orderBy('lastMessageTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF1897F3)),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Chats Yet",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          var chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              var chat = chats[index].data() as Map<String, dynamic>;

              List participants = chat['participants'] ?? [];
              final otherUsers = participants.where((id) => id != currentUserId).toList();

              if (otherUsers.isEmpty) {
                return const SizedBox();
              }

              String otherUserId = otherUsers.first;

              Map<String, dynamic> names = Map<String, dynamic>.from(
                chat['participantNames'] ?? {},
              );

              String otherUserName = names[otherUserId] ?? "User";

              String formattedTime = "";
              if (chat['lastMessageTime'] != null) {
                DateTime time = (chat['lastMessageTime'] as Timestamp).toDate();
                int hour = time.hour;
                String period = "AM";
                if (hour >= 12) {
                  period = "PM";
                  if (hour > 12) hour -= 12;
                }
                if (hour == 0) hour = 12;

                formattedTime = "$hour:${time.minute.toString().padLeft(2, '0')} $period";
              }

              int unreadCount = 0;
              String? role = AuthService.role?.toLowerCase();
              String? lastMessageSenderId = chat['lastMessageSenderId'];

              if (lastMessageSenderId != currentUserId) {
                if (role == "student") {
                  unreadCount = chat['unread_student'] ?? 0;
                } else if (role == "doctor") {
                  unreadCount = chat['unread_doctor'] ?? 0;
                } else if (role == "ta" || role == "teachingassistant") {
                  unreadCount = chat['unread_ta'] ?? 0;
                }
              }

              return Card(
                color: const Color(0xFF1B1E2B),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFF1897F3),
                    child: Text(
                      otherUserName.isNotEmpty
                          ? otherUserName.substring(0, 1).toUpperCase()
                          : "U",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  title: Text(
                    otherUserName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      chat['lastMessage'] ?? '',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formattedTime,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                        ),
                        if (unreadCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                "$unreadCount",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        else
                          const SizedBox(height: 18),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChattingView(
                          currentUserId: currentUserId,
                          myName: AuthService.name ?? "Me",
                          receiverId: otherUserId,
                          receiverName: otherUserName,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}