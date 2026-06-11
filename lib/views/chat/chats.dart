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
  void initState() {
    super.initState();

    FirebaseFirestore.instance.collection('users').get().then((value) {
      print("USERS COUNT = ${value.docs.length}");

      for (var doc in value.docs) {
        print("DOC ID = ${doc.id}");
        print("DATA = ${doc.data()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("CURRENT USER ID = ${AuthService.userId}");
    print("CURRENT ROLE = ${AuthService.role}");
    print("CURRENT NAME = ${AuthService.name}");
    if (currentUserId == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0F1A),
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
              .where(
                'participants',
                arrayContains: currentUserId!,
              )
              .orderBy(
                'lastMessageTime',
                descending: true,
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);

              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No Chats Yet",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            var chats = snapshot.data!.docs;
            print("CURRENT USER = $currentUserId");
            print("CHATS COUNT = ${chats.length}");

            for (var chat in chats) {
              print(chat.data());
            }
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                var chat = chats[index];
                String chatId = chat.id;

                List participants = chat['participants'];

                final otherUsers =
                    participants.where((id) => id != currentUserId).toList();

                if (otherUsers.isEmpty) {
                  return const SizedBox();
                }

                String otherUserId = otherUsers.first;

                Map<String, dynamic> names = Map<String, dynamic>.from(
                  chat['participantNames'],
                );

                DateTime time = (chat['lastMessageTime'] as Timestamp).toDate();

                String formattedTime =
                    "${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}";

                int unreadCount = 0;

                if (AuthService.role == "student") {
                  unreadCount = chat['unread_student'] ?? 0;
                }

                if (AuthService.role == "doctor") {
                  unreadCount = chat['unread_doctor'] ?? 0;
                }

                if (AuthService.role == "ta" ||
                    AuthService.role == "teachingAssistant") {
                  unreadCount = chat['unread_ta'] ?? 0;
                }

                return Card(
                  color: const Color(0xFF1B1E2B),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF1897F3),
                      child: Text(
                        (names[otherUserId] ?? "U")
                            .toString()
                            .substring(0, 1)
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      names[otherUserId] ?? otherUserId,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      chat['lastMessage'] ?? '',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedTime,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        if (unreadCount > 0)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "$unreadCount",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChattingView(
                                  currentUserId: AuthService.userId!,
                                  myName: AuthService.name!,
                                  receiverId: otherUserId,
                                  receiverName: names[otherUserId] ?? "User",
                                )),
                      );
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
