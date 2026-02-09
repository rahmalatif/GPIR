import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RejectIdeaView extends StatefulWidget {
  const RejectIdeaView({super.key});

  @override
  State<RejectIdeaView> createState() => _RejectIdeaViewState();
}

class _RejectIdeaViewState extends State<RejectIdeaView> {
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),

        title: const Text(
          "Reject Idea",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

             Text("Reason",
                style: TextStyle(color: Colors.white, fontSize: 16)),

             SizedBox(height: 10),

            TextField(
              controller: reasonController,
              maxLines: 3,
              style:  TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter the reason for rejecting the idea",
                hintStyle:  TextStyle(color: Colors.grey),
                filled: true,
                fillColor:  Color(0xFF1A1D2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

             SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _reasonButton("Not enough details"),
                _reasonButton("Similar to previous project"),
                _reasonButton("Out of scope"),
                _reasonButton("Needs improvement"),
              ],
            ),

             Spacer(),

            GestureDetector(
              onTap: (){
                if (reasonController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter rejection reason"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                context.push(
                  '/doctorDashboard'
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You have rejected the idea successfully"),
                    backgroundColor: Colors.cyan,
                  ),
                );
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Reject",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _reasonButton(String text) {
    return GestureDetector(
      onTap: () {
        reasonController.text = text;
    },

      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color:  Color(0xFF1A1D2E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style:  TextStyle(color: Colors.white)),
      ),
    );
  }
}
