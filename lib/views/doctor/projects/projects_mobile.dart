import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/doctor_dashboard_service.dart';
import '../../../services/doctor_project_details_service.dart';
import '../../../services/doctor_projects_service.dart';
import '../../model/DR_project.dart';

class ProjectsMobileView extends StatefulWidget {
  const ProjectsMobileView({
    super.key,
  });

  @override
  State<ProjectsMobileView> createState() => _ProjectsMobileViewState();
}

class _ProjectsMobileViewState extends State<ProjectsMobileView>
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
    projectsFuture = DoctorProjectsService.getProjects();
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
            appBar: AppBar(
              backgroundColor: const Color(0xFF0D0F1A),
              title: const Text(
                "Projects",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  context.go('/doctorDashboard');
                },
              ),
              bottom: TabBar(
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
            ),
            body: TabBarView(
              controller: _tabController,
              children: statuses.map(
                (status) {
                  final allProjects = snapshot.data ?? [];

                  final projects = allProjects.where(
                    (project) {
                      final doctorStatus =
                          (project['doctor_status'] ?? "pending")
                              .toString()
                              .toLowerCase();

                      if (status == "Pending") {
                        return doctorStatus == "pending";
                      }

                      if (status == "Accepted") {
                        return doctorStatus == "approved";
                      }

                      return doctorStatus == "rejected";
                    },
                  ).toList();

                  return ListView.builder(
                    padding: const EdgeInsets.all(18),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 14,
                          ),
                          child: _projectCard(
                            projects[index],
                            context,
                          ));
                    },
                  );
                },
              ).toList(),
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
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                project['title'] ?? "No title",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: (project['doctor_status'] ?? "pending")
                            .toString()
                            .toLowerCase() ==
                        "approved"
                    ? Colors.green
                    : (project['doctor_status'] ?? "pending")
                                .toString()
                                .toLowerCase() ==
                            "rejected"
                        ? Colors.red
                        : Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                project['doctor_status'] ?? "No status",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                (project['team']?['members'] as List<dynamic>? ?? [])
                    .map(
                      (m) => m['name'],
                    )
                    .join(", "),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              "Date: ${project['createdAt']?.toString().substring(0, 10) ?? ""}",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          project['description'] ?? "No description",
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                context.push(
                  '/ideaDetails',
                  extra: project['_id'],
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
