import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/model/doctor.dart';
import 'package:graduation_project_recommender/views/model/project.dart';

import '../../../core/design/app_image.dart';
import 'choose_supervisor_mobile.dart';

class ChooseSupervisorWebView
    extends StatefulWidget {
  final ProjectIdea projectIdea;

  const ChooseSupervisorWebView({
    super.key,
    required this.projectIdea,
  });

  @override
  State<ChooseSupervisorWebView>
  createState() =>
      _ChooseSupervisorWebViewState();
}

class _ChooseSupervisorWebViewState
    extends State<ChooseSupervisorWebView> {
  int? selectedIndex;

  final List<Doctor> doctors = [
    Doctor(
      uid: 'wclDUPKYl0dEr8upoa8Zwj5YZA93',
      apiId: '1',
      name: "Dr. Ahmed Ibrahim",
      track: "Backend",
      slots: 5,
      status: SupervisorStatus.available,
      image: "assets/png/man.png",
      email: "ahmed@gmail.com",
    ),
    Doctor(
      uid: '2',
      apiId: '2',
      name: "Dr. Lamiaa",
      track: "Backend",
      slots: 0,
      status: SupervisorStatus.full,
      image: "assets/png/women.png",
      email: "lamiaa@gmail.com",
    ),
    Doctor(
      uid: 'AxWYsA5Z03M2qWHj7SZ8M6vI6Ug2',
      apiId: '3',
      name: "Dr. Abdelfattah",
      track: "AI & ML",
      slots: 1,
      status: SupervisorStatus.almostFull,
      image: "assets/png/man.png",
      email: "abdelfattah@gmail.com",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),

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
                    "Choose Supervisor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "Select the supervisor for your Idea",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder:
                      (context, index) {
                    final doctor =
                    doctors[index];

                    return DoctorContainer(
                      doctor: doctor,
                      isSelected:
                      selectedIndex ==
                          index,
                      onTap: () {
                        if (doctor.status ==
                            SupervisorStatus
                                .full) {
                          return;
                        }

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
                            "Please select a supervisor",
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
                        widget.projectIdea,
                        'doctor': doctors[
                        selectedIndex!],
                      },
                    );
                  },

                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(
                        0xFF0D0F1A),

                    side: const BorderSide(
                      color:
                      Color(0xff4699A8),
                      width: 2,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                          12),
                    ),

                    padding:
                    const EdgeInsets
                        .symmetric(
                      vertical: 18,
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