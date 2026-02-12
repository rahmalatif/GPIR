import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation_project_recommender/views/model/doctor.dart';
import 'package:graduation_project_recommender/views/model/project.dart';

class SendIdeaToDrView extends StatefulWidget {
  final Doctor doctor;
  final ProjectIdea projectIdea;

  const SendIdeaToDrView({
    super.key,
    required this.doctor,
    required this.projectIdea,
  });

  @override
  State<SendIdeaToDrView> createState() => _SendIdeaToDrViewState();
}

class _SendIdeaToDrViewState extends State<SendIdeaToDrView> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  bool isEditing = false;
  bool showingSnack = false;

  String get draftNameKey => "draft_name_${widget.projectIdea.name}";
  String get draftDescKey => "draft_desc_${widget.projectIdea.name}";

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.projectIdea.name);
    descriptionController =
        TextEditingController(text: widget.projectIdea.description);

    loadDraft();

    nameController.addListener(_autoSave);
    descriptionController.addListener(_autoSave);
  }

  void _autoSave() {
    if (!isEditing) return;

    saveDraft();

    if (!showingSnack) {
      showingSnack = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Draft saved"),
          backgroundColor: Color(0xff4699A8),
          duration: Duration(seconds: 1),
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        showingSnack = false;
      });
    }
  }

  Future<void> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text =
        prefs.getString(draftNameKey) ?? nameController.text;
    descriptionController.text =
        prefs.getString(draftDescKey) ?? descriptionController.text;
  }

  Future<void> saveDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(draftNameKey, nameController.text);
    await prefs.setString(draftDescKey, descriptionController.text);
  }

  Future<void> clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(draftNameKey);
    await prefs.remove(draftDescKey);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Send Idea to Doctor",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 400,
              width: 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D0F1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xff4699A8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEditing
                      ? TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Project Name",
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  )
                      : Text(
                    nameController.text,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  isEditing
                      ? TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Description",
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  )
                      : Text(
                    descriptionController.text,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Doctor",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(widget.doctor.name,
                      style: const TextStyle(color: Colors.white)),
                  Text(widget.doctor.track,
                      style:
                      const TextStyle(color: Colors.grey, fontSize: 12)),

                  const SizedBox(height: 20),

                  const Text(
                    "Teaching Assistant",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text("Noha Ali",
                      style: TextStyle(color: Colors.white)),
                  const Text("AI",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),

            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: Text(
                isEditing ? "Save" : "Edit",
                style: const TextStyle(
                    color: Color(0xff4699A8),
                    fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () async {
                  await clearDraft();

                  final editedIdea = ProjectIdea(
                    name: nameController.text,
                    description: descriptionController.text,
                    specializations: widget.projectIdea.specializations,
                    features: widget.projectIdea.features,
                    technologies: widget.projectIdea.technologies,
                    teamMembers: widget.projectIdea.teamMembers,
                    requiredTracks: widget.projectIdea.requiredTracks,
                  );

                  context.go('/confirmSubmission', extra: {
                    'doctor': widget.doctor,
                    'projectIdea': editedIdea,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D0F1A),
                  side: const BorderSide(
                      color: Color(0xff4699A8), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Select",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
