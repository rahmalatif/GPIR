import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/doctor.dart';
import '../model/project.dart';

class ConfirmSubmissionView extends StatelessWidget {
  final Doctor doctor;
  final ProjectIdea projectIdea;

  const ConfirmSubmissionView({
    super.key,
    required this.doctor,
    required this.projectIdea, required List teamMembers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "Confirm Submission",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "You are about to submit your graduation project for approval.\nPlease confirm the details below.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xff4699A8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      projectIdea.name,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),


                  Row(
                    children: [
                      const Text(
                        "Team Members",
                        style: TextStyle(color: Colors.grey),
                      ),

                  const SizedBox(width: 30),

                  Column(

                    children: projectIdea.teamMembers.map((member) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          "• $member",
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
]
                  ),
                  const SizedBox(height: 20),


                  Row(
                    children: [
                      const Text(
                        "Doctor: ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        doctor.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),


                  const Row(
                    children: [
                      Text(
                        "Teaching Assistant: ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        "Eng/ Noha Ali",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Project submitted successfully ✅"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  context.go('/studentDashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4699A8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),


            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xff4699A8)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Edit",
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
