import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';
import '../../../core/design/nav_bar.dart';

import '../../model/team.dart';

class StudentDashboardWeb extends StatefulWidget {
  const StudentDashboardWeb({super.key});

  @override
  State<StudentDashboardWeb> createState() =>
      _StudentDashboardWebState();
}

class _StudentDashboardWebState
    extends State<StudentDashboardWeb> {
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
      body: Row(
        children: [
         

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting("Rahma"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      today,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 30),

                    buildStatusCard(),

                    const SizedBox(height: 30),

                    buildOptions(),

                    const SizedBox(height: 30),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: buildTeamCard()),
                        const SizedBox(width: 20),
                        Expanded(child: buildSupervisorCard()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatusCard() {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Card(
        color: const Color(0xff1D1D2E),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "No project submitted yet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
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
                child: const Text(
                  "View Details",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildOptions() => Wrap(
    spacing: 50,
    runSpacing: 20,
    children: [
      buildOptionCard(
        image: 'assets/png/idea.png',
        text: "Have an Idea",
        onTap: haveAnIdeaOnTap,
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
          height: 150,
          width: 180,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff4699A8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: AppImage(image: image),
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildTeamCard() => Card(
    color: const Color(0xff1D1D2E),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Team Members",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),

          ...members.map(
                (m) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                m.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildSupervisorCard() => SizedBox(
    height: 220,
    child: Card(
      color: const Color(0xff1D1D2E),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Supervisor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Text(
                  "Dr. Ahmed Ibrahim",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
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
  );
}