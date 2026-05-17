import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/doctor_idea_service.dart';

class DoctorMyIdeasMobileView extends StatefulWidget {
  const DoctorMyIdeasMobileView({
    super.key,
  });

  @override
  State<DoctorMyIdeasMobileView> createState() =>
      _DoctorMyIdeasMobileViewState();
}

class _DoctorMyIdeasMobileViewState extends State<DoctorMyIdeasMobileView> {
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "My Ideas",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
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

          return ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: ideas.length,
            itemBuilder: (context, index) {
              final idea = ideas[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1D2E),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      idea['title'] ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                title: const Text("Delete Idea"),
                                content: const Text(
                                  "Are you sure you want to delete this idea?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text("Cancel"),
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
                    const SizedBox(height: 10),
                    Text(
                      idea['description'] ?? "",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      children: (idea['tools'] as List<dynamic>?)?.map((tool) {
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4FB6C1),
        onPressed: () async {
          await context.push('/addIdea');

          setState(() {
            ideasFuture = DoctorMyIdeasService.getMyIdeas();
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
