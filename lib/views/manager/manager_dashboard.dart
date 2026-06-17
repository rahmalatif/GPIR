import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/manager_dashboard_sevices.dart';

class ManagerDashboardView extends StatefulWidget {
  const ManagerDashboardView({super.key});

  @override
  State<ManagerDashboardView> createState() => _ManagerDashboardViewState();
}

class _ManagerDashboardViewState extends State<ManagerDashboardView> {
  late Future<Map<String, dynamic>> dashboardFuture;

  @override
  @override
  void initState() {
    super.initState();

    print('Manager Dashboard Opened');

    dashboardFuture = ManagerDashboardService.getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "Manager Dashboard",
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
              child: CircularProgressIndicator(color: Colors.cyan),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Failed to load dashboard",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          final data = snapshot.data ?? {};
          final totalDoctors = data["totalDoctors"] ?? 0;
          final totalTAs = data["totalTAs"] ?? 0;
          final ongoingProjects = data["totalProjects"] ?? 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _dashboardCard(
                        'Total Doctors',
                        totalDoctors.toString(),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _dashboardCard(
                        "Total TAs",
                        totalTAs.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _dashboardCard(
                        'Total Ongoing Projects',
                        ongoingProjects.toString(),
                      ),
                    ),
                    const SizedBox(width: 15),

                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.push('/accessSettings');
                        },
                        child: Container(
                          height: 90,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1D2E),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: const Color(0xff6EC6D9).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.vpn_key_rounded,
                                    color: Colors.cyan,
                                    size: 28,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    "Access Settings",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.cyan,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    _buttons(
                      title: "Manage Staff",
                      onTap: () {
                        context.push('/manageStaff');
                      },
                    ),
                    SizedBox(height: 10,),
                    _buttons(
                      title: "View TAs Projects",
                      onTap: () {
                        context.push('/manageTas');
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
}

Widget _dashboardCard(
    String title,
    String value, {
      bool isDeadline = false,
    }) {
  return Container(
    height: 130,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.cyan,
            fontSize: isDeadline ? 18 : 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.cyan,
            fontSize: 13,
            fontWeight: FontWeight.w600,
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