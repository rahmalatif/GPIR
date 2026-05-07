import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/DR_project.dart';
import '../../model/user_model.dart';

class DashboardMobileView extends StatelessWidget {
  final UserModel user;

  const DashboardMobileView({
    super.key,
    required this.user,
  });

  String greeting(String name) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning,\nDr. $name';
    }

    if (hour < 17) {
      return 'Good Afternoon,\nDr. $name';
    }

    return 'Good Evening,\nDr. $name';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),

        title: Text(
          greeting(user.name),

          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              context.go('/doctorNotifications');
            },

            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [
            const SizedBox(height: 30),

            Row(
              children: [
                _projectcard(
                  "Pending projects",
                  "7",
                  context,
                ),

                const SizedBox(width: 12),

                _projectcard(
                  "Accepted",
                  "3",
                  context,
                ),
              ],
            ),

            const SizedBox(height: 15),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search',

                hintStyle:
                const TextStyle(
                  color: Colors.grey,
                ),

                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),

                filled: true,

                fillColor:
                const Color(
                    0xFF1A1D2E),

                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                      14),

                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment:
              Alignment.centerLeft,

              child: Text(
                "Recent Ideas",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: [
                  _projects(
                    "Pending",
                    "Smart Attendance System",
                    "2024",
                    [
                      "Ahmed",
                      "Sara",
                      "Omar"
                    ],
                    context,
                  ),

                  const SizedBox(height: 12),

                  _projects(
                    "Accepted",
                    "Health Tracker App",
                    "2024",
                    [
                      "Laila",
                      "Youssef"
                    ],
                    context,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Buttons(
                  "View Ideas",
                      () {
                    context.push(
                      '/drPendingIdeas',
                    );
                  },
                ),

                const SizedBox(width: 12),

                Buttons(
                  "Add Ideas",
                      () {
                    context.push(
                      '/addIdea',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _projectcard(
      String projectType,
      String number,
      BuildContext context,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.push(
            '/doctorProjects',
          );
        },

        child: Container(
          height: 100,

          padding:
          const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color:
            const Color(
                0xFF1A1D2E),

            borderRadius:
            BorderRadius.circular(
                18),
          ),

          child: Column(
            children: [
              Text(
                number,

                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 14,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 10),

              Text(
                projectType,

                textAlign:
                TextAlign.center,

                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 14,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projects(
      String status,
      String name,
      String date,
      List<String> team,
      BuildContext context,
      ) {
    return Container(
      width: 320,
      height: 150,

      padding:
      const EdgeInsets.all(18),

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
        CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,

                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                  ),
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration:
                BoxDecoration(
                  color: status ==
                      "Pending"
                      ? Colors.orange
                      : Colors.green,

                  borderRadius:
                  BorderRadius.circular(
                      20),
                ),

                child: Text(
                  status,

                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            team.join(", "),

            style:
            const TextStyle(
              color: Colors.grey,
            ),
          ),

          Row(
            children: [
              Text(
                "Date: $date",

                style:
                const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const Spacer(),

              TextButton(
                onPressed: () {
                  final project =
                  ProjectDR(
                    name: name,
                    status: status,
                    date: date,
                    team: team,
                    description:
                    "This project helps track health data for users.",
                    introduction: '',
                    features: [],
                  );

                  context.push(
                    '/ideaDetails',
                    extra: project,
                  );
                },

                child: const Text(
                  "View",

                  style: TextStyle(
                    color: Colors.cyan,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Buttons(
      String text,
      VoidCallback onTap,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 48,

          decoration: BoxDecoration(
            color:
            const Color(
                0xFF1A1D2E),

            borderRadius:
            BorderRadius.circular(
                14),
          ),

          child: Center(
            child: Text(
              text,

              style:
              const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}