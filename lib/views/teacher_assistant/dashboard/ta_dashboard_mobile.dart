import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/auth_service.dart';
import '../../../services/ta_dashboard_services.dart';
import '../../model/user_model.dart';

class TADashboardMobileView extends StatefulWidget {
  final UserModel? user;
  const TADashboardMobileView({
    super.key, this.user,
  });

  @override
  State<TADashboardMobileView> createState() => _TADashboardMobileViewState();
}

class _TADashboardMobileViewState extends State<TADashboardMobileView> {
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
    return FutureBuilder(
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

        return Scaffold(
          backgroundColor: const Color(0xFF0D0F1A),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0D0F1A),
            title: Text(
              greeting(
                AuthService.name ?? "Teacher Assistant",
              ),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.go(
                    '/taNotifications',
                  );
                },
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    _projectcard(
                      "Pending projects",
                      pendingProjects,
                      context,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    _projectcard(
                      "Accepted",
                      acceptedProjects,
                      context,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: const Color(
                      0xFF1A1D2E,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        14,
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView(
                    children: recentIdeas.isEmpty
                        ? [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(
                                  20,
                                ),
                                child: Text(
                                  "No ideas yet",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        : recentIdeas.map(
                            (
                              idea,
                            ) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 12,
                                ),
                                child: _projects(
                                  idea,
                                  idea['ta_status'] ?? "pending",
                                  idea['title'] ?? "",
                                  idea['year']?.toString() ?? "",
                                  context,
                                ),
                              );
                            },
                          ).toList(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Widget _projectcard(
    String projectType,
    String number,
    BuildContext context,
  ) {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1D2E),
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              projectType,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _projects(
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
      displayStatus = "Accepted\nFrom TA";

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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
          const SizedBox(
            height: 20,
          ),
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

                  setState(() {
                    dashboardFuture =
                        TeacherAssistantDashboardService.getDashboard();
                  });
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

  Widget Buttons(
    String text,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(
              0xFF1A1D2E,
            ),
            borderRadius: BorderRadius.circular(
              14,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
