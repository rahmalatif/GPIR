import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/admin_dashboard_sevices.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({
    super.key,
  });

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  late Future<Map<String, dynamic>> dashboardFuture;

  @override
  void initState() {
    super.initState();

    dashboardFuture = AdminDashboardService.getDashboard();
  }

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning\nMr. Osama";
    }

    if (hour < 17) {
      return "Good Afternoon\nMr. Osama";
    }

    return "Good Evening\nMr. Osama";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.push(
                '/adminNotifications',
              );
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No dashboard data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final data = snapshot.data!;

          final pendingProjects = data['pendingProjects'] ?? [];

          final ongoingProjects = data['ongoingProjects'] ?? [];

          final projectsWithoutCode = data['projectsWithoutCode'] ?? [];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  greeting(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    project(
                      title: "Projects\nwithout ID",
                      count: projectsWithoutCode.length.toString(),
                      icon: Icons.pending_actions,
                      onTap: () {
                        context.push(
                          '/adminPendingIdeas',
                        );
                      },
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    project(
                      title: "Projects\non going",
                      count: ongoingProjects.length.toString(),
                      icon: Icons.check_circle_outline,
                      onTap: () {
                        context.push(
                          '/adminApprovedProjects',
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget project({
    required String title,
    required String count,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1D2E),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: Colors.cyan,
                    size: 32,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      count,
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
