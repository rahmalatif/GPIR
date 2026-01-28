import 'package:flutter/material.dart';

class AiRecommendView extends StatefulWidget {
  const AiRecommendView({super.key});

  @override
  State<AiRecommendView> createState() => _AiRecommendViewState();
}

class _AiRecommendViewState extends State<AiRecommendView> {
  int teamSize = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F1A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF0D0F1A),
        title: Text(
          "AI Recommender",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Tell us about your team",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "The AI will suggest Project  idea based on\nyour team specialization",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              width: 350,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyanAccent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Team Size",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Row(
                    children: [
                      _buildButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (teamSize > 1) {
                            setState(() {
                              teamSize--;
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          teamSize.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildButton(
                        icon: Icons.add,
                        onTap: () {
                          setState(() {
                            teamSize++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.cyanAccent),
      ),
      child: Icon(
        icon,
        size: 16,
        color: Colors.white,
      ),
    ),
  );
}
