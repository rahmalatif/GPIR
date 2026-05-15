import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/admin_project_details_services.dart';

class AdminIdeaDetailsView extends StatefulWidget {
  final String projectId;

  const AdminIdeaDetailsView({
    super.key,
    required this.projectId,
  });

  @override
  State<AdminIdeaDetailsView> createState() => _AdminIdeaDetailsViewState();
}

class _AdminIdeaDetailsViewState extends State<AdminIdeaDetailsView> {
  late Future<Map<String, dynamic>> projectFuture;

  @override
  void initState() {
    super.initState();

    projectFuture = AdminProjectDetailsService.getProjectDetails(
      widget.projectId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Admin View Idea Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: projectFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No project data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final data = snapshot.data!;

          final project = data['project'];

          final title = project['title'] ?? "";

          final description = project['description'] ?? "";

          final tools = project['tools'] as List<dynamic>? ?? [];

          final members = (project['team']?['members'] as List<dynamic>? ?? []);

          final ta = project['ta']?['name'] ?? "Not Assigned";

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Team: "
                  "${members.map(
                        (m) => m['name'],
                      ).join(', ')}",
                  style: const TextStyle(
                    color: Color(0xff4699A8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                _card(
                  title: "Problem",
                  text: title,
                ),
                const SizedBox(
                  height: 10,
                ),
                _card(
                  title: "Description",
                  text: description,
                ),
                const SizedBox(
                  height: 10,
                ),
                _toolsCard(
                  tools,
                ),
                const SizedBox(
                  height: 10,
                ),
                _teamCard(
                  members,
                ),
                const SizedBox(
                  height: 10,
                ),
                _card(
                  title: "Teaching Assistant",
                  text: ta,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(
                        '/projectId',
                        extra: widget.projectId,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xff4699A8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Accept Project",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _card({
    required String title,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff4699A8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolsCard(
    List<dynamic> tools,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tools",
            style: TextStyle(
              color: Color(0xff4699A8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tools.map((tool) {
              return Chip(
                label: Text(
                  tool.toString(),
                ),
                backgroundColor: Colors.cyanAccent,
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _teamCard(
    List<dynamic> members,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Team Members",
            style: TextStyle(
              color: Color(0xff4699A8),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          ...members.map((member) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 6,
              ),
              child: Text(
                "• ${member['name']}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
