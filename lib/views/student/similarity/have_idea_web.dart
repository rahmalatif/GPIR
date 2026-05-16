import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/idea_service.dart';
import '../../model/project_idea.dart';

class HaveIdeaWebView extends StatefulWidget {
  final dynamic recommendedIdea;

  const HaveIdeaWebView({
    super.key,
    this.recommendedIdea,
  });

  @override
  State<HaveIdeaWebView> createState() => _HaveIdeaWebViewState();
}

class _HaveIdeaWebViewState extends State<HaveIdeaWebView> {
  final _formKey = GlobalKey<FormState>();
  bool hasTeam = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  final TextEditingController specController = TextEditingController();
  final TextEditingController techController = TextEditingController();
  final TextEditingController teamCountController = TextEditingController();

  List<TeamMember> teamMembers = [];

  @override
  void dispose() {
    nameController.dispose();
    introController.dispose();
    specController.dispose();
    techController.dispose();
    teamCountController.dispose();

    for (var member in teamMembers) {
      member.dispose();
    }

    super.dispose();
  }

  Future<void> checkIfHasTeam() async {
    final prefs = await SharedPreferences.getInstance();

    hasTeam = prefs.getBool(
          'hasTeam',
        ) ??
        false;

    setState(() {});
  }

  void generateTeamFields(int count) {
    for (var member in teamMembers) {
      member.dispose();
    }

    teamMembers = List.generate(
      count,
      (_) => TeamMember(),
    );
  }

  void fillRecommendedIdea() {
    if (widget.recommendedIdea == null) {
      return;
    }

    final idea = widget.recommendedIdea;

    nameController.text = idea['title'] ?? '';

    introController.text = idea['description'] ?? '';

    specController.text =
        (idea['specialization'] as List<dynamic>? ?? []).join(', ');

    techController.text = (idea['Tools'] as List<dynamic>? ?? []).join(', ');
  }

  @override
  void initState() {
    super.initState();
    fillRecommendedIdea();

    checkIfHasTeam();
  }

  @override
  Widget build(BuildContext context) {
    print("HAVE IDEA WEB SCREEN OPENED");

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 1100,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          context.go('/studentDashboard');
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Submit Your Idea",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 58),
                    child: Text(
                      "Enter Details about your Graduation project",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _InputText(
                    "Project Title",
                    nameController,
                  ),
                  _InputText(
                    "Project Description",
                    introController,
                  ),
                  _InputText(
                    "Project Specializations",
                    specController,
                  ),
                  _InputText(
                    "Project Tools",
                    techController,
                  ),
                  const SizedBox(height: 20),
                  if (!hasTeam)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: Text(
                                    "Number of Team Members",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: teamCountController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      final count = int.tryParse(value) ?? 0;

                                      setState(() {
                                        generateTeamFields(count);
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Number of team members is required";
                                      }

                                      final count = int.tryParse(value);

                                      if (count == null) {
                                        return "Invalid number";
                                      }

                                      if (count < 2 || count > 5) {
                                        return "Team size must be between 2 and 5";
                                      }

                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xff1D1D2E),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 18,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: Color(0xff4699A8),
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: Color(0xff4699A8),
                                          width: 2.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (!hasTeam)
                    Column(
                      children: List.generate(
                        teamMembers.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _InputTextInline(
                                    "College Code",
                                    teamMembers[index].collegeCodeController,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _InputTextInline(
                                    "Specialization",
                                    teamMembers[index].specializationController,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4699A8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 18,
                        ),
                      ),
                      onPressed: () async {
                        print("BUTTON CLICKED");

                        if (!_formKey.currentState!.validate()) {
                          print("VALIDATION FAILED");

                          return;
                        }

                        print("VALIDATION PASSED");

                        try {
                          final prefs = await SharedPreferences.getInstance();

                          final currentCollegeCode = prefs.getInt(
                            'collegeCode',
                          );

                          print(
                            "CURRENT COLLEGE CODE: $currentCollegeCode",
                          );

                          if (currentCollegeCode == null) {
                            print("NO COLLEGE CODE");

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Login data not found",
                                ),
                              ),
                            );

                            return;
                          }

                          if (!hasTeam) {
                            final exists = teamMembers.any(
                              (m) =>
                                  int.parse(
                                    m.collegeCodeController.text.trim(),
                                  ) ==
                                  currentCollegeCode,
                            );

                            if (!exists) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Leader must be included in team members",
                                  ),
                                ),
                              );

                              return;
                            }
                          }

                          final idea = ProjectIdea(
                            title: nameController.text.trim(),
                            description: introController.text.trim(),
                            tools: techController.text
                                .split(',')
                                .map(
                                  (e) => e.trim(),
                                )
                                .toList(),
                            specialization: specController.text
                                .split(',')
                                .map(
                                  (e) => e.trim(),
                                )
                                .toList(),
                            year: DateTime.now().year,
                            team: hasTeam
                                ? TeamData(
                                    leaderCollegeCode: currentCollegeCode,
                                    members: [],
                                  )
                                : TeamData(
                                    leaderCollegeCode: currentCollegeCode,
                                    members: teamMembers.map(
                                      (member) {
                                        return TeamMemberData(
                                          collegeCode: int.parse(
                                            member.collegeCodeController.text
                                                .trim(),
                                          ),
                                          specialization: member
                                              .specializationController.text
                                              .trim(),
                                        );
                                      },
                                    ).toList(),
                                  ),
                            doctorId: '',
                            taId: '',
                          );

                          print("IDEA CREATED");

                          print(idea.toJson());

                          print("BEFORE API");

                          final result = await IdeaServices().checkSimilarity(
                            idea,
                          );

                          if (!context.mounted) {
                            return;
                          }

                          print("AFTER API");

                          print(
                            "SIMILARITY RESPONSE: $result",
                          );

                          context.go(
                            '/similarityCheck',
                            extra: {
                              'result': result,
                              'projectIdea': idea,
                            },
                          );

                          print("NAVIGATION DONE");
                        } catch (e) {
                          print("ERROR: $e");

                          if (!mounted) return;

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Error: $e",
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Check Similarity",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _InputTextInline(
  String label,
  TextEditingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 5),
      TextFormField(
        controller: controller,
        keyboardType:
            label == "College Code" ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Required";
          }

          return null;
        },
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xff4699A8),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xff4699A8),
              width: 2,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _InputText(
  String label,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 8,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 5,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "$label is required";
              }

              return null;
            },
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xff1D1D2E),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  14,
                ),
                borderSide: const BorderSide(
                  color: Color(0xff4699A8),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  14,
                ),
                borderSide: const BorderSide(
                  color: Color(0xff4699A8),
                  width: 2.5,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class TeamMember {
  TextEditingController collegeCodeController = TextEditingController();

  TextEditingController specializationController = TextEditingController();

  void dispose() {
    collegeCodeController.dispose();

    specializationController.dispose();
  }
}
