import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:graduation_project_recommender/core/design/app_image.dart';

import '../../model/team.dart';
import '../similarity/have_idea_mobile.dart';

class StudentDashboardWeb extends StatefulWidget {
  const StudentDashboardWeb({super.key});

  @override
  State<StudentDashboardWeb> createState() => _StudentDashboardWebState();
}

class _StudentDashboardWebState extends State<StudentDashboardWeb> {
  
 /* List<TeamMember> members = [
    TeamMember(
 /*     name: "Rahma Ahmed",
      track: 'mobile',*/
    ),
    TeamMember(

    ),
    TeamMember(

    ),
    TeamMember(

    ),
    TeamMember(

    ),
  ];*/


  void haveAnIdeaOnTap() {
    context.go('/haveIdea');
  }

  void aiRecommendIdea() {
    context.go('/aiRecommend');
  }

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
    String today = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1400,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting("Rahma"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            today,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: const Color(0xff4699A8),
                        child: IconButton(
                          onPressed: () {
                            context.push(
                              '/studentNotifications',
                            );
                          },
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  buildStatusCard(),
                  const SizedBox(height: 40),
                  buildOptions(),
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: buildTeamCard(),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: buildSupervisorCard(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStatusCard() {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Card(
        color: const Color(0xff1D1D2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "No project submitted yet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Supervised By: Not assigned yet",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4699A8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: null,
                    child: const Text(
                      "View Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
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

  Widget buildOptions() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 40,
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
      ),
    );
  }

  Widget buildOptionCard({
    required String image,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        width: 300,
        decoration: BoxDecoration(
          color: const Color(0xff1D1D2E),
          border: Border.all(
            color: const Color(0xff4699A8),
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: AppImage(
                image: image,
              ),
            ),

            const SizedBox(width: 15),

            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamCard() {
    return Card(
      color: const Color(0xff1D1D2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       /*     const Text(
              "Team Members",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...members.map(
              (m) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                 "name",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget buildSupervisorCard() {
    return SizedBox(
      height: 300,
      child: Card(
        color: const Color(0xff1D1D2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Supervisor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Dr. Ahmed Ibrahim",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xff4699A8),
                    child: IconButton(
                      icon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        context.push(
                          '/studentChat',
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
    );
  }
}
