import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/library_dashboard_service.dart';

class LibraryDashboardView extends StatefulWidget {
  const LibraryDashboardView({super.key});

  @override
  State<LibraryDashboardView> createState() => _LibraryDashboardViewState();
}

class _LibraryDashboardViewState extends State<LibraryDashboardView> {
  late Future<Map<String, dynamic>> dashboardFuture;

  @override
  void initState() {
    super.initState();

    dashboardFuture = LibraryDashboardService.getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: Text(
          "Library Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Failed to load dashboard",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final data = snapshot.data ?? {};
          final totalProjects = data["totalProjects"] ?? 0;
          final thisYearProjects = data["thisYearProjects"] ?? 0;

          return Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _projectcard(
                        'Previous Projects',
                        totalProjects.toString(),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      _projectcard(
                        "This Year Projects",
                        thisYearProjects.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buttons(
                          title: "Add old Project",
                          onTap: () {
                            context.push(
                              '/libraryAddProject',
                            );
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        _buttons(
                          title: "View All Project",
                          onTap: () {
                            context.go(
                              '/libraryAllProject',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

Widget _projectcard(
    String projectType,
    String number,
    ) {
  return Container(
    height: 130,
    width: 170,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Colors.cyan,
            fontSize: 32,
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
            color: Colors.cyan,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buttons({
  required String title,
  required VoidCallback onTap,
}) {
  return SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff6EC6D9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 0,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
