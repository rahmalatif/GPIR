/*import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

import '../../model/chatModel.dart';

class ChattingView extends StatefulWidget {
  const ChattingView({super.key});

  @override
  State<ChattingView> createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  TextEditingController message = TextEditingController();

  String myName = 'Ahmed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: Text(
          "Chat2",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: Chat.length,
                itemBuilder: (_, index) => BubbleSpecialThree(
                  isSender: Chat[index].senderName == myName ? true : false,
                  text: Chat[index].text.toString(),
                  color: Chat[index].senderName == myName
                      ? const Color(0xFF1897F3)
                      : Colors.grey,
                  tail: true,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              color: Colors.white,
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: message,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Chat.add(ChatModel(message.text, myName));
                          message.text = '';
                        });
                      },
                      icon: Icon(
                        Icons.send,
                        color: Color(0xFF1897F3),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/