import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/notification_badge.dart';
import '../../../services/doctor_dashboard_service.dart';
import '../../model/user_model.dart';

class DashboardWebView extends StatefulWidget {
  const DashboardWebView({
    super.key,
  });

  @override
  State<DashboardWebView> createState() => _DashboardWebViewState();
}

class _DashboardWebViewState extends State<DashboardWebView> {
  late Future<Map<String, dynamic>> dashboardFuture;

  String greeting(String name) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning,\nDr. $name';
    }

    if (hour < 17) {
      return 'Good Afternoon,\nDr. $name';
    }

    return 'Good Evening,\nDr. $name';
  }

  @override
  void initState() {
    super.initState();

    dashboardFuture = DoctorDashboardService.getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isTablet = screenWidth < 1100;
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

        final doctor = data['doctor'] ?? {};

        final pendingProjects = data['pendingProjects']?.toString() ?? "0";

        final acceptedProjects = data['acceptedProjects']?.toString() ?? "0";

        final recentIdeas = data['recentIdeas'] as List<dynamic>? ?? [];

        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              dashboardFuture = DoctorDashboardService.getDashboard();
            });
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF0D0F1A),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF0D0F1A),
              actions: [
                IconButton(
                  icon: NotificationBadge(),
                  onPressed: () {
                    context.go('/doctorNotifications');
                  },
                ),
              ],
            ),
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
                                      doctor['name'] ?? "Doctor",
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isMobile ? 24 : 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      greeting(
                                        doctor['name'] ?? "Doctor",
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isMobile ? 24 : 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                        const SizedBox(height: 30),
                        isMobile
                            ? Column(
                                children: [
                                  _projectcard(
                                    "Pending projects",
                                    pendingProjects,
                                    context,
                                  ),
                                  const SizedBox(height: 20),
                                  _projectcard(
                                    "Accepted",
                                    acceptedProjects,
                                    context,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: _projectcard(
                                      "Pending projects",
                                      pendingProjects,
                                      context,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _projectcard(
                                      "Accepted",
                                      acceptedProjects,
                                      context,
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 25),
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
                            fillColor: const Color(0xFF1A1D2E),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
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
                        const SizedBox(height: 20),
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
                                  (idea) {
                                    return _projects(
                                      idea,
                                      idea['doctor_status'] ?? "pending",
                                      idea['title'] ?? "",
                                      idea['year']?.toString() ?? "",
                                      context,
                                    );
                                  },
                                ).toList(),
                        ),
                        const SizedBox(height: 30),
                        isMobile
                            ? Column(
                                children: [
                                  Buttons(
                                    "Add Ideas",
                                    () {
                                      context.push(
                                        '/addIdea',
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Buttons(
                                      "Add Ideas",
                                      () {
                                        context.push(
                                          '/addIdea',
                                        );
                                      },
                                    ),
                                  ),
                                ],
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

Widget _projectcard(
  String projectType,
  String number,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      context.push(
        '/doctorProjects',
      );
    },
    child: Container(
      height: 140,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(20),
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
          const SizedBox(height: 12),
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
    displayStatus = "Accepted From Doctor";

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
      borderRadius: BorderRadius.circular(20),
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
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20),
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
        const SizedBox(height: 10),
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
                  '/ideaDetails',
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

Widget Buttons(
  String text,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(14),
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
