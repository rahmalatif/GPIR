import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/model/doctor.dart';
import 'package:graduation_project_recommender/views/model/project.dart';

class SendIdeaToDrView extends StatelessWidget {
  final Doctor doctor;
  final ProjectIdea projectIdea;

  const SendIdeaToDrView({
    super.key,
    required this.doctor,
    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Send Idea to Doctor",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D0F1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xff4699A8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projectIdea.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    projectIdea.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Doctor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    doctor.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    doctor.track,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  Text(
                    "Teaching Assistant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Noha Ali",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "AI",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  context.go(
                    '/sendIdeaToDr',
                    extra: {
                      'projectIdea': projectIdea,
                      'doctor': doctor,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D0F1A),
                  side: const BorderSide(color: Color(0xff4699A8), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Select",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
