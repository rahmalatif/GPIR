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
        actions: [
          IconButton(
            icon: NotificationBadge(),
            onPressed: () {
              context.go('/studentNotifications');
            },
          ),
        ],
      ),
      body: FutureBuilder(
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

          final student = data['student'] ?? {};

          final project = data['project'] ?? {};

          final supervisor = data['supervisor'] ?? {};

          final ta = data['teachingAssistant'] ?? {};

          final team = data['team'] ??
              {
                'members': [],
              };

          final hasProject = project.isNotEmpty;

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      greeting(
                        student['name'] ?? "Student",
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      today,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildStatusCard(
                  project,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!hasProject) buildOptions(),
                const SizedBox(
                  height: 30,
                ),
                buildTeamCard(team, context),
                const SizedBox(
                  height: 15,
                ),
                buildSupervisorCard(
                  supervisor,
                  ta,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
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

    return Center(
      child: SizedBox(
        height: 160,
        width: 340,
        child: Card(
          color: const Color(0xff1D1D2E),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  hasProject
                      ? project['title'] ?? ""
                      : "No project submitted yet",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  hasProject
                      ? "Supervised By: "
                          "${project['doctor_id']?['name'] ?? 'Not Assigned'}"
                      : "Supervised By: Not assigned yet",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4699A8),
                  ),
                  onPressed: hasProject
                      ? () {
                          context.go(
                            '/studentProject',
                          );
                        }
                      : null,
                  child: const Text(
                    "View Details",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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
          const SizedBox(
            width: 50,
          ),
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
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          width: 130,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff4699A8),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: AppImage(
                  image: image,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

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
                    onPressed: () {
                      showLeaveDialog(
                        context,
                        team,
                      );
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
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1A1D2E),
              title: const Text(
                "Choose New Leader",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: DropdownButton<String>(
                dropdownColor: const Color(0xFF1A1D2E),
                value: selectedLeaderId,
                hint: const Text(
                  "Select member",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                items: members.map((m) {
                  return DropdownMenuItem<String>(
                    value: m['_id'],
                    child: Text(
                      m['name'] ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLeaderId = value;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text(
                    "Cancel",
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedLeaderId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please select a leader",
                          ),
                        ),
                      );

                      return;
                    }

                    Navigator.pop(
                      dialogContext,
                    );

                    try {
                      final success = await LeaveTeamService.leaveTeam(
                        newLeaderId: selectedLeaderId,
                      );

                      if (!context.mounted) {
                        return;
                      }

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Leader changed successfully",
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Future.delayed(
                          const Duration(milliseconds: 200),
                          () {
                            if (context.mounted) {
                              setState(() {
                                dashboardFuture =
                                    DashboardService.getDashboard();
                              });
                            }
                          },
                        );
                      }
                    } catch (e) {
                      if (!context.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString(),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Confirm",
                  ),
                ),
              ],
            );
          },
        );
      },
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
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                "Cancel",
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                Navigator.pop(
                  dialogContext,
                );

                try {
                  final success = await LeaveTeamService.leaveTeam();

                  if (!context.mounted) {
                    return;
                  }

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Left team successfully",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Future.delayed(
                      const Duration(milliseconds: 200),
                      () {
                        if (context.mounted) {
                          setState(() {
                            dashboardFuture = DashboardService.getDashboard();
                          });
                        }
                      },
                    );
                  }
                } catch (e) {
                  if (!context.mounted) {
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString().contains(
                                  "Leader must choose new leader",
                                )
                            ? "You must choose a new leader first"
                            : "Failed to leave team",
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                "Leave",
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildSupervisorCard(
    dynamic supervisor,
    dynamic ta,
  ) {
    return Center(
      child: SizedBox(
        width: 350,
        height: 220,
        child: Card(
          color: const Color(0xff1D1D2E),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Supervisor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      supervisor['name'] ?? "Not Assigned",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: const Color(0xff4699A8),
                      child: IconButton(
                          icon: const Icon(
                            Icons.chat_bubble,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () {
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Teaching Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  ta['name'] ?? "Not Assigned",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: const Color(0xff4699A8),
                  child: IconButton(
                      icon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChattingView(
                              currentUserId: AuthService.userId!,
                              myName: AuthService.name!,
                              receiverId: ta["_id"],
                              receiverName: ta["name"],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
