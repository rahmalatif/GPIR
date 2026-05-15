import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/logic/api_service.dart';
import '../../model/project_idea.dart';

class ConfirmSubmissionWebView extends StatefulWidget {
  final dynamic doctor;
  final dynamic ta;
  final ProjectIdea projectIdea;
  final double? similarityScore;

  const ConfirmSubmissionWebView({
    super.key,
    required this.doctor,
    required this.ta,
    required this.projectIdea,
    required this.similarityScore,
  });

  @override
  State<ConfirmSubmissionWebView> createState() =>
      _ConfirmSubmissionWebViewState();
}

class _ConfirmSubmissionWebViewState extends State<ConfirmSubmissionWebView> {
  bool isLoading = false;

  Future<void> submitProject() async {
    setState(() => isLoading = true);

    try {
      final Map<String, dynamic> projectData = widget.projectIdea.toJson();
      print("SIMILARITY SCORE = ${widget.similarityScore}");
      print("TYPE = ${widget.similarityScore.runtimeType}");
      projectData['similarity_score'] = widget.similarityScore ?? 0;
      projectData['doctor_id'] = widget.doctor.apiId;
      projectData['ta_id'] = widget.ta['_id'];

      print("SENDING TO API: $projectData");

      final result = await ApiService.addProject(
        projectData: projectData,
      );

      print("API RESULT: $result");

      if (!mounted) return;

      context.go('/studentDashboard');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const Text(
                  "Review Submission",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Check your project details before final submission",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 40),

                // Main Review Card
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1D2E),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: const Color(0xff4699A8).withOpacity(0.5)),
                  ),
                  child: Column(
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Color(0xFF25293D),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: Text(
                          widget.projectIdea.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Wrap(
                          spacing: 40,
                          runSpacing: 30,
                          alignment: WrapAlignment.start,
                          children: [
                            // Left Side: Description
                            SizedBox(
                              width: 450,
                              child: _buildInfoSection("Project Description",
                                  widget.projectIdea.description),
                            ),

                            // Right Side: Team & Supervisors
                            SizedBox(
                              width: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoSection(
                                    "Supervisor",
                                    widget.doctor.name,
                                  ),
                                  const SizedBox(height: 24),
                                  _buildInfoSection("Teaching Assistant",
                                      widget.ta['name'] ?? ''),
                                  const SizedBox(height: 24),
                                  _buildTeamSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Action Buttons
                SizedBox(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : submitProject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4699A8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Confirm & Submit Project",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Color(0xff4699A8),
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        const SizedBox(height: 8),
        Text(content,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, height: 1.5)),
      ],
    );
  }

  Widget _buildTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Team Members",
            style: TextStyle(
                color: Color(0xff4699A8),
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        const SizedBox(height: 12),
        ...widget.projectIdea.team.members.map(
          (member) => Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              member.collegeCode.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
