import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectIdView extends StatefulWidget {
  const ProjectIdView({super.key});

  @override
  State<ProjectIdView> createState() => _ProjectIdViewState();
}

class _ProjectIdViewState extends State<ProjectIdView> {
  final TextEditingController idController = TextEditingController();
  String? errorText;

  void validate() {
    final id = idController.text.trim();

    if (id.isEmpty) {
      errorText = "Please enter project ID";
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(id)) {
      errorText = "Only letters and numbers allowed";
    } else if (id.length < 3) {
      errorText = "ID must be at least 3 characters";
    } else {
      errorText = null;
    }

    setState(() {});
  }

  bool get isValid => errorText == null && idController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
      
              const Text(
                "Project ID",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
      
              const SizedBox(height: 30),
      
              const Text(
                "Project ID:",
                style: TextStyle(color: Colors.cyan),
              ),
      
      
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1D2E),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade700),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Smart Attendance System",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
      
                    const SizedBox(height: 6),
      
                    Row(
                      children: const [
                        Text(
                          "Supervisor: Dr.",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          "Date: 14 April 2025",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
      
                    const SizedBox(height: 6),
      
                    const Text(
                      "Team:",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
      SizedBox(height: 40,),
      
              TextField(
                controller: idController,
                onChanged: (_) => validate(),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  errorText: errorText,
                  hintText: "Enter Project Id",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("CS", style: TextStyle(color: Colors.white)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.cyan, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
      
              const Spacer(),
      
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isValid
                      ? () async {
                    showSuccess(context);
                    if (!context.mounted) return;
                    context.go('/AdminDashboard');
                  }
                      : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4FB3C2),
                    disabledBackgroundColor: Colors.grey.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Assign Project Id",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void showSuccess(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green.shade600,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Row(
        children: const [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 10),
          Text("Project ID assigned successfully"),
        ],
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
