import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/model/project_idea.dart';
import 'package:graduation_project_recommender/views/model/teacher_assistant.dart';

import 'choose_ta_mobile.dart';

class ChooseTAWebView extends StatefulWidget {
  final ProjectIdea projectIdea;

  const ChooseTAWebView({
    super.key,
    required this.projectIdea,
  });

  @override
  State<ChooseTAWebView> createState() =>
      _ChooseTAWebViewState();
}

class _ChooseTAWebViewState
    extends State<ChooseTAWebView> {
  int? selectedIndex;

  final List<TeacherAssistant> teachers = [
    TeacherAssistant(
      name: "Eng. Noha Ali",
      track: "AI & ML",
      email: '',
    ),

    TeacherAssistant(
      name: "Eng. Ahmed",
      track: "Game Development",
      email: '',
    ),

    TeacherAssistant(
      name: "Eng. Alaa Abouelella",
      track: "Embedded",
      email: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 900,

          child: Column(
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
                      context.pop();
                    },
                  ),

                  const SizedBox(width: 10),

                  const Text(
                    "Choose TA",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "Select the TA for your Idea",

                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: ListView.builder(
                  itemCount: teachers.length,

                  itemBuilder:
                      (context, index) {
                    final teacher =
                    teachers[index];

                    return TeacherContainer(
                      teacher: teacher,

                      isSelected:
                      selectedIndex ==
                          index,

                      onTap: () {
                        setState(() {
                          selectedIndex =
                              index;
                        });
                      },
                    );
                  },
                ),
              ),

              SizedBox(
                width: 350,

                child: ElevatedButton(
                  onPressed: () {
                    if (selectedIndex ==
                        null) {
                      ScaffoldMessenger.of(
                          context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please select a TA",
                          ),

                          backgroundColor:
                          Colors.red,
                        ),
                      );

                      return;
                    }

                    context.go(
                      '/sendIdeaToDr',

                      extra: {
                        'projectIdea':
                        widget
                            .projectIdea,

                        'teacher':
                        teachers[
                        selectedIndex!],
                      },
                    );
                  },

                  style:
                  ElevatedButton
                      .styleFrom(
                    backgroundColor:
                    const Color(
                        0xFF0D0F1A),

                    side:
                    const BorderSide(
                      color: Color(
                          0xff4699A8),
                      width: 2,
                    ),

                    padding:
                    const EdgeInsets
                        .symmetric(
                      vertical: 18,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          12),
                    ),
                  ),

                  child: const Text(
                    "Select",

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}