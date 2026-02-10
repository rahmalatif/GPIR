import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/admin_project.dart';

class AdminApprovedProjectsView extends StatefulWidget {
  const AdminApprovedProjectsView({super.key});

  @override
  State<AdminApprovedProjectsView> createState() => _AdminApprovedProjectsViewState();
}

class _AdminApprovedProjectsViewState extends State<AdminApprovedProjectsView> {
  final List<AdminProject> approvedProjects = [
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
        title: const Text("Approved Projects" , style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: approvedProjects.length,
        itemBuilder: (context, index) {
          final project = approvedProjects[index];
          return _projectCard(project, context);
        },
      ),
    );
  }

  Widget _projectCard(AdminProject project, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              Text(project.name,
                  style: const TextStyle(color: Colors.white)),
              const Spacer(),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Approved",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text(project.team.join(", "),
              style: const TextStyle(color: Colors.grey)),
          Text("Date: ${project.date}",
              style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
