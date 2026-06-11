import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/design/app_image.dart';
import '../../../core/design/notification_badge.dart';
import '../../../services/auth_service.dart';
import '../../../services/leave_team_service.dart';
import '../../../services/student_dashboard_service.dart';
import '../../chat/chatting.dart';

class StudentDashboardMobile extends StatefulWidget {
  const StudentDashboardMobile({
    super.key,
  });

  @override
  State<StudentDashboardMobile> createState() => _StudentDashboardMobileState();
}

class _StudentDashboardMobileState extends State<StudentDashboardMobile> {
  late Future<Map<String, dynamic>> dashboardFuture;

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
  void initState() {
    super.initState();
    dashboardFuture = DashboardService.getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    String today = DateFormat(
      'dd MMM yyyy',
    ).format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: NotificationBadge(),
              onPressed: () {
                context.go('/studentNotifications');
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: dashboardFuture,
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
          final team = data['team'] ?? {'members': []};

          final hasProject = project.isNotEmpty;

          final List membersList = team['members'] ?? [];
          final hasTeam = membersList.isNotEmpty && team.isNotEmpty;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting(
                    student['name'] ?? "Student",
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  today,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                buildStatusCard(project),

                const SizedBox(height: 20),

                if (!hasProject) buildOptions(),

                if (!hasProject) const SizedBox(height: 20),

                if (hasTeam) ...[
                  buildTeamCard(team, context),
                  const SizedBox(height: 20),
                ],

                buildSupervisorCard(supervisor, ta),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildStatusCard(dynamic project) {
    final hasProject = project.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1D1D2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xff4699A8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hasProject ? project['title'] ?? "" : "No project submitted yet",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hasProject
                    ? "Supervised By: ${project['doctor_id']?['name'] ?? 'Not Assigned'}"
                    : "Supervised By: Not assigned yet",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4699A8),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOptions() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: buildOptionCard(
          image: 'assets/png/idea.png',
          text: "Have an Idea",
          onTap: haveAnIdeaOnTap,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: buildOptionCard(
          image: 'assets/png/ai.png',
          text: "Recommend Idea",
          onTap: aiRecommendIdea,
        ),
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
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xff1D1D2E),
          border: Border.all(
            color: const Color(0xff4699A8),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: AppImage(
                image: image,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamCard(dynamic team, BuildContext context) {
    final members = team['members'] as List<dynamic>? ?? [];

    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        color: const Color(0xff1D1D2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Team Members",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ...members.map(
                    (m) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          m['name'] ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        m['specialization'] ?? "",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    showLeaveDialog(context, team);
                  },
                  icon: const Icon(Icons.logout, color: Colors.white, size: 18),
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
    );
  }

  Widget buildSupervisorCard(dynamic supervisor, dynamic ta) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1D1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Supervisor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  supervisor['name'] ?? "Not Assigned",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xff4699A8),
                child: IconButton(
                    icon: const Icon(Icons.chat_bubble,
                        color: Colors.white, size: 16),
                    onPressed: () {
                      print("CURRENT = ${AuthService.userId}");
                      print("MY NAME = ${AuthService.name}");
                      print("SUPERVISOR ID = ${supervisor['_id']}");
                      print("SUPERVISOR NAME = ${supervisor['name']}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChattingView(
                            currentUserId: AuthService.userId!,
                            myName: AuthService.name!,
                            receiverId: supervisor['_id'],
                            receiverName: supervisor['name'],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Teaching Assistant',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  ta['name'] ?? "Not Assigned",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xff4699A8),
                child: IconButton(
                  icon: const Icon(Icons.chat_bubble,
                      color: Colors.white, size: 16),
                  onPressed: () {
                    print("CURRENT USER = ${AuthService.userId}");
                    print("SUPERVISOR = $supervisor");
                    print("TA = $ta");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChattingView(
                          currentUserId: AuthService.userId!,
                          myName: AuthService.name!,
                          receiverId: ta['_id'],
                          receiverName: ta['name'],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void showLeaveDialog(
      BuildContext context,
      dynamic team,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1D2E),
          title: const Text(
            "Leave Team",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: const Text(
            "Are you sure you want to leave the team?",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);

                try {
                  final success = await LeaveTeamService.leaveTeam();

                  if (!context.mounted) return;

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Left team successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    setState(() {
                      dashboardFuture = DashboardService.getDashboard();
                    });
                  }
                } catch (e) {
                  if (!context.mounted) return;

                  if (e.toString().contains("Leader must choose new leader")) {
                    showChooseLeaderDialog(
                      context,
                      team,
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              },
              child: const Text("Leave"),
            ),
          ],
        );
      },
    );
  }

  void showChooseLeaderDialog(
      BuildContext context,
      dynamic team,
      ) {
    final members = team['members'] as List<dynamic>? ?? [];
    String? selectedLeaderId;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1A1D2E),
              title: const Text(
                "Choose New Leader",
                style: TextStyle(color: Colors.white),
              ),
              content: DropdownButton<String>(
                dropdownColor: const Color(0xFF1A1D2E),
                value: selectedLeaderId,
                hint: const Text(
                  "Select member",
                  style: TextStyle(color: Colors.white),
                ),
                items: members.map((m) {
                  return DropdownMenuItem<String>(
                    value: m['_id'],
                    child: Text(
                      m['name'] ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setDialogState(() {
                    selectedLeaderId = value;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedLeaderId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a leader")),
                      );
                      return;
                    }

                    Navigator.pop(dialogContext);

                    try {
                      final success = await LeaveTeamService.leaveTeam(
                        newLeaderId: selectedLeaderId,
                      );

                      if (!context.mounted) return;

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Leader changed & Left team successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        setState(() {
                          dashboardFuture = DashboardService.getDashboard();
                        });
                      }
                    } catch (e) {
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  child: const Text("Confirm"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}