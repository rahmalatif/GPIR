import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/DR_project.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  final List<String> statuses = ["Pending", "Accepted", "Rejected"];

  final List<ProjectDR> allProjects = [
    ProjectDR(
      name: "Smart Attendance System",
      description: "QR & face based attendance system",
      date: "14 April 2025",
      status: "Pending",
      team: ["Rahma"], introduction: '', features: [],
    ),
    ProjectDR(
      name: "Health Tracker",
      description: "Track daily health data",
      date: "10 April 2025",
      status: "Accepted",
      team: ["Laila", "Youssef"], introduction: '', features: [],
    ),
    ProjectDR(
      name: "AI Tutor",
      description: "Smart learning assistant",
      date: "5 April 2025",
      status: "Rejected",
      team: ["Omar"], introduction: '', features: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<ProjectDR> filteredProjects(String status) {
    return allProjects.where((p) => p.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Projects",
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          labelColor: Colors.white,
          controller: _tabController,
          indicatorColor: Colors.cyan,
          tabs: const [
            Tab(text: "Pending" , ),
            Tab(text: "Accepted"),
            Tab(text: "Rejected"),
          ],
        ),
      ),
      body: TabBarView(

        controller: _tabController,
        children: statuses.map((status) {
          final projects = filteredProjects(status);

          return ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return _projectCard(projects[index], context);
            },
          );
        }).toList(),
      ),
    );
  }
}

Widget _projectCard(ProjectDR project, BuildContext context) {
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
            Text(project.name, style: const TextStyle(color: Colors.white)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: project.status == "Pending"
              ? Colors.orange
                  : project.status == "Accepted"
              ? Colors.green
                : Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(project.status,
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(project.team.join(", "),
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(width: 15),
            Text("Date: ${project.date}",
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
        Text(project.description,
            style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                context.push('/ideaDetails', extra: project);
              },
              child: const Text("View", style: TextStyle(color: Colors.cyan)),
            ),
          ],
        ),
      ],
    ),
  );
}
