import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/recommend_select_service.dart';

class ProjectsRecommendationWebView extends StatelessWidget {
  final List<dynamic> ideas;

  const ProjectsRecommendationWebView({
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
      body: Center(
        child: SizedBox(
          width: 1100,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [

                  const SizedBox(width: 10),
                  const Text(
                    "Recommended Projects",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ideas.isEmpty
                    ? const Center(
                        child: Text(
                          "No ideas found",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.4,
                        ),
                        itemCount: ideas.length,
                        itemBuilder: (context, index) {
                          return _projectCard(
                            context,
                            ideas[index],
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
    dynamic idea,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF12152A),
        borderRadius: BorderRadius.circular(20),
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                "AI Idea",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            idea['description'] ?? "",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                (idea['specialization'] as List<dynamic>? ?? []).map((track) {
              return Chip(
                label: Text(
                  track.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
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
