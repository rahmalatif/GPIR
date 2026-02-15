import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/model/DR_project.dart';

class PendingIdeasView extends StatefulWidget {
  const PendingIdeasView({super.key});

  @override
  State<PendingIdeasView> createState() => _PendingIdeasViewState();
}

class _PendingIdeasViewState extends State<PendingIdeasView> {
  final List<ProjectDR> projects = [
    ProjectDR(
      name: "Smart Attendance System",
      status: "Pending",
      date: "2024",
      team: ["Ahmed", "Sara", "Omar"],
      description:
          "A mobile app that uses QR codes to record student attendance automatically.", introduction: '', features: [],
    ),
    ProjectDR(
      name: "Health Tracker App",
      status: "Accepted",
      date: "2024",
      team: ["Laila", "Youssef"],
      description: "An app to monitor daily health activity and progress.", introduction: '', features: [],
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
        child: Column(
          children: [
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _projectCard(projects[index], context),
                  );
                },
              ),
            ),
          ],
        ),
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
            Text(
              project.name,
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: project.status == "Pending"
                    ? Colors.orange
                    : Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                project.status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            Text(
              project.team.join(", "),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 15),
            Text(
              "Date: ${project.date}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Text(
          project.description,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),

        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                context.push('/ideaDetails', extra: project);
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
