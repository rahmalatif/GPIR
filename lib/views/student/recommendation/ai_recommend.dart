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

const int minTeamSize = 1;
const int maxTeamSize = 6;

class _AiRecommendMobileState extends State<AiRecommendMobile> {
  int teamSize = 0;

  List<TeamMember> team = [];

  final TextEditingController teamSizeController = TextEditingController();

  final List<String> tracks = [
    "AI",
    "Mobile",
    "Backend Development",
    "Frontend Development",
    "Embedded",
    "UI/UX",
    "Web Dev",
    "IoT",
    "Cybersecurity",
    "Cloud"
  ];

  String selectedTrack = "Mobile";

  List<String> getSelectedTracks() {
    return team.map((member) => member.specializationController.text).toList();
  }

  @override
  void dispose() {
    teamSizeController.dispose();
    for (var member in team) {
      member.specializationController.dispose();
    }
    super.dispose();
  }

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
              const SizedBox(height: 4),
              const Text(
                "The AI will suggest project ideas based on your team specialization",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    Row(
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
                                if (teamSize <= minTeamSize) {
                                  _showSnackBar(
                                      "Minimum team size is 1 member");
                                  return;
                                }
                                if (team.length == teamSize) {
                                  _showSnackBar(
                                      "Remove a specialization first");
                                  return;
                                }
                                setState(() {
                                  teamSize--;
                                  teamSizeController.text = teamSize.toString();
                                });
                              },
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: teamSizeController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    hintText: '0',
                                    hintStyle: TextStyle(color: Colors.white)),
                                onChanged: (value) {
                                  setState(() {
                                    int parsed = int.tryParse(value) ?? 0;
                                    if (parsed > maxTeamSize) {
                                      teamSize = maxTeamSize;
                                      teamSizeController.text =
                                          maxTeamSize.toString();
                                      _showSnackBar(
                                          "Maximum team size is $maxTeamSize");
                                    } else {
                                      teamSize = parsed;
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            _teamButton(
                              icon: Icons.add,
                              onTap: () {
                                if (teamSize >= maxTeamSize) {
                                  _showSnackBar(
                                      "Maximum team size is 6 members");
                                  return;
                                }
                                setState(() {
                                  teamSize++;
                                  teamSizeController.text = teamSize.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent.withOpacity(.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.groups, color: Colors.cyanAccent),
                          const SizedBox(width: 10),
                          Text(
                            "Added Specializations: ${team.length}/$teamSize",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (team.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            "No specializations added yet.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ...team.asMap().entries.map((entry) {
                      int index = entry.key;
                      TeamMember member = entry.value;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          member.specializationController.text,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            setState(() {
                              team[index].specializationController.dispose();
                              team.removeAt(index);
                            });
                          },
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        if (teamSize <= 0) {
                          _showSnackBar("Please enter your team size first");
                          return;
                        }
                        if (team.length >= teamSize) {
                          _showSnackBar(
                              "You have reached the maximum team size");
                          return;
                        }
                        _showAddMemberDialog();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: Text(
                          "+ Add Specialization",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        onPressed: () async {
                          if (teamSize <= 0) {
                            _showSnackBar("Please select team size");
                            return;
                          }
                          if (team.isEmpty) {
                            _showSnackBar(
                                "Please add at least one specialization");
                            return;
                          }
                          if (team.length != teamSize) {
                            _showSnackBar(
                                "Please add $teamSize specializations");
                            return;
                          }

                          final tracksList = getSelectedTracks();
                          final ideas =
                              await RecommendationService.recommendIdeas(
                            specializations: tracksList,
                          );

                          if (context.mounted) {
                            context.go('/projectRecommendation', extra: ideas);
                          }
                        },
                        child: const Text("Search",
                            style: TextStyle(fontWeight: FontWeight.bold)),
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showAddMemberDialog() {
    final availableTracks = tracks
        .where(
          (track) => !team.any(
            (member) => member.specializationController.text == track,
          ),
        )
        .toList();

    String? currentValue;

    if (availableTracks.contains(selectedTrack)) {
      currentValue = selectedTrack;
    } else if (availableTracks.isNotEmpty) {
      currentValue = availableTracks.first;
    } else {
      currentValue = null;
    }
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF0D0F1A),
              title: const Text(
                "Add specialization",
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: currentValue,
                    dropdownColor: const Color(0xFF0D0F1A),
                    decoration: const InputDecoration(
                      labelText: "Track",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    iconEnabledColor: Colors.cyanAccent,
                    items: availableTracks.map((track) {
                      return DropdownMenuItem<String>(
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
                      if (value == null) return;

                      setDialogState(() {
                        selectedTrack = value;
                      });
                    },
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (team.length >= teamSize) {
                      _showSnackBar(
                          "You can't add more members than the team size");
                      return;
                    }

                    bool exists = team.any(
                      (e) => e.specializationController.text == selectedTrack,
                    );

                    if (exists) {
                      _showSnackBar("$selectedTrack already added");
                      return;
                    }

                    setState(() {
                      TeamMember member = TeamMember();
                      member.specializationController.text = selectedTrack;
                      team.add(member);
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
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
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.cyanAccent),
      ),
      child: Icon(
        icon,
        size: 18,
        color: Colors.white,
      ),
    ),
  );
}
