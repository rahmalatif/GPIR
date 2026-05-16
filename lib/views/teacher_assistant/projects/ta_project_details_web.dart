import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/doctor_project_details_service.dart';
import '../../../services/doctor_project_status_service.dart';
import '../../../services/ta_project_details_service.dart';
import '../../../services/ta_project_status_service.dart';

class TAProjectDetailsWebView extends StatefulWidget {
  final String projectId;

  const TAProjectDetailsWebView({
    super.key,
    required this.projectId,
  });

  @override
  State<TAProjectDetailsWebView> createState() => _ProjectDetailsWebViewState();
}

class _ProjectDetailsWebViewState extends State<TAProjectDetailsWebView> {
  late Future<Map<String, dynamic>> projectFuture;

  @override
  void initState() {
    super.initState();

    projectFuture = TAProjectDetailsService.getProjectDetails(
      widget.projectId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: projectFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0D0F1A),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            backgroundColor: Color(0xFF0D0F1A),
            body: Center(
              child: Text(
                "No project data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        final data = snapshot.data!;

        final project = data['project'] ?? {};

        final title = project['title'] ?? "";

        final description = project['description'] ?? "";

        final similarity = project['similarity_score']?.toString() ?? "0";

        final tools = project['tools'] as List<dynamic>? ?? [];

        final specializations =
            project['specialization'] as List<dynamic>? ?? [];

        final ta = project['ta'] ?? {};

        final similarProjects =
            project['similarProjects'] as List<dynamic>? ?? [];
        final taStatus =
            (project['ta_status'] ?? "pending").toString().trim().toLowerCase();
        final drStatus = (project['doctor_status'] ?? "pending")
            .toString()
            .trim()
            .toLowerCase();

        print(
          "REAL DOCTOR STATUS: "
          "$taStatus",
        );

        final finalStatus =
            (project['status'] ?? "pending").toString().toLowerCase();

        String displayStatus = "Pending";

        Color statusColor = Colors.orange;

        if (taStatus == "approved") {
          displayStatus = "Accepted From Teacher Assistant";

          statusColor = Colors.green;
        }

        if (taStatus == "rejected") {
          displayStatus = "Rejected From Teacher Assistant";

          statusColor = Colors.red;
        }
        print(
          "TA STATUS: $taStatus",
        );
        final members = project['team']?['members'] as List<dynamic>? ?? [];
        return Scaffold(
          backgroundColor: const Color(0xFF0D0F1A),
          body: Center(
            child: SizedBox(
              width: 1000,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.go(
                              '/taDashboard',
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "View Idea Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _statusCard(
                              title: "Doctor",
                              status: drStatus,
                            ),
                            const SizedBox(height: 10),
                            _statusCard(
                              title: "TA",
                              status: taStatus,
                            ),
                            const SizedBox(height: 10),
                            _statusCard(
                              title: "Final",
                              status: finalStatus,
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                    const SizedBox(height: 25),
                    _section(
                      "Description",
                      description,
                    ),
                    const SizedBox(height: 20),
                    _section(
                      "Similarity Score",
                      "$similarity%",
                    ),
                    const SizedBox(height: 20),
                    _section(
                      "Teaching Assistant",
                      ta?['name'] ?? "Not Assigned",
                    ),
                    const SizedBox(height: 20),
                    _wrapSection(
                      "Tools",
                      tools,
                    ),
                    const SizedBox(height: 20),
                    _wrapSection(
                      "Specializations",
                      specializations,
                    ),
                    const SizedBox(height: 20),
                    if (similarProjects.isNotEmpty)
                      _similarProjectsSection(
                        similarProjects,
                      ),
                    const SizedBox(height: 20),
                    _teamSection(
                      members,
                    ),
                    const SizedBox(height: 40),
                    if (taStatus != "approved")
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final success = await TAProjectStatusService
                                    .updateProjectStatus(
                                  projectId: widget.projectId,
                                  status: "approved",
                                );

                                if (success) {
                                  setState(() {
                                    projectFuture = TAProjectDetailsService
                                        .getProjectDetails(
                                      widget.projectId,
                                    );
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Project Accepted ✅",
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Something went wrong",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: _actionBtn(
                                "Accept",
                                Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final success = await TAProjectStatusService
                                    .updateProjectStatus(
                                  projectId: widget.projectId,
                                  status: "rejected",
                                );

                                if (success) {
                                  setState(() {
                                    projectFuture = TAProjectDetailsService
                                        .getProjectDetails(
                                      widget.projectId,
                                    );
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Project Rejected ❌",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Something went wrong",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: _actionBtn(
                                "Reject",
                                Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _actionBtn(
    String text,
    Color color,
  ) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _section(
    String title,
    String text,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _wrapSection(
    String title,
    List<dynamic> items,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Chip(
                label: Text(item.toString()),
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

  Widget _similarProjectsSection(
    List<dynamic> projects,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Similar Projects",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...projects.map((p) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                p['title'] ?? "",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _teamSection(
    List<dynamic> team,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Team Members",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...team.map((member) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "${member['name']} • ${member['specialization']}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

Widget _statusCard({
  required String title,
  required String status,
}) {
  Color color = Colors.orange;

  if (status == "approved") {
    color = Colors.green;
  }

  if (status == "rejected") {
    color = Colors.red;
  }

  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 8,
    ),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      "$title: ${status.toUpperCase()}",
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
