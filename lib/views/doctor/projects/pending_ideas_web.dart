import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/DR_project.dart';

class PendingIdeasWebView
    extends StatefulWidget {
  const PendingIdeasWebView({
    super.key,
  });

  @override
  State<PendingIdeasWebView>
  createState() =>
      _PendingIdeasWebViewState();
}

class _PendingIdeasWebViewState
    extends State<PendingIdeasWebView> {
  final List<ProjectDR> projects = [
    ProjectDR(
      name:
      "Smart Attendance System",

      status: "Pending",

      date: "2024",

      team: [
        "Ahmed",
        "Sara",
        "Omar"
      ],

      description:
      "A mobile app that uses QR codes to record student attendance automatically.",

      introduction: '',

      features: [],
    ),

    ProjectDR(
      name: "Health Tracker App",

      status: "Accepted",

      date: "2024",

      team: [
        "Laila",
        "Youssef"
      ],

      description:
      "An app to monitor daily health activity and progress.",

      introduction: '',

      features: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 1200,

          child: Padding(
            padding:
            const EdgeInsets.all(
                30),

            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },

                      icon: const Icon(
                        Icons.arrow_back,
                        color:
                        Colors.white,
                      ),
                    ),

                    const SizedBox(
                        width: 10),

                    const Text(
                      "Pending Ideas",

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

                Expanded(
                  child:
                  GridView.builder(
                    itemCount:
                    projects.length,

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      2,

                      crossAxisSpacing:
                      20,

                      mainAxisSpacing:
                      20,

                      childAspectRatio:
                      1.8,
                    ),

                    itemBuilder:
                        (context,
                        index) {
                      return _projectCard(
                        projects[index],
                        context,
                      );
                    },
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

Widget _projectCard(
    ProjectDR project,
    BuildContext context,
    ) {
  return Container(
    padding:
    const EdgeInsets.all(22),

    decoration: BoxDecoration(
      color:
      const Color(0xFF1A1D2E),

      borderRadius:
      BorderRadius.circular(
          20),
    ),

    child: Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                project.name,

                style:
                const TextStyle(
                  color:
                  Colors.white,

                  fontSize: 22,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),

              decoration:
              BoxDecoration(
                color:
                project.status ==
                    "Pending"
                    ? Colors.orange
                    : Colors.green,

                borderRadius:
                BorderRadius.circular(
                    20),
              ),

              child: Text(
                project.status,

                style:
                const TextStyle(
                  color:
                  Colors.white,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Text(
          project.team.join(", "),

          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Date: ${project.date}",

          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 14),

        Expanded(
          child: Text(
            project.description,

            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ),

        Align(
          alignment:
          Alignment.centerRight,

          child: TextButton(
            onPressed: () {
              context.push(
                '/ideaDetails',
                extra: project,
              );
            },

            child: const Text(
              "View",

              style: TextStyle(
                color: Colors.cyan,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}