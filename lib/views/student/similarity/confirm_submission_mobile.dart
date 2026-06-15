import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/logic/api_service.dart';
import '../../model/project_idea.dart';

class ConfirmSubmissionMobileView extends StatefulWidget {
  final dynamic doctor;

  final dynamic ta;
  final double? similarityScore;
  final ProjectIdea projectIdea;

  const ConfirmSubmissionMobileView({
    super.key,
    required this.doctor,
    required this.ta,
    required this.projectIdea,
    required this.similarityScore,
  });

  @override
  State<ConfirmSubmissionMobileView> createState() =>
      _ConfirmSubmissionMobileViewState();
}

class _ConfirmSubmissionMobileViewState
    extends State<ConfirmSubmissionMobileView> {
  bool isLoading = false;

  Future<void> submitProject() async {
    setState(() {
      isLoading = true;
    });

    try {
      final projectData = widget.projectIdea.toJson();
      print("SIMILARITY SCORE = ${widget.similarityScore}");
      print("TYPE = ${widget.similarityScore.runtimeType}");
      projectData['similarity_score'] = widget.similarityScore ?? 0;
      projectData['doctor_id'] = widget.doctor.apiId;

      projectData['ta_id'] = widget.ta['_id'];

      print(
        "FINAL PROJECT DATA: "
        "$projectData",
      );
      print("PROJECT DATA BEFORE SEND:");
      print(projectData);
      final result = await ApiService.addProject(
        projectData: projectData,
      );

      print(
        "FINAL RESPONSE: $result",
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Project submitted successfully ✅",
            ),
            backgroundColor: Colors.green,
          ),
        );

        context.go(
          '/studentDashboard',
        );
      }
    } catch (e) {
      print("SUBMIT ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,

        title: const Text(
          "Confirm Submission",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Review your project before submission",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xff4699A8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.projectIdea.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.projectIdea.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Supervisor",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.doctor.name ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Teaching Assistant",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.ta['name'] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Team Members",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.projectIdea.team.members.map(
                    (member) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Text(
                        member.collegeCode.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : submitProject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4699A8),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Submit Project",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
