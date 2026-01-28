import 'package:flutter/material.dart';

class ProjectsRecommendationView extends StatelessWidget {
  final List<String> tracks;

  const ProjectsRecommendationView({
    super.key,
    required this.tracks,
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
          return _projectCard();
        },
      ),
    );
  }

  Widget _projectCard() {
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
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
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 12),


          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tracks.map((track) {
              return Chip(
                label: Text(
                  track,
                  style:  TextStyle(fontSize: 11),
                ),
                backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                labelStyle: TextStyle(color: Colors.black),
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
              onPressed: () {},
              child: const Text("Use This Idea"),
            ),
          )
        ],
      ),
    );
  }
}
