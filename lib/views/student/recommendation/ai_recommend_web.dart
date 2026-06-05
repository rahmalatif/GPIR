import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/recommendation_service.dart';
import '../../model/team.dart';
import '../similarity/have_idea_mobile.dart'; // يمكنك استبداله أو تركه حسب مسارات مشروعك

class AiRecommendWeb extends StatefulWidget {
  const AiRecommendWeb({super.key});

  @override
  State<AiRecommendWeb> createState() => _AiRecommendWebState();
}

const int minTeamSize = 1;
const int maxTeamSize = 6;

class _AiRecommendWebState extends State<AiRecommendWeb> {
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
  void initState() {
    super.initState();
    teamSizeController.text = teamSize.toString();
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
    // الحصول على عرض الشاشة لتحديد التصميم responsive
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 900;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "AI Recommender",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/studentDashboard'),
        ),
      ),
      body: Center(
        child: Container(
          // تحديد أقصى عرض للمحتوى في الويب لكي لا يتمدد بشكل عريض ومزعج للعين
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // رأس الصفحة (Header)
                const Text(
                  "Tell us about your team",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "The AI will suggest project ideas based on your team specialization",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),

                // بناء التصميم بناءً على حجم الشاشة
                isLargeScreen
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildTeamSizeCard()),
                    const SizedBox(width: 32),
                    Expanded(child: _buildSpecializationsCard()),
                  ],
                )
                    : Column(
                  children: [
                    _buildTeamSizeCard(),
                    const SizedBox(height: 24),
                    _buildSpecializationsCard(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // كارت تحديد حجم الفريق
  Widget _buildTeamSizeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF14172A), // خلفية أغمق قليلاً لتمييز الكروت بالويب
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Team Size",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  _teamButton(
                    icon: Icons.remove,
                    onTap: () {
                      if (teamSize <= minTeamSize) {
                        _showSnackBar("Minimum team size is 1 member");
                        return;
                      }
                      if (team.length == teamSize) {
                        _showSnackBar("Remove a specialization first");
                        return;
                      }
                      setState(() {
                        teamSize--;
                        teamSizeController.text = teamSize.toString();
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: teamSizeController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: '0',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        setState(() {
                          int parsed = int.tryParse(value) ?? 0;
                          if (parsed > maxTeamSize) {
                            teamSize = maxTeamSize;
                            teamSizeController.text = maxTeamSize.toString();
                            _showSnackBar("Maximum team size is $maxTeamSize");
                          } else {
                            teamSize = parsed;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  _teamButton(
                    icon: Icons.add,
                    onTap: () {
                      if (teamSize >= maxTeamSize) {
                        _showSnackBar("Maximum team size is 6 members");
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
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.cyanAccent.withOpacity(0.15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.groups, color: Colors.cyanAccent, size: 24),
                const SizedBox(width: 12),
                Text(
                  "Added Specializations: ${team.length} / $teamSize",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // كارت إضافة وعرض التخصصات
  Widget _buildSpecializationsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF14172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Specializations List",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          if (team.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  "No specializations added yet.",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
          // تحديد حجم أقصى لقائمة التخصصات مع إمكانية السكرول الداخلي إذا زادت
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: team.length,
              itemBuilder: (context, index) {
                TeamMember member = team[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    color: const Color(0xFF1E2238),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(
                        member.specializationController.text,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent, size: 22),
                        onPressed: () {
                          setState(() {
                            team[index].specializationController.dispose();
                            team.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (teamSize <= 0) {
                  _showSnackBar("Please enter your team size first");
                  return;
                }
                if (team.length >= teamSize) {
                  _showSnackBar("You have reached the maximum team size");
                  return;
                }
                _showAddMemberDialog();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.cyanAccent, size: 20),
                    SizedBox(width: 4),
                    Text(
                      "Add Specialization",
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 4,
              ),
              onPressed: () async {
                if (teamSize <= 0) {
                  _showSnackBar("Please select team size");
                  return;
                }
                if (team.isEmpty) {
                  _showSnackBar("Please add at least one specialization");
                  return;
                }
                if (team.length != teamSize) {
                  _showSnackBar("Please add $teamSize specializations");
                  return;
                }

                final tracksList = getSelectedTracks();
                final ideas = await RecommendationService.recommendIdeas(
                  specializations: tracksList,
                );

                if (context.mounted) {
                  context.go('/projectRecommendation', extra: ideas);
                }
              },
              child: const Text(
                "Search Ideas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)),
        behavior: SnackBarBehavior.floating,
        width: 400, // تحديد عرض الـ SnackBar بالويب لكي لا يأخذ كامل الشاشة بشكل سيء
      ),
    );
  }

  void _showAddMemberDialog() {
    final availableTracks = tracks
        .where((track) => !team.any((member) => member.specializationController.text == track))
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
              backgroundColor: const Color(0xFF14172A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text(
                "Add specialization",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: 400, // تحديد عرض الـ Dialog في الويب لتنسيق أفضل
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: currentValue,
                      dropdownColor: const Color(0xFF14172A),
                      decoration: const InputDecoration(
                        labelText: "Track",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                      ),
                      iconEnabledColor: Colors.cyanAccent,
                      items: availableTracks.map((track) {
                        return DropdownMenuItem<String>(
                          value: track,
                          child: Text(track, style: const TextStyle(color: Colors.white)),
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
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 15)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    if (team.length >= teamSize) {
                      _showSnackBar("You can't add more members than the team size");
                      return;
                    }

                    bool exists = team.any((e) => e.specializationController.text == selectedTrack);
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
                  child: const Text("Add", style: TextStyle(fontWeight: FontWeight.bold)),
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
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.cyanAccent),
          color: Colors.cyanAccent.withOpacity(0.05),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    ),
  );
}