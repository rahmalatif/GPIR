import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/notification_service.dart';
import '../model/DR_project.dart';

const String adminId = "5gEv2R4GauTSjXbALR0RxJX6AG63";

class ProjectDetailsView extends StatelessWidget {
  final String? projectId;
  final ProjectDR? project;

  const ProjectDetailsView({
    super.key,
    this.projectId,
    this.project,
  });

  String _getStatus(Map<String, dynamic>? data) {
    if (project != null) return project!.status.toLowerCase();
    return (data?["status"] ?? "").toString().toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    if (project != null) {
      final status = project!.status.toLowerCase();

      return Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0F1A),
          title: const Text("View Idea Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project!.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _section("Description", project!.description),
              const SizedBox(height: 12),
              _section("Introduction", project!.introduction),

              const SizedBox(height: 12),

              _featuresSection(project!.features),

              _teamSection(project!.team),
              const SizedBox(height: 30),
              if (status.contains("pending"))
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Project Accepted ✅"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          context.pop();
                        },
                        child: _actionBtn("Accept", Colors.green),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.go('/rejectIdea');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Project Rejected ❌"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          context.pop();
                        },
                        child: _actionBtn("Reject", Colors.red),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("projects")
          .doc(projectId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final status = _getStatus(data);

        return Scaffold(
          backgroundColor: const Color(0xFF0D0F1A),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0D0F1A),
            title: const Text(
              "View Idea Details",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.keyboard_backspace, color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["name"] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _section("Problem", data["problem"] ?? "—"),
                  const SizedBox(height: 12),
                  _section("Introduction", data["introduction"] ?? ""),
                  const SizedBox(height: 12),
                  _featuresSection(
                    List<String>.from(data["features"] ?? []),
                  ),
                  const SizedBox(height: 12),
                  _teamSection(
                    List<String>.from(data["teamMembers"] ?? []),
                  ),
                  const SizedBox(height: 30),
                  if (status.contains("pending"))
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("projects")
                                  .doc(projectId)
                                  .update({"status": "accepted"});
//student
                              await FirebaseFirestore.instance
                                  .collection("notifications")
                                  .add({
                                "userId": data["studentId"],
                                "title": "Project Accepted 🎉",
                                "body":
                                    "Your project has been accepted by the supervisor",
                                "type": "project_accepted",
                                "projectId": projectId,
                                "seen": false,
                                "createdAt": Timestamp.now(),
                              });
//admin
                              await FirebaseFirestore.instance
                                  .collection("notifications")
                                  .add({
                                "userId": adminId,
                                "title": "New Accepted Project",
                                "body": "A project has been accepted and is ready for review",
                                "type": "admin_project_accepted",
                                "projectId": projectId,
                                "studentId": data["studentId"],
                                "seen": false,
                                "createdAt": Timestamp.now(),
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Project Accepted ✅"),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              context.pop();
                            },
                            child: _actionBtn("Accept", Colors.green),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("projects")
                                  .doc(projectId)
                                  .update({"status": "rejected"});

                              await NotificationService.send(
                                userId: data["studentId"],
                                title: "Project Rejected ❌",
                                body:
                                    "Your graduation project was rejected by the supervisor",
                                type: "project_status",
                                projectId: projectId!,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Project Rejected ❌"),
                                  backgroundColor: Colors.red,
                                ),
                              );

                              context.pop();
                            },
                            child: _actionBtn("Reject", Colors.red),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _actionBtn(String text, Color color) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _section(String title, String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(text, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _featuresSection(List<String> features) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Features",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          if (features.isEmpty)
            const Text("No features added",
                style: TextStyle(color: Colors.grey)),
          ...features.map(
            (f) => Text("• $f", style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _teamSection(List<String> team) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Team Members",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          ...team.map(
            (name) => Text(name, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
