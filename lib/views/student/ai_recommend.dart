import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/student/recommended_projects.dart';
import '../model/team.dart';

class AiRecommendView extends StatefulWidget {
  const AiRecommendView({super.key});

  @override
  State<AiRecommendView> createState() => _AiRecommendViewState();
}

class _AiRecommendViewState extends State<AiRecommendView> {
  int teamSize = 3;

  static List<TeamMember> Team = [
    TeamMember(name: "Rahma", track: "Mobile"),
    TeamMember(name: "Kenzy", track: "Backend"),
    TeamMember(name: "Omar", track: "AI"),
  ];

  List<String> getSelectedTracks() {
    return Team.map((member) => member.track).toList();
  }

  final TextEditingController nameController = TextEditingController();

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
      ),
      body: Padding(
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
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 18),

            //team size
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyanAccent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Team Size",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Row(
                    children: [
                      _teamButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (teamSize > 1 && teamSize > Team.length) {
                            setState(() {
                              teamSize--;
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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

            //team members
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.cyanAccent),
              ),
              child: Column(
                children: [
                  ...Team.asMap().entries.map((entry) {
                    int index = entry.key;
                    TeamMember member = entry.value;

                    return ListTile(
                      title: Text(
                        member.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        member.track,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          setState(() {
                            Team.removeAt(index);
                          });
                        },
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (Team.length >= teamSize) {
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
                        "+ Add Member",
                        style: TextStyle(color: Colors.cyanAccent),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectsRecommendationView(
                              tracks: getSelectedTracks().toSet().toList(),

                            ),
                          ),
                        );
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
    );
  }

  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D0F1A),
          title: const Text(
            "Add Member",
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Member Name",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedTrack,
                dropdownColor: const Color(0xFF0D0F1A),
                decoration: const InputDecoration(
                  labelText: "Track",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                iconEnabledColor: Colors.cyanAccent,
                items: tracks.map((track) {
                  return DropdownMenuItem(
                    value: track,
                    child: Text(
                      track,
                      style: const TextStyle(color: Colors.white),
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
                if (Team.length >= teamSize) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "You can't add more members than the team size",
                      ),
                    ),
                  );
                  return;
                }

                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please enter the new member's name",
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  Team.add(
                    TeamMember(
                      name: nameController.text.trim(),
                      track: selectedTrack,
                    ),
                  );
                });

                nameController.clear();
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
        border: Border.all(color: Colors.cyanAccent),
      ),
      child: Icon(
        icon,
        size: 16,
        color: Colors.white,
      ),
    ),
  );
}
