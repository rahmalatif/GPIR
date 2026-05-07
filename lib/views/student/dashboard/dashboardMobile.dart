import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';

import '../../model/team.dart';

class StudentDashboardMobile extends StatefulWidget {
  const StudentDashboardMobile({super.key});

  @override
  State<StudentDashboardMobile> createState() =>
      _StudentDashboardMobileState();
}

class _StudentDashboardMobileState
    extends State<StudentDashboardMobile> {
  List<TeamMember> members = [
    TeamMember(name: "Rahma Ahmed", track: ''),
    TeamMember(name: "Kenzy Mohamed", track: ''),
    TeamMember(name: "AbdElrahman", track: ''),
    TeamMember(name: "Omar Zakaria", track: ''),
    TeamMember(name: "Mohamed Ibrahim", track: ''),
  ];

  void haveAnIdeaOnTap() => context.go('/haveIdea');

  void aiRecommendIdea() => context.go('/aiRecommend');

  String greeting(String name) {
    final hour = DateTime.now().hour;

    if (hour < 12) return 'Good Morning,\n$name';
    if (hour < 17) return 'Good Afternoon,\n$name';
    return 'Good Evening,\n$name';
  }

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0D0F1A),
        title: Text(
          greeting("Rahma"),
          style: const TextStyle(
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
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
    return Center(
      child: SizedBox(
        height: 160,
        width: 340,
        child: Card(
          color: const Color(0xff1D1D2E),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "No project submitted yet",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Supervised By: Not assigned yet",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff4699A8),
                  ),
                  onPressed: null,
                  child: Text(
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
              Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
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
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            ...members.map(
                  (m) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      m.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
              const Text(
                'Your Supervisor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Dr. Ahmed Ibrahim",
                    style: TextStyle(color: Colors.grey),
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
                      onPressed: () =>
                          context.push('/studentChat'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}