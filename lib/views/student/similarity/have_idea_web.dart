import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/project.dart';

class HaveIdeaWebView extends StatefulWidget {
  const HaveIdeaWebView({super.key});

  @override
  State<HaveIdeaWebView> createState() =>
      _HaveIdeaWebViewState();
}

class _HaveIdeaWebViewState
    extends State<HaveIdeaWebView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController introController =
  TextEditingController();

  final TextEditingController specController =
  TextEditingController();

  final TextEditingController featuresController =
  TextEditingController();

  final TextEditingController techController =
  TextEditingController();

  final TextEditingController teamCountController =
  TextEditingController();

  List<TeamMemberForm> teamMembers = [];

  @override
  void dispose() {
    nameController.dispose();
    introController.dispose();
    specController.dispose();
    featuresController.dispose();
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

    teamMembers =
        List.generate(count, (_) => TeamMemberForm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),

      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 950,

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),

                        onPressed: () =>
                            context.go(
                              '/studentDashboard',
                            ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        "Submit Your Idea",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Padding(
                    padding:
                    EdgeInsets.only(
                      left: 58,
                    ),

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

                  Padding(
                    padding:
                    const EdgeInsets.all(
                        8),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.only(
                            left: 18,
                          ),

                          child: Text(
                            "Number of Team Members",
                            style:
                            TextStyle(
                              fontSize:
                              20,
                              color: Colors
                                  .white,
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 8),

                        SizedBox(
                          width: 400,
                          height: 55,

                          child:
                          TextFormField(
                            controller:
                            teamCountController,

                            keyboardType:
                            TextInputType
                                .number,

                            onChanged:
                                (value) {
                              final count =
                                  int.tryParse(
                                      value) ??
                                      0;

                              setState(() {
                                generateTeamFields(
                                    count);
                              });
                            },

                            validator:
                                (value) {
                              if (value ==
                                  null ||
                                  value
                                      .isEmpty) {
                                return "Number of team members is required";
                              }

                              final count =
                              int.tryParse(
                                  value);

                              if (count ==
                                  null) {
                                return "Invalid number";
                              }

                              if (count <
                                  3 ||
                                  count >
                                      6) {
                                return "Team size must be between 3 and 6";
                              }

                              return null;
                            },

                            decoration:
                            InputDecoration(
                              enabledBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    10),

                                borderSide:
                                const BorderSide(
                                  color: Color(
                                      0xff4699A8),
                                  width: 2,
                                ),
                              ),

                              focusedBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    10),

                                borderSide:
                                const BorderSide(
                                  color: Color(
                                      0xff4699A8),
                                  width: 2,
                                ),
                              ),
                            ),

                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Column(
                    children: List.generate(
                      teamMembers.length,
                          (index) {
                        return Padding(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            vertical: 10,
                          ),

                          child: Row(
                            children: [
                              Expanded(
                                child:
                                _InputTextInline(
                                  "Name",
                                  teamMembers[
                                  index]
                                      .nameController,
                                ),
                              ),

                              const SizedBox(
                                  width: 20),

                              Expanded(
                                child:
                                _InputTextInline(
                                  "Specialization",
                                  teamMembers[
                                  index]
                                      .specializationController,
                                ),
                              ),

                              const SizedBox(
                                  width: 20),

                              Column(
                                children: [
                                  Checkbox(
                                    value:
                                    teamMembers[
                                    index]
                                        .isLeader,

                                    onChanged:
                                        (value) {
                                      setState(
                                              () {
                                            for (var m
                                            in teamMembers) {
                                              m.isLeader =
                                              false;
                                            }

                                            teamMembers[index]
                                                .isLeader =
                                            true;
                                          });
                                    },
                                  ),

                                  const Text(
                                    "Leader",
                                    style:
                                    TextStyle(
                                      color:
                                      Colors
                                          .white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child:
                    ElevatedButton(
                      style:
                      ElevatedButton
                          .styleFrom(
                        backgroundColor:
                        const Color(
                            0xff4699A8),

                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 60,
                          vertical: 18,
                        ),
                      ),

                      onPressed: () {
                        if (!_formKey
                            .currentState!
                            .validate()) {
                          return;
                        }

                        if (!teamMembers.any(
                                (m) =>
                            m.isLeader)) {
                          ScaffoldMessenger
                              .of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please select a Team Leader",
                              ),
                            ),
                          );

                          return;
                        }

                        final projectIdea =
                        ProjectIdea(
                          name:
                          nameController
                              .text
                              .trim(),

                          introduction:
                          introController
                              .text
                              .trim(),

                          technologies: [],
                          specializations:
                          [],
                        );

                        context.go(
                          '/similarityCheck',
                          extra:
                          projectIdea,
                        );
                      },

                      child: const Text(
                        "Check Similarity",
                        style:
                        TextStyle(
                          fontSize: 20,
                          color:
                          Colors.black,
                          fontWeight:
                          FontWeight
                              .bold,
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

Widget _InputText(
    String label,
    TextEditingController controller,
    ) {
  return Padding(
    padding: const EdgeInsets.all(8),

    child: Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Padding(
          padding:
          const EdgeInsets.only(
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
                if (value == null ||
                    value.trim().isEmpty) {
                  return "$label is required";
                }

                return null;
              },

              decoration: InputDecoration(
                errorStyle:
                const TextStyle(
                  color: Colors.red,
                ),

                enabledBorder:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius
                      .circular(10),

                  borderSide:
                  const BorderSide(
                    color:
                    Color(0xff4699A8),
                    width: 2,
                  ),
                ),

                focusedBorder:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius
                      .circular(10),

                  borderSide:
                  const BorderSide(
                    color:
                    Color(0xff4699A8),
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

Widget _InputTextInline(
    String label,
    TextEditingController controller,
    ) {
  return Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,

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

        validator: (value) {
          if (value == null ||
              value.trim().isEmpty) {
            return "Required";
          }

          return null;
        },

        style: const TextStyle(
          color: Colors.white,
        ),

        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 10,
          ),

          enabledBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10),

            borderSide: const BorderSide(
              color: Color(0xff4699A8),
              width: 2,
            ),
          ),

          focusedBorder:
          OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10),

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

class TeamMemberForm {
  TextEditingController nameController =
  TextEditingController();

  TextEditingController
  specializationController =
  TextEditingController();

  bool isLeader = false;

  void dispose() {
    nameController.dispose();
    specializationController.dispose();
  }
}