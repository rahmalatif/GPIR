import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/admin_project.dart';

class PendingProjectsView extends StatefulWidget {
  const PendingProjectsView({super.key});

  @override
  State<PendingProjectsView> createState() => _PendingProjectsViewState();
}

class _PendingProjectsViewState extends State<PendingProjectsView> {
  final List<AdminProject> Projects = [
    AdminProject(
      id: "CS-2025-01",
      name: "Smart Attendance System",
      status: "Approved",
      date: "2025",
      team: ["Ahmed", "Sara", "Omar"],
      description: "QR based attendance system",
    ),
    AdminProject(
      id: "CS-2024-07",
      name: "Health Tracker App",
      status: "Approved",
      date: "2024",
      team: ["Laila", "Youssef"],
      description: "Daily health monitoring app",
    ),
  ];

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView.builder(
          itemCount: Projects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _projectCard(Projects[index], context),
            );
          },
        ),
      ),
    );
  }
}

Widget _projectCard(AdminProject project, BuildContext context) {
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
          project.name,
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
                project.team.join(", "),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              project.date,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          project.description,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                context.push(
                  '/adminIdeasDetails',
                  extra: project,
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
