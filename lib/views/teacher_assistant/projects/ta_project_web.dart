import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/doctor_dashboard_service.dart';
import '../../../services/doctor_project_details_service.dart';
import '../../../services/doctor_projects_service.dart';
import '../../../services/ta_project_service.dart';
import '../../model/DR_project.dart';

class TAProjectsWebView extends StatefulWidget {
  const TAProjectsWebView({
    super.key,
  });

  @override
  State<TAProjectsWebView> createState() => _ProjectsWebViewState();
}

class _ProjectsWebViewState extends State<TAProjectsWebView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> statuses = ["Pending", "Accepted", "Rejected"];

  late Future<List<dynamic>> projectsFuture;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    projectsFuture = TAProjectsService.getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Color(0xFF0D0F1A),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Scaffold(
              backgroundColor: Color(0xFF0D0F1A),
              body: Center(
                child: Text(
                  "No project data",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: const Color(0xFF0D0F1A),
            body: Center(
              child: SizedBox(
                width: 1200,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Projects",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TabBar(
                        labelColor: Colors.white,
                        controller: _tabController,
                        indicatorColor: Colors.cyan,
                        tabs: const [
                          Tab(
                            text: "Pending",
                          ),
                          Tab(
                            text: "Accepted",
                          ),
                          Tab(
                            text: "Rejected",
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: statuses.map(
                                (
                                status,
                                ) {
                              final allProjects = snapshot.data ?? [];

                              final projects = allProjects.where(
                                    (project) {
                                      final taStatus =
                                      (project['ta_status']
                                          ?? "pending")
                                      .toString()
                                      .toLowerCase();

                                  if (status == "Pending") {
                                    return taStatus == "pending";
                                  }

                                  if (status == "Accepted") {
                                    return taStatus == "approved";
                                  }

                                  return taStatus == "rejected";
                                },
                              ).toList();

                              return GridView.builder(
                                itemCount: projects.length,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 2,
                                ),
                                itemBuilder: (
                                    context,
                                    index,
                                    ) {
                                  return _projectCard(
                                    projects[index],
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
        });
  }
}

Widget _projectCard(
    dynamic project,
    BuildContext context,
    ) {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                project['title'] ?? "no title",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: (project['ta_status'] ?? "pending")
                    .toString()
                    .toLowerCase() ==
                    "approved"
                    ? Colors.green
                    : (project['ta_status'] ?? "pending")
                    .toString()
                    .toLowerCase() ==
                    "rejected"
                    ? Colors.red
                    : Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                project['ta_status'] ?? "no status",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          (project['team']?['members'] as List<dynamic>? ?? [])
              .map(
                (m) => m['name'],
          )
              .join(", "),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Date: ${project['createdAt']?.toString().substring(0, 10) ?? ""}",
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Text(
            project['description'] ?? "no desc",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              context.push(
                '/taIdeaDetails',
                extra: project['_id'],
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
