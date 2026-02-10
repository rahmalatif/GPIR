import 'package:flutter/material.dart';

class AdminAllProjectsIdView extends StatelessWidget {
  const AdminAllProjectsIdView({super.key});

  final List<Map<String, dynamic>> projectsWithId = const [
    {
      "name": "Smart Attendance System",
      "supervisor": "Dr. Ahmed",
      "team": "Ahmed, Sara, Omar",
      "id": "CS-2025-01"
    },
    {
      "name": "Health Tracker App",
      "supervisor": "Dr. Mona",
      "team": "Laila, Youssef",
      "id": "CS-2024-07"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "All Projects with ID",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: projectsWithId.length,
        itemBuilder: (context, index) {
          final project = projectsWithId[index];
          return _projectCard(project);
        },
      ),
    );
  }

  Widget _projectCard(Map<String, dynamic> project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project["name"],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text("Supervisor: ${project["supervisor"]}",
                    style: const TextStyle(color: Colors.grey)),
                Text("Team: ${project["team"]}",
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),

              ],
            ),
          ),
          Text(
            "ID: ${project["id"]}",
            style: const TextStyle(
                color: Colors.cyan, fontWeight: FontWeight.bold),
          ),        ],
      ),
    );
  }
}
