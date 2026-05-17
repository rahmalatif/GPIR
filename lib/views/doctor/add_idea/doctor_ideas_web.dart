import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/doctor_idea_service.dart';

class DoctorMyIdeasWebView extends StatefulWidget {
  const DoctorMyIdeasWebView({
    super.key,
  });

  @override
  State<DoctorMyIdeasWebView> createState() => _DoctorMyIdeasWebViewState();
}

class _DoctorMyIdeasWebViewState extends State<DoctorMyIdeasWebView> {
  late Future<List<dynamic>> ideasFuture;

  @override
  void initState() {
    super.initState();

    ideasFuture = DoctorMyIdeasService.getMyIdeas();
  }

  Future<void> deleteIdea(String ideaId) async {
    final success = await DoctorMyIdeasService.deleteIdea(ideaId);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Idea deleted successfully"),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        ideasFuture = DoctorMyIdeasService.getMyIdeas();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete idea"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Center(
        child: SizedBox(
          width: 900,
          child: FutureBuilder<List<dynamic>>(
            future: ideasFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final ideas = snapshot.data ?? [];

              if (ideas.isEmpty) {
                return const Center(
                  child: Text(
                    "No Ideas Yet",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "My Ideas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4FB6C1),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            await context.push('/addIdea');

                            setState(() {
                              ideasFuture = DoctorMyIdeasService.getMyIdeas();
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Add Idea",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: ideas.length,
                        itemBuilder: (context, index) {
                          final idea = ideas[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1D2E),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  idea['title'] ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        idea['title'] ?? "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final confirm = await showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            backgroundColor:
                                                const Color(0xFF0D0F1A),
                                            title: const Text("Delete Idea",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            content: const Text(
                                                "Are you sure you want to delete this idea?",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                child: const Text("Delete"),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          await deleteIdea(idea['_id']);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  idea['description'] ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: (idea['specialization']
                                              as List<dynamic>?)
                                          ?.map((tool) {
                                        return Chip(
                                          label: Text(tool),
                                          backgroundColor: Colors.cyanAccent,
                                        );
                                      }).toList() ??
                                      [],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
