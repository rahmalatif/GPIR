import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/DR_project.dart';

class ProjectsWebView
    extends StatefulWidget {
  const ProjectsWebView({
    super.key,
  });

  @override
  State<ProjectsWebView>
  createState() =>
      _ProjectsWebViewState();
}

class _ProjectsWebViewState
    extends State<ProjectsWebView>
    with
        SingleTickerProviderStateMixin {
  late TabController
  _tabController;

  final List<String> statuses = [
    "Pending",
    "Accepted",
    "Rejected"
  ];

  final List<ProjectDR>
  allProjects = [
    ProjectDR(
      name:
      "Smart Attendance System",

      description:
      "QR & face based attendance system",

      date: "14 April 2025",

      status: "Pending",

      team: ["Rahma"],

      introduction: '',

      features: [],
    ),

    ProjectDR(
      name: "Health Tracker",

      description:
      "Track daily health data",

      date: "10 April 2025",

      status: "Accepted",

      team: [
        "Laila",
        "Youssef"
      ],

      introduction: '',

      features: [],
    ),

    ProjectDR(
      name: "AI Tutor",

      description:
      "Smart learning assistant",

      date: "5 April 2025",

      status: "Rejected",

      team: ["Omar"],

      introduction: '',

      features: [],
    ),
  ];

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(
          length: 3,
          vsync: this,
        );
  }

  List<ProjectDR>
  filteredProjects(
      String status,
      ) {
    return allProjects
        .where(
          (p) =>
      p.status ==
          status,
    )
        .toList();
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(
          0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 1200,

          child: Padding(
            padding:
            const EdgeInsets
                .all(30),

            child: Column(
              children: [
                const Align(
                  alignment:
                  Alignment
                      .centerLeft,

                  child: Text(
                    "Projects",

                    style:
                    TextStyle(
                      color: Colors
                          .white,

                      fontSize: 32,

                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                TabBar(
                  labelColor:
                  Colors.white,

                  controller:
                  _tabController,

                  indicatorColor:
                  Colors.cyan,

                  tabs: const [
                    Tab(
                      text:
                      "Pending",
                    ),

                    Tab(
                      text:
                      "Accepted",
                    ),

                    Tab(
                      text:
                      "Rejected",
                    ),
                  ],
                ),

                const SizedBox(
                    height: 20),

                Expanded(
                  child:
                  TabBarView(
                    controller:
                    _tabController,

                    children:
                    statuses
                        .map(
                          (
                          status,
                          ) {
                        final projects =
                        filteredProjects(
                          status,
                        );

                        return GridView
                            .builder(
                          itemCount:
                          projects
                              .length,

                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                            2,

                            crossAxisSpacing:
                            20,

                            mainAxisSpacing:
                            20,

                            childAspectRatio:
                            2,
                          ),

                          itemBuilder:
                              (
                              context,
                              index,
                              ) {
                            return _projectCard(
                              projects[
                              index],
                              context,
                            );
                          },
                        );
                      },
                    ).toList(),
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
    const EdgeInsets.all(
        22),

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
      CrossAxisAlignment
          .start,

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
                    : project.status ==
                    "Accepted"
                    ? Colors.green
                    : Colors.red,

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

        const SizedBox(
            height: 12),

        Text(
          project.team.join(
              ", "),

          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),

        const SizedBox(
            height: 10),

        Text(
          "Date: ${project.date}",

          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

        const SizedBox(
            height: 12),

        Expanded(
          child: Text(
            project.description,

            style:
            const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ),

        Align(
          alignment:
          Alignment
              .centerRight,

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
                color:
                Colors.cyan,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}