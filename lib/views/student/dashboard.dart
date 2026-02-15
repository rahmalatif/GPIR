import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';

import '../model/team.dart';

class StudentDashboardView extends StatefulWidget {
  const StudentDashboardView({super.key});

  @override
  State<StudentDashboardView> createState() => _StudentDashboardViewState();
}

class _StudentDashboardViewState extends State<StudentDashboardView> {
  List<TeamMember> members = [
    TeamMember(
      name: "Rahma Ahmed",
      track: '',
    ),
    TeamMember(
      name: "Kenzy Mohamed",
      track: '',
    ),
    TeamMember(
      name: "AbdElrahman",
      track: '',
    ),
    TeamMember(
      name: "Omar Zakaria",
      track: '',
    ),
    TeamMember(
      name: "Mohamed Ibrahim",
      track: '',
    ),
  ];

  void haveAnIdeaOnTap() => context.go('/haveIdea');

  void aiRecommendIdea() => context.go('/aiRecommend');

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Good Morning, Rahma",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/studentNotifications');
            },
            icon: const Icon(Icons.notifications),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  today,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            const SizedBox(height: 30),
            buildStatusCard(),
            const SizedBox(height: 20),
            buildOptions(),
            const SizedBox(height: 30),
            buildTeamCard(),
            const SizedBox(height: 15),
            buildSupervisorCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildStatusCard() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("projects")
          .where("studentId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text(
            "No project submitted yet",
            style: TextStyle(color: Colors.white),
          );
        }

        final projectDoc = snapshot.data!.docs.first;
        final data = projectDoc.data() as Map<String, dynamic>;

        final status = data["status"];
        final supervisor = data["supervisor"] ?? "Unknown";
        final assignedId = data["assignedId"];

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
                      getStatusText(status),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          "Supervised By: $supervisor",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const Spacer(),
                        buildStatusButton(status, assignedId),
                      ],
                    ),
                  ),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4699A8),
                      ),
                      onPressed: () {
                        context.go('/studentProject');
                      },
                      child: const Text(
                        "View Details",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  String getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Your Idea is Under Review";
      case "accepted":
        return "Your Idea Has Been Accepted 🎉";
      case "rejected":
        return "Your Idea Was Rejected";
      default:
        return "Status Unknown";
    }
  }

  Widget buildStatusButton(String status, String? assignedId) {
    if (status == "pending") {
      return const Text("Pending", style: TextStyle(color: Colors.orange));
    }

    if (status == "rejected") {
      return const Text("Rejected", style: TextStyle(color: Colors.red));
    }

    if (status == "accepted") {
      return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xff4699A8),
        ),
        onPressed: () {
          context.push(
            '/projectAssigned',
            extra: {
              "status": "accepted",
              "projectId": assignedId,
            },
          );
        },
        child: const Text("Accepted", style: TextStyle(color: Colors.white)),
      );
    }

    return const SizedBox();
  }

  Widget buildOptions() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildOptionCard(
            image: 'assets/png/idea.png',
            text: "Have an Idea",
            onTap: haveAnIdeaOnTap,
          ),
          const SizedBox(width: 50),
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
            border: Border.all(color: const Color(0xff4699A8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: AppImage(image: image),
              ),
              const SizedBox(height: 5),
              Text(text, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );

  Widget buildTeamCard() => Center(
        child: SizedBox(
          width: 350,
          child: Card(
            color: const Color(0xff1D1D2E),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Team Members",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                ...members.map(
                  (m) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Row(
                      children: [
                        Text(m.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Edit Team",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4699A8),
                      ),
                      onPressed: () async {
                        final updatedTeam =
                            await context.push<List<TeamMember>>(
                          '/editTeam',
                          extra: members,
                        );
                        if (updatedTeam != null) {
                          setState(() => members = updatedTeam);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildSupervisorCard() => Center(
        child: SizedBox(
          width: 350,
          height: 170,
          child: Card(
            color: const Color(0xff1D1D2E),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Supervisor',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Row(
                    children: [
                      const Text("Dr. Ahmed Ibrahim",
                          style: TextStyle(color: Colors.grey)),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: const Color(0xff4699A8),
                        child: IconButton(
                          icon: const Icon(Icons.chat_bubble,
                              color: Colors.white, size: 18),
                          onPressed: () => context.push('/studentChat'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text('Your Teaching Assistant',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Row(
                    children: const [
                      Text("Eng. Noha Ali",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
