import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/library_data.dart';
import '../model/library_project.dart';

class AddNewProjectView extends StatefulWidget {
  const AddNewProjectView({super.key});

  @override
  State<AddNewProjectView> createState() => _AddNewProjectViewState();
}

class _AddNewProjectViewState extends State<AddNewProjectView> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Add New Project",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            _input(
              label: "Project Name",
              controller: nameController,
            ),
            const SizedBox(height: 12),

            _input(
              label: "Project ID",
              controller: idController,
            ),
            const SizedBox(height: 12),

            _input(
              label: "Project Year",
              controller: yearController,
              keyboardType: TextInputType.number,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      idController.text.isEmpty ||
                      yearController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all fields"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  LibraryData.projects.add(
                    LibraryProject(
                      id: idController.text,
                      name: nameController.text,
                      year: yearController.text,
                      description: "No description yet",
                      doctor: "Dr. Ahmed Ibrahim",
                      teachingAssistant: "Eng. Noha Ali",
                      team: [],
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Project added successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  context.go('/libraryAllProject');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6EC6D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Add Project",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
