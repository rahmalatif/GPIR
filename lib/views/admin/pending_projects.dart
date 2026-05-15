import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/admin_pending_projects_service.dart';
import '../model/admin_project.dart';

class PendingProjectsView extends StatefulWidget {
  const PendingProjectsView({super.key});

  @override
  State<PendingProjectsView> createState() => _PendingProjectsViewState();
}

class _PendingProjectsViewState extends State<PendingProjectsView> {
  late Future<List<dynamic>> projectsFuture;

  @override
  void initState() {
    super.initState();

    projectsFuture = AdminPendingProjectsService.getPendingProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Pending Ideas",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              context.pop();
            }),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: projectsFuture,
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
                "No pending projects",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(18),
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: _projectCard(
                    projects[index],
                    context,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

Widget _projectCard(dynamic project, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project['title'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                (project['team_id']?['members'] as List<dynamic>? ?? [])
                    .map(
                      (m) => m['name'],
                    )
                    .join(", "),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
            project['createdAt']
                ?.toString()
                .substring(0, 4)

            ?? "",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          project['description'],
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                context.push(
                  '/adminIdeaDetails',
                  extra: project['_id'],
                );
              },
              child: const Text(
                "View",
                style: TextStyle(color: Colors.cyan),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
