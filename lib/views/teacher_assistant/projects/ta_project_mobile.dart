import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/ta_project_approved.dart';
import '../../../services/ta_project_service.dart';

class TaAcceptedProjectsMobileView extends StatefulWidget {
  const TaAcceptedProjectsMobileView({super.key});

  @override
  State<TaAcceptedProjectsMobileView> createState() =>
      _TaAcceptedProjectsMobileViewState();
}

class _TaAcceptedProjectsMobileViewState
    extends State<TaAcceptedProjectsMobileView> {
  late Future<List<dynamic>> projectsFuture;

  @override
  void initState() {
    super.initState();
    projectsFuture = TaApprovedProjectsService.getApprovedProjects();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: projectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0D0F1A),
            body: Center(
              child: CircularProgressIndicator(color: Colors.cyan),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color(0xFF0D0F1A),
            body: Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            backgroundColor: const Color(0xFF0D0F1A),
            appBar: AppBar(
              backgroundColor: const Color(0xFF0D0F1A),
              elevation: 0,
              title: const Text(
                "Accepted Projects",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: const Center(
              child: Text(
                "No accepted projects",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final projects = snapshot.data!;

        return Scaffold(
          backgroundColor: const Color(0xFF0D0F1A),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0D0F1A),
            elevation: 0,
            title: const Text(
              "Accepted Projects",
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _acceptedProjectCard(projects[index], context),
              );
            },
          ),
        );
      },
    );
  }

  Widget _acceptedProjectCard(dynamic project, BuildContext context) {
    final List<dynamic> members =
        project['team']?['members'] as List<dynamic>? ?? [];
    final String memberNames = members
        .map((m) => m['name']?.toString() ?? 'Unknown')
        .where((name) => name.isNotEmpty)
        .join(", ");

    final String createdAt = project['createdAt']?.toString() ?? "";
    final String dateDisplay =
        createdAt.length >= 10 ? createdAt.substring(0, 10) : "N/A";

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
              Expanded(
                child: Text(
                  project['title'] ?? "No title",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Approved",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  memberNames.isEmpty ? "No members" : memberNames,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                "Date: $dateDisplay",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            project['description'] ?? "No description",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.push(
                    '/taIdeaDetails',
                    extra: project['_id'],
                  );
                },
                child: const Text(
                  "View",
                  style: TextStyle(
                      color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
