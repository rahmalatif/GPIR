import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/DR_project.dart';
import '../../model/user_model.dart';

class DashboardWebView extends StatelessWidget {
  final UserModel user;

  const DashboardWebView({
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
                    Expanded(
                      child: Text(
                        greeting(
                          user.name,
                        ),

                        style:
                        const TextStyle(
                          color:
                          Colors.white,
                          fontSize: 32,
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        context.go(
                          '/doctorNotifications',
                        );
                      },

                      icon: const Icon(
                        Icons
                            .notifications,
                        color:
                        Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                    height: 30),

                Row(
                  children: [
                    Expanded(
                      child:
                      _projectcard(
                        "Pending projects",
                        "7",
                        context,
                      ),
                    ),

                    const SizedBox(
                        width: 20),

                    Expanded(
                      child:
                      _projectcard(
                        "Accepted",
                        "3",
                        context,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                    height: 25),

                TextField(
                  decoration:
                  InputDecoration(
                    hintText:
                    'Search',

                    hintStyle:
                    const TextStyle(
                      color:
                      Colors.grey,
                    ),

                    prefixIcon:
                    const Icon(
                      Icons.search,
                      color:
                      Colors.grey,
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

                const SizedBox(
                    height: 30),

                const Align(
                  alignment:
                  Alignment
                      .centerLeft,

                  child: Text(
                    "Recent Ideas",

                    style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 24,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing:
                    20,
                    mainAxisSpacing:
                    20,
                    childAspectRatio:
                    2.2,

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

                const SizedBox(
                    height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Buttons(
                        "View Ideas",
                            () {
                          context.push(
                            '/drPendingIdeas',
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                        width: 20),

                    Expanded(
                      child: Buttons(
                        "Add Ideas",
                            () {
                          context.push(
                            '/addIdea',
                          );
                        },
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

  Widget _projectcard(
      String projectType,
      String number,
      BuildContext context,
      ) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/doctorProjects',
        );
      },

      child: Container(
        height: 140,

        padding:
        const EdgeInsets.all(24),

        decoration: BoxDecoration(
          color:
          const Color(
              0xFF1A1D2E),

          borderRadius:
          BorderRadius.circular(
              20),
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Text(
              number,

              style:
              const TextStyle(
                color: Colors.cyan,
                fontSize: 30,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 12),

            Text(
              projectType,

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                color: Colors.cyan,
                fontSize: 18,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
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
      padding:
      const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color:
        const Color(
            0xFF1A1D2E),

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
                  name,

                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize: 20,
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

          const SizedBox(
              height: 10),

          Text(
            team.join(", "),

            style:
            const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          const Spacer(),

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
                    fontSize: 16,
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
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 55,

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
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}