import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/recommendation_service.dart';
import '../../model/team.dart';
import '../similarity/have_idea_mobile.dart';

class AiRecommendMobile extends StatefulWidget {
  const AiRecommendMobile({super.key});

  @override
  State<AiRecommendMobile> createState() => _AiRecommendMobileState();
}

class _AiRecommendMobileState extends State<AiRecommendMobile> {
  int teamSize = 3;

  static List<TeamMember> team = [];

  List<String> getSelectedTracks() {
    return team.map((member) => member.specializationController.text).toList();
  }

  final List<String> tracks = [
    "AI",
    "Mobile",
    "Backend",
    "Embedded",
    "UI/UX",
    "Web Dev",
    "Cyber Security",
  ];

  String selectedTrack = "Mobile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Center(
          child: Text(
            "AI Recommender",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            context.go('/studentDashboard');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tell us about your team",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "The AI will suggest project ideas based on your team specialization",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                height: 500,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.cyanAccent,
                  ),
                ),
                child: Column(
                  children: [
                    ...team.asMap().entries.map((entry) {
                      int index = entry.key;
                      TeamMember member = entry.value;

                      return ListTile(
                        title: Text(
                          member.specializationController.text,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              team.removeAt(index);
                            });
                          },
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        if (team.length >= teamSize) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "You have reached the maximum team size",
                              ),
                            ),
                          );
                          return;
                        }

                        _showAddMemberDialog();
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "+ Add Specialization",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () async {
                          final tracks = getSelectedTracks();
                          print("TRACKS: $tracks");
                          final ideas =
                              await RecommendationService.recommendIdeas(
                            specializations: tracks,
                          );

                          print("IDEAS: $ideas");
                          if (context.mounted) {
                            context.go(
                              '/projectRecommendation',
                              extra: ideas,
                            );
                          }
                        },
                        child: const Text("Search"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D0F1A),
          title: const Text(
            "Add specializations",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedTrack,
                dropdownColor: const Color(0xFF0D0F1A),
                decoration: const InputDecoration(
                  labelText: "Track",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                iconEnabledColor: Colors.cyanAccent,
                items: tracks.map((track) {
                  return DropdownMenuItem(
                    value: track,
                    child: Text(
                      track,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTrack = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                if (team.length >= teamSize) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "You can't add more members than the team size",
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  TeamMember member = TeamMember();

                  member.specializationController.text = selectedTrack;

                  team.add(member);
                });

                selectedTrack = tracks[0];

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}

Widget _teamButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.cyanAccent,
        ),
      ),
      child: Icon(
        icon,
        size: 16,
        color: Colors.white,
      ),
    ),
  );
}
/*        Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.cyanAccent,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Team Size",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        _teamButton(
                          icon: Icons.remove,
                          onTap: () {
                            if (teamSize > 1 && teamSize > team.length) {
                              setState(() {
                                teamSize--;
                              });
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Text(
                            teamSize.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _teamButton(
                          icon: Icons.add,
                          onTap: () {
                            setState(() {
                              teamSize++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              */