import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/admin_dashboard_sevices.dart';

class AdminApprovedProjectsView extends StatefulWidget {
  const AdminApprovedProjectsView({
    super.key,
  });

  @override
  State<AdminApprovedProjectsView> createState() =>
      _AdminApprovedProjectsViewState();
}

class _AdminApprovedProjectsViewState extends State<AdminApprovedProjectsView> {
  late Future<List<dynamic>> ongoingProjectsFuture;

  @override
  void initState() {
    super.initState();

    ongoingProjectsFuture = getOngoingProjects();
  }

  Future<List<dynamic>> getOngoingProjects() async {
    final data = await AdminDashboardService.getDashboard();

    return data['ongoingProjects'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Approved Projects",
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
            context.pop();
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ongoingProjectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final projects = snapshot.data ?? [];

          if (projects.isEmpty) {
            return const Center(
              child: Text(
                "No approved projects",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];

              return _projectCard(
                project,
                context,
              );
            },
          );
        },
      ),
    );
  }

  Widget _projectCard(
    dynamic project,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  project['title'] ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: const Text(
                  "Approved",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            (project['team_id']?['members'] as List<dynamic>? ?? [])
                .map(
                  (m) => m['name'],
                )
                .join(", "),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            "Date: "
            "${project['createdAt']?.toString().substring(0, 10) ?? ""}",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
