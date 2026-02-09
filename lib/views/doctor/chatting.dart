import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../model/message.dart';

class ChattingView extends StatefulWidget {
  const ChattingView({super.key});

  @override
  State<ChattingView> createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  List<Message> messages= [

    Message(
      text: "Hello, have you chosen your project topic?",
      date: DateTime.now().subtract(const Duration(days: 8, minutes: 15)),
      isSentByMe: false, // Doctor
    ),

    Message(
      text: "Yes doctor, I selected the AI attendance system",
      date: DateTime.now().subtract(const Duration(days: 8, minutes: 10)),
      isSentByMe: true, // Student
    ),

    Message(
      text: "Good choice 👍 Can you send me the proposal?",
      date: DateTime.now().subtract(const Duration(days: 7, minutes: 50)),
      isSentByMe: false,
    ),

    Message(
      text: "Sure, I'll upload it today",
      date: DateTime.now().subtract(const Duration(days: 7, minutes: 45)),
      isSentByMe: true,
    ),

    Message(
      text: "Make sure to include system architecture",
      date: DateTime.now().subtract(const Duration(days: 6, minutes: 30)),
      isSentByMe: false,
    ),

    Message(
      text: "Okay doctor 👍",
      date: DateTime.now().subtract(const Duration(days: 6, minutes: 25)),
      isSentByMe: true,
    ),

    Message(
      text: "Any progress so far?",
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 40)),
      isSentByMe: false,
    ),

    Message(
      text: "Yes, backend part is almost finished",
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 35)),
      isSentByMe: true,
    ),

    Message(
      text: "Excellent work 👏",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 20)),
      isSentByMe: false,
    ),

    Message(
      text: "Thank you doctor!",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 15)),
      isSentByMe: true,
    ),

    Message(
      text: "Let's schedule a meeting tomorrow",
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 30)),
      isSentByMe: false,
    ),

    Message(
      text: "Sure, I'm available after 3 PM",
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 25)),
      isSentByMe: true,
    ),

  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {

            if (messages.isNotEmpty) {
              context.pop(messages.last.text);
            } else {
              context.pop();
            }
          },
        ),
        title: const Center(
          child: Text(
            "Chatting with Rahma",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              reverse: false,
              order: GroupedListOrder.ASC,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (message) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade700,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      DateFormat('EEEE, d MMM yyyy').format(message.date),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: message.isSentByMe
                        ? Colors.blueAccent
                        : Colors.grey.shade800,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: message.isSentByMe
                          ? const Radius.circular(12)
                          : Radius.zero,
                      bottomRight: message.isSentByMe
                          ? Radius.zero
                          : const Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) return;
                    final text = _controller.text;
                    final message = Message(
                      text: text,
                      date: DateTime.now(),
                      isSentByMe: true,
                    );
                    setState(() {
                      messages.add(message);
                    });
                    _controller.clear();
                    _scrollToBottom();
                    Navigator.pop(context, text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
