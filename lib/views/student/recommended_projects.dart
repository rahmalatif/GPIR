import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/student/choose_supervisor.dart';

import '../model/project.dart';

class ProjectsRecommendationView extends StatelessWidget {
  final List<String> tracks;
  final ProjectIdea projectIdea;

  const ProjectsRecommendationView({
    super.key,
    required this.tracks,
    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Recommended Projects",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _projectCard(context);
        },
      ),
    );
  }

  Widget _projectCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF12152A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Smart Attendance System",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "92% Match",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Text(
            "A mobile app with QR-based attendance for students and instructors.",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tracks.map((track) {
              return Chip(
                label: Text(
                  track,
                  style: const TextStyle(fontSize: 11),
                ),
                backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                labelStyle: const TextStyle(color: Colors.black),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                context.go(
                  '/chooseSupervisor',
                  extra: projectIdea,
                );
              },
              child: const Text("Use This Idea"),
            ),
          ),
        ],
      ),
    );
  }
}


