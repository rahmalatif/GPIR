import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../../services/ta_dashboard_services.dart';
import '../../model/user_model.dart';

class TADashboardWebView extends StatefulWidget {
  const TADashboardWebView({
    super.key,
  });

  @override
  State<TADashboardWebView> createState() => _TADashboardWebViewState();
}

class _TADashboardWebViewState extends State<TADashboardWebView> {
  late Future<Map<String, dynamic>> dashboardFuture;

  String greeting(String name) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning,\nTA. $name';
    }

    if (hour < 17) {
      return 'Good Afternoon,\nTA. $name';
    }

    return 'Good Evening,\nTA. $name';
  }

  @override
  void initState() {
    super.initState();

    dashboardFuture = TeacherAssistantDashboardService.getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 700;

    return FutureBuilder<Map<String, dynamic>>(
      future: dashboardFuture,
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
                "No dashboard data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        final data = snapshot.data!;

        final ta = data['ta'] ?? {};

        final pendingProjects = data['pendingProjects']?.toString() ?? "0";

        final acceptedProjects = data['acceptedProjects']?.toString() ?? "0";

        final recentIdeas = data['recentIdeas'] as List<dynamic>? ?? [];

        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              dashboardFuture = TeacherAssistantDashboardService.getDashboard();
            });
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF0D0F1A),
            body: Center(
              child: SizedBox(
                width: screenWidth > 1400 ? 1300 : screenWidth * 0.95,
                child: Padding(
                  padding: EdgeInsets.all(
                    isMobile ? 16 : 30,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    greeting(
                                      ta['name'] ?? "Teacher Assistant",
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isMobile ? 24 : 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        context.go(
                                          '/taNotifications',
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      greeting(
                                        ta['name'] ?? "Teacher Assistant",
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isMobile ? 24 : 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.go(
                                        '/taNotifications',
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        isMobile
                            ? Column(
                                children: [
                                  _projectcardTA(
                                    "Pending projects",
                                    pendingProjects,
                                    context,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _projectcardTA(
                                    "Accepted",
                                    acceptedProjects,
                                    context,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: _projectcardTA(
                                      "Pending projects",
                                      pendingProjects,
                                      context,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: _projectcardTA(
                                      "Accepted",
                                      acceptedProjects,
                                      context,
                                    ),
                                  ),
                                ],
                              ),

                        const SizedBox(
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Recent Ideas",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: screenWidth > 1400
                              ? 3
                              : screenWidth > 900
                                  ? 2
                                  : 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: screenWidth > 1200
                              ? 2.4
                              : screenWidth > 800
                                  ? 2
                                  : 1.6,
                          children: recentIdeas.isEmpty
                              ? [
                                  const Center(
                                    child: Text(
                                      "No ideas yet",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ]
                              : recentIdeas.map(
                                  (
                                    idea,
                                  ) {
                                    return _projectsTA(
                                      idea,
                                      idea['ta_status'] ?? "pending",
                                      idea['title'] ?? "",
                                      idea['year']?.toString() ?? "",
                                      context,
                                    );
                                  },
                                ).toList(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _projectcardTA(
  String projectType,
  String number,
  BuildContext context,
) {
  return Container(
    height: 140,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(
        20,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Colors.cyan,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          projectType,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.cyan,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _projectsTA(
  dynamic idea,
  String status,
  String name,
  String date,
  BuildContext context,
) {
  final normalizedStatus = status.toLowerCase().trim();

  String displayStatus = "Pending";

  Color statusColor = Colors.orange;

  if (normalizedStatus == "approved") {
    displayStatus = "Accepted From TA";

    statusColor = Colors.green;
  }

  if (normalizedStatus == "rejected") {
    displayStatus = "Rejected";

    statusColor = Colors.red;
  }

  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(
        20,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Text(
                displayStatus,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              "Date: $date",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () async {
                await context.push(
                  '/taIdeaDetails',
                  extra: idea['_id'],
                );
              },
              child: const Text(
                "View",
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget ButtonsTA(
  String text,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(
          14,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
