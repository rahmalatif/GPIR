import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/notification_service.dart';
import '../../model/DR_project.dart';

const String adminId =
    "5gEv2R4GauTSjXbALR0RxJX6AG63";

class ProjectDetailsWebView
    extends StatelessWidget {
  final String? projectId;
  final ProjectDR? project;

  const ProjectDetailsWebView({
    super.key,
    this.projectId,
    this.project,
  });

  String _getStatus(
      Map<String, dynamic>? data) {
    if (project != null) {
      return project!.status
          .toLowerCase();
    }

    return (data?["status"] ?? "")
        .toString()
        .toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    if (project != null) {
      return _buildProjectView(
        context,
        {
          "name": project!.name,
          "problem":
          project!.description,
          "introduction":
          project!
              .introduction,
          "teamMembers":
          project!.team,
          "status":
          project!.status,
        },
      );
    }

    return StreamBuilder<
        DocumentSnapshot>(
      stream: FirebaseFirestore
          .instance
          .collection("projects")
          .doc(projectId)
          .snapshots(),

      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(
              child:
              CircularProgressIndicator(),
            ),
          );
        }

        final data = snapshot
            .data!
            .data()
        as Map<String, dynamic>;

        return _buildProjectView(
          context,
          data,
        );
      },
    );
  }

  Widget _buildProjectView(
      BuildContext context,
      Map<String, dynamic> data,
      ) {
    final status =
    _getStatus(data);

    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 1000,

          child:
          SingleChildScrollView(
            padding:
            const EdgeInsets
                .all(30),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          context.pop(),

                      icon: const Icon(
                        Icons
                            .arrow_back,
                        color:
                        Colors.white,
                      ),
                    ),

                    const SizedBox(
                        width: 10),

                    const Text(
                      "View Idea Details",

                      style: TextStyle(
                        color:
                        Colors.white,

                        fontSize: 32,

                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                    height: 30),

                Text(
                  data["name"] ??
                      "",

                  style:
                  const TextStyle(
                    color:
                    Colors.white,

                    fontSize: 30,

                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),

                const SizedBox(
                    height: 25),

                _section(
                  "Problem",
                  data["problem"] ??
                      "—",
                ),

                const SizedBox(
                    height: 20),

                _section(
                  "Introduction",
                  data["introduction"] ??
                      "",
                ),

                const SizedBox(
                    height: 20),

                _teamSection(
                  List<String>.from(
                    data["teamMembers"] ??
                        [],
                  ),
                ),

                const SizedBox(
                    height: 40),

                if (status.contains(
                    "pending"))
                  Row(
                    children: [
                      Expanded(
                        child:
                        GestureDetector(
                          onTap:
                              () async {
                            if (projectId !=
                                null) {
                              await FirebaseFirestore
                                  .instance
                                  .collection(
                                  "projects")
                                  .doc(
                                  projectId)
                                  .update({
                                "status":
                                "accepted"
                              });

                              await FirebaseFirestore
                                  .instance
                                  .collection(
                                  "notifications")
                                  .add({
                                "userId":
                                data[
                                "studentId"],

                                "title":
                                "Project Accepted 🎉",

                                "body":
                                "Your project has been accepted by the supervisor",

                                "type":
                                "project_accepted",

                                "projectId":
                                projectId,

                                "seen":
                                false,

                                "createdAt":
                                Timestamp.now(),
                              });
                            }

                            ScaffoldMessenger.of(
                                context)
                                .showSnackBar(
                              const SnackBar(
                                content:
                                Text(
                                  "Project Accepted ✅",
                                ),

                                backgroundColor:
                                Colors.green,
                              ),
                            );

                            context.pop();
                          },

                          child:
                          _actionBtn(
                            "Accept",
                            Colors.green,
                          ),
                        ),
                      ),

                      const SizedBox(
                          width: 20),

                      Expanded(
                        child:
                        GestureDetector(
                          onTap:
                              () async {
                            if (projectId !=
                                null) {
                              await FirebaseFirestore
                                  .instance
                                  .collection(
                                  "projects")
                                  .doc(
                                  projectId)
                                  .update({
                                "status":
                                "rejected"
                              });

                              await NotificationService
                                  .send(
                                userId: data[
                                "studentId"],

                                title:
                                "Project Rejected ❌",

                                body:
                                "Your graduation project was rejected by the supervisor",

                                type:
                                "project_status",

                                projectId:
                                projectId!,
                              );
                            }

                            ScaffoldMessenger.of(
                                context)
                                .showSnackBar(
                              const SnackBar(
                                content:
                                Text(
                                  "Project Rejected ❌",
                                ),

                                backgroundColor:
                                Colors.red,
                              ),
                            );

                            context.pop();
                          },

                          child:
                          _actionBtn(
                            "Reject",
                            Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionBtn(
      String text,
      Color color,
      ) {
    return Container(
      height: 55,

      decoration: BoxDecoration(
        color: color,

        borderRadius:
        BorderRadius.circular(
            16),
      ),

      child: Center(
        child: Text(
          text,

          style:
          const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _section(
      String title,
      String text,
      ) {
    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color:
        const Color(
            0xFF1A1D2E),

        borderRadius:
        BorderRadius.circular(
            18),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,

        children: [
          Text(
            title,

            style:
            const TextStyle(
              color:
              Colors.white,
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 10),

          Text(
            text,

            style:
            const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamSection(
      List<String> team) {
    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color:
        const Color(
            0xFF1A1D2E),

        borderRadius:
        BorderRadius.circular(
            18),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,

        children: [
          const Text(
            "Team Members",

            style: TextStyle(
              color:
              Colors.white,
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 10),

          ...team.map(
                (name) => Padding(
              padding:
              const EdgeInsets
                  .only(
                bottom: 8,
              ),

              child: Text(
                name,

                style:
                const TextStyle(
                  color:
                  Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}