import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/project.dart';

class ProjectsRecommendationWebView
    extends StatelessWidget {
  final List<String> tracks;
  final ProjectIdea projectIdea;

  const ProjectsRecommendationWebView({
    super.key,
    required this.tracks,
    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 1100,

          child: Column(
            children: [
              const SizedBox(height: 30),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),

                    onPressed: () {
                      context.pop();
                    },
                  ),

                  const SizedBox(width: 10),

                  const Text(
                    "Recommended Projects",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Expanded(
                child: GridView.builder(
                  padding:
                  const EdgeInsets.all(
                      16),

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.4,
                  ),

                  itemCount: 6,

                  itemBuilder:
                      (context, index) {
                    return _projectCard(
                      context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectCard(
      BuildContext context,
      ) {
    return Container(
      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color:
        const Color(0xFF12152A),

        borderRadius:
        BorderRadius.circular(20),

        border: Border.all(
          color: Colors.cyanAccent
              .withOpacity(0.5),
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          const Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

            children: [
              Expanded(
                child: Text(
                  "Smart Attendance System",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              Text(
                "92% Match",

                style: TextStyle(
                  color:
                  Colors.cyanAccent,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            "A mobile app with QR-based attendance for students and instructors.",

            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),

          const Spacer(),

          Wrap(
            spacing: 8,
            runSpacing: 8,

            children:
            tracks.map((track) {
              return Chip(
                label: Text(
                  track,

                  style:
                  const TextStyle(
                    fontSize: 12,
                  ),
                ),

                backgroundColor:
                Colors.cyanAccent
                    .withOpacity(0.2),

                labelStyle:
                const TextStyle(
                  color: Colors.black,
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          Align(
            alignment:
            Alignment.centerRight,

            child: ElevatedButton(
              style:
              ElevatedButton
                  .styleFrom(
                backgroundColor:
                Colors.cyanAccent,

                foregroundColor:
                Colors.black,

                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                      20),
                ),
              ),

              onPressed: () {
                context.go(
                  '/chooseSupervisor',

                  extra: projectIdea,
                );
              },

              child: const Text(
                "Use This Idea",
              ),
            ),
          ),
        ],
      ),
    );
  }
}