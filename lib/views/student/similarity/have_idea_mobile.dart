import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/idea_service.dart';
import '../../model/project_idea.dart';

class HaveIdeaMobileView extends StatefulWidget {
  final dynamic recommendedIdea;

  const HaveIdeaMobileView({super.key, this.recommendedIdea});

  @override
  State<HaveIdeaMobileView> createState() => _HaveIdeaMobileViewState();
}

class _HaveIdeaMobileViewState extends State<HaveIdeaMobileView> {
  final _formKey = GlobalKey<FormState>();

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

  void generateTeamFields(int count) {
    for (var member in teamMembers) {
      member.dispose();
    }

    teamMembers = List.generate(count, (_) => TeamMember());
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
  }

  @override
  Widget build(BuildContext context) {
    print("HAVE IDEA SCREEN OPENED");

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 38,
                  top: 18,
                ),
                child: Text(
                  "Submit Your Idea",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 58,
                ),
                child: Text(
                  "Enter Details about your Graduation project",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                      ),
                      child: Text(
                        "Number of Team Members",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Center(
                      child: SizedBox(
                        width: 350,
                        height: 50,
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
                          decoration: InputDecoration(
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
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: List.generate(
                  teamMembers.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _InputTextInline(
                              "College Code",
                              teamMembers[index].collegeCodeController,
                            ),
                          ),
                          const SizedBox(width: 10),
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
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4699A8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
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
                      final currentCollegeCode = prefs.getInt('collegeCode');
                      print("CURRENT COLLEGE CODE: $currentCollegeCode");
                      if (currentCollegeCode == null) {
                        print("NO COLLEGE CODE");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Login data not found",
                            ),
                          ),
                        );
                        return;
                      }

                      final exists = teamMembers.any(
                        (m) =>
                            int.parse(
                              m.collegeCodeController.text.trim(),
                            ) ==
                            currentCollegeCode,
                      );

                      print("LEADER EXISTS: $exists");

                      if (!exists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Leader must be included in team members",
                            ),
                          ),
                        );

                        return;
                      }

                      final idea = ProjectIdea(
                        title: nameController.text.trim(),
                        description: introController.text.trim(),
                        tools: techController.text
                            .split(',')
                            .map((e) => e.trim())
                            .toList(),
                        specialization: specController.text
                            .split(',')
                            .map((e) => e.trim())
                            .toList(),
                        doctorId: "69f8791a5f9ca3ce23568b60",
                        taId: "69f7c63b77d75c63a665e53c",
                        year: DateTime.now().year,
                        team: TeamData(
                          leaderCollegeCode: currentCollegeCode,
                          members: teamMembers.map((member) {
                            return TeamMemberData(
                              collegeCode: int.parse(
                                member.collegeCodeController.text.trim(),
                              ),
                              specialization:
                                  member.specializationController.text.trim(),
                            );
                          }).toList(),
                        ),
                      );

                      print("IDEA CREATED");

                      print(idea.toJson());

                      print("BEFORE API");

                      final result = await IdeaServices().checkSimilarity(idea);

                      print("AFTER API");

                      print("SIMILARITY RESPONSE: $result");

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

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: $e"),
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
              const SizedBox(height: 20),
            ],
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
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Center(
          child: SizedBox(
            width: 350,
            height: 50,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "$label is required";
                }

                return null;
              },
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                  color: Colors.red,
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
              style: const TextStyle(
                color: Colors.white,
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
