import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/doctor.dart';
import '../model/project.dart';

class ConfirmSubmissionView extends StatelessWidget {
  final Doctor doctor;

  final ProjectIdea projectIdea;
  final List<String> teamMembers;

  const ConfirmSubmissionView(
      {
        super.key,
      required this.doctor,
      required this.projectIdea,
      required this.teamMembers
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: Text(
          "Confirm Submission",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Your are about to submit your graduation \nproject for approval. please confirm the                       \ndetails below.",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 330,
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
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        "Team Members",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: projectIdea.teamMembers.map((member) {
                          return Text(
                            member,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          );
                        }).toList(),
                      ),

                    ],
                  ),

                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text("Supervisor" , style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),),
                          Text(
                              doctor.name,
                          ),
                    ],
                  ),

                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text("Teaching Assistant" , style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),),
                      Text(
                        "Eng/ Noha Ali"
                      ),
                    ],
                  ),

                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(
                            '/confirmSubmission', extra: {
                          'doctor': doctor,
                          'projectIdea': projectIdea,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4699A8),
                        side: const BorderSide(color: Color(0xff4699A8), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "submit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 10,),

                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/confirmSubmission', extra: {
                          'doctor': doctor,
                          'projectIdea': projectIdea,
                        });
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
          ],
        ),
      ),
    );
  }
}
