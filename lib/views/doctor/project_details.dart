import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/doctor/reject_idea.dart';
import 'package:graduation_project_recommender/views/model/DR_project.dart';

class ProjectDetailsView extends StatelessWidget {
  final ProjectDR project;

  const ProjectDetailsView({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            }),
        title: const Text(
          "View Idea Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _section(
              "Problem",
              "Students often face attendance issues due to manual verification.",
            ),
            const SizedBox(height: 12),
            _section(
              "Description",
              project.description,
            ),
            const SizedBox(height: 12),
            _featuresSection(),
            const SizedBox(height: 12),
            _teamSection(project.team),
            const SizedBox(height: 12),
            Text(
              "Submitted By Rahma Ahmed • ${project.date}",
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            if (project.status == "Pending")
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RejectIdeaView()),
                        );
                        if (result != null && result["status"] == "Rejected") {
                          Navigator.pop(context, "Rejected");
                        }
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            "Accept",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.push('/rejectIdea');
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            "Reject",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
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

  Widget _featuresSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Features",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text("• Student QR scanner", style: TextStyle(color: Colors.grey)),
          Text("• Secure backend API", style: TextStyle(color: Colors.grey)),
          Text("• Multi-role login", style: TextStyle(color: Colors.grey)),
          Text("• Admin attendance dashboard",
              style: TextStyle(color: Colors.grey)),
          Text("• Student analytics", style: TextStyle(color: Colors.grey)),
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
