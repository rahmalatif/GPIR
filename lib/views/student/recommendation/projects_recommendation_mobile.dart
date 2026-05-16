import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/recommend_select_service.dart';

class ProjectsRecommendationMobileView extends StatelessWidget {
  final List<dynamic> ideas;

  const ProjectsRecommendationMobileView({
    super.key,
    required this.ideas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Recommended Projects",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            context.go('/aiRecommend');
          },
        ),
      ),
      body: ideas.isEmpty
          ? const Center(
              child: Text(
                "No ideas found",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ideas.length,
              itemBuilder: (context, index) {
                return _projectCard(
                  context,
                  ideas[index],
                );
              },
            ),
    );
  }

  Widget _projectCard(
    BuildContext context,
    dynamic idea,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF12152A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  idea['title'] ?? "Unknown",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                "AI Idea",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            idea['description'] ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                (idea['specialization'] as List<dynamic>? ?? []).map((track) {
              return Chip(
                label: Text(
                  track.toString(),
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
                backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
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
              onPressed: () async {
                final success = await RecommendSelectService.selectIdea(
                  idea['_id'],
                );

                if (success) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Idea Selected ✅",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    context.push(
                      '/haveIdea',
                      extra: idea,
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Something went wrong",
                      ),
                    ),
                  );
                }
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
