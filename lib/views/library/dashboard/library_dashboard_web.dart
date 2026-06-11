import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/library_dashboard_service.dart';

class LibraryDashboarWebdView extends StatefulWidget {
  const LibraryDashboarWebdView({super.key});

  @override
  State<LibraryDashboarWebdView> createState() => _LibraryDashboardViewState();
}

class _LibraryDashboardViewState extends State<LibraryDashboarWebdView> {
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
        elevation: 0,
        title: const Text(
          "Library Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
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

          return LayoutBuilder(
            builder: (context, constraints) {
              final bool isWeb = constraints.maxWidth > 768;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: _projectcard(
                                  'Previous Projects',
                                  totalProjects.toString(),
                                  isWeb,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Center(
                                child: _projectcard(
                                  "This Year Projects",
                                  thisYearProjects.toString(),
                                  isWeb,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        if (isWeb)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buttons(
                                  title: "Add old Project",
                                  onTap: () => context.push('/libraryAddProject'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buttons(
                                  title: "View All Project",
                                  onTap: () => context.go('/libraryAllProject'),
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              _buttons(
                                title: "Add old Project",
                                onTap: () => context.push('/libraryAddProject'),
                              ),
                              const SizedBox(height: 12),
                              _buttons(
                                title: "View All Project",
                                onTap: () => context.go('/libraryAllProject'),
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
        },
      ),
    );
  }

  Widget _projectcard(String projectType, String number, bool isWeb) {
    return Container(
      height: isWeb ? 150 : 130,
      width: isWeb ? 240 : 170,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: TextStyle(
              color: const Color(0xff6EC6D9),
              fontSize: isWeb ? 38 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            projectType,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: isWeb ? 15 : 14,
              fontWeight: FontWeight.w500,
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
      height: 50,
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}