import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/design/app_image.dart';
import '../../../services/leave_team_service.dart';
import '../../../services/student_dashboard_service.dart';

class StudentDashboardWeb extends StatefulWidget {
  const StudentDashboardWeb({super.key});

  @override
  State<StudentDashboardWeb> createState() => _StudentDashboardWebState();
}

class _StudentDashboardWebState extends State<StudentDashboardWeb> {
  void haveAnIdeaOnTap() => context.go('/haveIdea');

  void aiRecommendIdea() => context.go('/aiRecommend');

  String greeting(String name) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning,\n$name';
    }

    if (hour < 17) {
      return 'Good Afternoon,\n$name';
    }

    return 'Good Evening,\n$name';
  }

  @override
  Widget build(BuildContext context) {
    String today = DateFormat(
      'dd MMM yyyy',
    ).format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),

      // نفس فكرة الموبايل
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                context.go('/studentNotifications');
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: FutureBuilder(
        future: DashboardService.getDashboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff4699A8),
              ),
            );
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No dashboard data",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            );
          }

          final data = snapshot.data!;

          final student = data['student'] ?? {};

          final project = data['project'] ?? {};

          final supervisor = data['supervisor'] ?? {};

          final ta = data['teachingAssistant'] ?? {};

          final team = data['team'] ??
              {
                'members': [],
              };

          final hasProject = project.isNotEmpty;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Greeting
                    Text(
                      greeting(
                        student['name'] ?? "Student",
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      today,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 35),

                    buildStatusCard(project),

                    const SizedBox(height: 30),

                    if (!hasProject) buildOptions(),

                    if (!hasProject)
                      const SizedBox(
                        height: 35,
                      ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildTeamCard(team, context),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: buildSupervisorCard(
                            supervisor,
                            ta,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildStatusCard(
    dynamic project,
  ) {
    final hasProject = project.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xff1D1D2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xff4699A8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            hasProject ? project['title'] ?? "" : "No project submitted yet",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                hasProject
                    ? "Supervised By: "
                        "${project['doctor_id']?['name'] ?? 'Not Assigned'}"
                    : "Supervised By: Not assigned yet",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4699A8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: hasProject
                    ? () {
                        context.go('/studentProject');
                      }
                    : null,
                child: const Text(
                  "View Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget buildOptions() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildOptionCard(
            image: 'assets/png/idea.png',
            text: "Have an Idea",
            onTap: haveAnIdeaOnTap,
          ),
          const SizedBox(width: 40),
          buildOptionCard(
            image: 'assets/png/ai.png',
            text: "Recommend Idea",
            onTap: aiRecommendIdea,
          ),
        ],
      );

  Widget buildOptionCard({
    required String image,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        width: 260,
        decoration: BoxDecoration(
          color: const Color(0xff1D1D2E),
          border: Border.all(
            color: const Color(0xff4699A8),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: AppImage(
                image: image,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamCard(
    dynamic team,
    BuildContext context,
  ) {
    final members = team['members'] as List<dynamic>? ?? [];

    return Center(
      child: SizedBox(
        width: 350,
        child: Card(
          color: const Color(0xff1D1D2E),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Team Members",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...members.map(
                  (m) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        Text(
                          m['name'] ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          m['specialization'] ?? "",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final success = await LeaveTeamService.leaveTeam();

                      if (success) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Left team successfully",
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );

                          context.go(
                            '/studentDashboard',
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Failed to leave team",
                            ),
                          ),
                        );
                      }
                    },

                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Leave Team",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSupervisorCard(
    dynamic supervisor,
    dynamic ta,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1D1D2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Supervisor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Text(
                  supervisor['name'] ?? "Not Assigned",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: const Color(0xff4699A8),
                child: IconButton(
                  icon: const Icon(
                    Icons.chat_bubble,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    context.push('/studentChat');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Teaching Assistant',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            ta['name'] ?? "Not Assigned",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
