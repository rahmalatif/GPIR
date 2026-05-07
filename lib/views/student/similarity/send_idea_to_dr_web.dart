/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/doctor.dart';
import '../../model/project_idea.dart';

class SendIdeaToDrWebView
    extends StatefulWidget {
  final Doctor doctor;
  final ProjectIdea projectIdea;

  const SendIdeaToDrWebView({
    super.key,
    required this.doctor,
    required this.projectIdea,
  });

  @override
  State<SendIdeaToDrWebView>
  createState() =>
      _SendIdeaToDrWebViewState();
}

class _SendIdeaToDrWebViewState
    extends State<SendIdeaToDrWebView> {
  late TextEditingController nameController;
  late TextEditingController introController;

  bool isEditing = false;
  bool showingSnack = false;

  String get draftNameKey =>
      "draft_name_${widget.projectIdea.title}";

  String get draftDescKey =>
      "draft_desc_${widget.projectIdea.description}";

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.projectIdea.title,
    );

    introController = TextEditingController(
      text: widget.projectIdea.description,
    );

    loadDraft();

    nameController.addListener(_autoSave);
    introController.addListener(_autoSave);
  }

  void _autoSave() {
    if (!isEditing) return;

    saveDraft();

    if (!showingSnack) {
      showingSnack = true;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text("Draft saved"),
          backgroundColor:
          Color(0xff4699A8),
          duration: Duration(seconds: 1),
        ),
      );

      Future.delayed(
        const Duration(seconds: 1),
            () {
          showingSnack = false;
        },
      );
    }
  }

  Future<void> loadDraft() async {
    final prefs =
    await SharedPreferences.getInstance();

    nameController.text =
        prefs.getString(draftNameKey) ??
            nameController.text;

    introController.text =
        prefs.getString(draftDescKey) ??
            introController.text;
  }

  Future<void> saveDraft() async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      draftNameKey,
      nameController.text,
    );

    await prefs.setString(
      draftDescKey,
      introController.text,
    );
  }

  Future<void> clearDraft() async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.remove(draftNameKey);
    await prefs.remove(draftDescKey);
  }

  @override
  void dispose() {
    nameController.dispose();
    introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child: SizedBox(
          width: 900,

          child: SingleChildScrollView(
            padding:
            const EdgeInsets.all(30),

            child: Column(
              children: [
                Row(
                  children: [
                    const BackButton(
                      color: Colors.white,
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      "Send Idea to Doctor",

                      style: TextStyle(
                        color:
                        Colors.white,
                        fontSize: 30,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(
                      24),

                  decoration: BoxDecoration(
                    color:
                    const Color(
                        0xFF0D0F1A),

                    borderRadius:
                    BorderRadius.circular(
                        16),

                    border: Border.all(
                      color: const Color(
                          0xff4699A8),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [
                      isEditing
                          ? TextField(
                        controller:
                        nameController,

                        style:
                        const TextStyle(
                          color:
                          Colors
                              .white,
                        ),

                        decoration:
                        const InputDecoration(
                          labelText:
                          "Project Name",

                          labelStyle:
                          TextStyle(
                            color: Colors
                                .grey,
                          ),
                        ),
                      )
                          : Text(
                        nameController
                            .text,

                        style:
                        const TextStyle(
                          fontSize:
                          24,
                          color: Colors
                              .white,
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),

                      const SizedBox(
                          height: 20),

                      isEditing
                          ? TextField(
                        controller:
                        introController,

                        maxLines: 5,

                        style:
                        const TextStyle(
                          color:
                          Colors
                              .white,
                        ),

                        decoration:
                        const InputDecoration(
                          labelText:
                          "Description",

                          labelStyle:
                          TextStyle(
                            color: Colors
                                .grey,
                          ),
                        ),
                      )
                          : Text(
                        introController
                            .text,

                        style:
                        const TextStyle(
                          color:
                          Colors
                              .grey,
                          fontSize:
                          16,
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      const Text(
                        "Doctor",

                        style: TextStyle(
                          color:
                          Colors.white,
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      Text(
                        widget.doctor.name,

                        style:
                        const TextStyle(
                          color:
                          Colors.white,
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        widget.doctor.track,

                        style:
                        const TextStyle(
                          color:
                          Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      const Text(
                        "Teaching Assistant",

                        style: TextStyle(
                          color:
                          Colors.white,
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      const Text(
                        "Noha Ali",

                        style:
                        TextStyle(
                          color:
                          Colors.white,
                          fontSize: 18,
                        ),
                      ),

                      const Text(
                        "AI",

                        style:
                        TextStyle(
                          color:
                          Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                TextButton(
                  onPressed: () {
                    setState(() {
                      isEditing =
                      !isEditing;
                    });
                  },

                  child: Text(
                    isEditing
                        ? "Save"
                        : "Edit",

                    style:
                    const TextStyle(
                      color: Color(
                          0xff4699A8),

                      fontWeight:
                      FontWeight.bold,

                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 350,

                  child:
                  ElevatedButton(
                    onPressed:
                        () async {
                      await clearDraft();

                      final editedIdea =
                      ProjectIdea(title: '', description: '', tools: [], specialization: [], doctorId: '', taId: '', year: 2026

                      );

                      context.go(
                        '/confirmSubmission',

                        extra: {
                          'doctor':
                          widget
                              .doctor,

                          'projectIdea':
                          editedIdea,

                          'teamMembers':
                          [],
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

                    child:
                    const Text(
                      "Select",

                      style:
                      TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight
                            .bold,
                        color: Colors
                            .white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 */
