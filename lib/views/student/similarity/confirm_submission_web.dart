import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/doctor.dart';
import '../../model/project.dart';

class ConfirmSubmissionWebView
    extends StatelessWidget {
  final Doctor doctor;
  final ProjectIdea projectIdea;

  const ConfirmSubmissionWebView({
    super.key,
    required this.doctor,
    required this.projectIdea,
    required List teamMembers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 900,

          child: Padding(
            padding:
            const EdgeInsets.all(30),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),

                      onPressed: () =>
                          Navigator.pop(
                              context),
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      "Confirm Submission",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Center(
                  child: Text(
                    "You are about to submit your graduation project for approval.\nPlease confirm the details below.",

                    textAlign:
                    TextAlign.center,

                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(
                      24),

                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(
                        16),

                    border: Border.all(
                      color: const Color(
                          0xff4699A8),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [
                      Center(
                        child: Text(
                          projectIdea.name,

                          style:
                          const TextStyle(
                            fontSize: 28,
                            color:
                            Colors.white,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      const Row(
                        children: [
                          Text(
                            "Team Members",

                            style:
                            TextStyle(
                              color:
                              Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 30),

                      Row(
                        children: [
                          const Text(
                            "Doctor: ",

                            style:
                            TextStyle(
                              color:
                              Colors.grey,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(
                              width: 50),

                          Text(
                            doctor.name,

                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 15),

                      const Row(
                        children: [
                          Text(
                            "Teaching Assistant: ",

                            style:
                            TextStyle(
                              color:
                              Colors.grey,
                              fontSize: 18,
                            ),
                          ),

                          SizedBox(width: 30),

                          Text(
                            "Eng/ Noha Ali",

                            style:
                            TextStyle(
                              color:
                              Colors.white,
                              fontSize: 18,
                            ),
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
                    onPressed: () async {
                      print(
                        "CONFIRM INTRO = ${projectIdea.introduction}",
                      );

                      print(
                        "DOCTOR UID = ${doctor.uid}",
                      );

                      final projectDoc =
                      await FirebaseFirestore
                          .instance
                          .collection(
                          "projects")
                          .add({
                        "name":
                        projectIdea.name,

                        "problem":
                        projectIdea
                            .specializations,

                        "introduction":
                        projectIdea
                            .introduction,

                        "doctorId":
                        doctor.uid,

                        "status":
                        "pending",

                        "createdAt":
                        FieldValue
                            .serverTimestamp(),
                      });

                      await FirebaseFirestore
                          .instance
                          .collection(
                          "notifications")
                          .add({
                        "userId":
                        doctor.uid,

                        "title":
                        "New Project Idea 📚",

                        "body":
                        projectIdea
                            .introduction,

                        "projectName":
                        projectIdea.name,

                        "projectId":
                        projectDoc.id,

                        "type":
                        "new_project",

                        "seen": false,

                        "createdAt":
                        Timestamp.now(),
                      });

                      ScaffoldMessenger.of(
                          context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Project submitted successfully ✅",
                          ),

                          backgroundColor:
                          Colors.green,
                        ),
                      );

                      context.go(
                        '/studentDashboard',
                      );
                    },

                    style:
                    ElevatedButton
                        .styleFrom(
                      backgroundColor:
                      const Color(
                          0xff4699A8),

                      padding:
                      const EdgeInsets
                          .symmetric(
                        vertical: 18,
                      ),

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            12),
                      ),
                    ),

                    child: const Text(
                      "Submit",

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}