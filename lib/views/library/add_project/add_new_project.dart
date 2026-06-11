import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/library_add_project.dart';
import '../../model/library_data.dart';
import '../../model/library_project.dart';

class AddNewProjectView extends StatefulWidget {
  const AddNewProjectView({super.key});

  @override
  State<AddNewProjectView> createState() => _AddNewProjectViewState();
}

class _AddNewProjectViewState extends State<AddNewProjectView> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final yearController = TextEditingController();
  final specController = TextEditingController();
  final descController = TextEditingController();
  final drController = TextEditingController();
  final taController = TextEditingController();
  final futureWorkController = TextEditingController();
  final toolsController = TextEditingController();

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
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              _input(
                label: "Project Name",
                controller: nameController,
              ),
              const SizedBox(height: 12),
              _input(
                label: "Project Code",
                controller: idController,
              ),
              const SizedBox(height: 12),
              _input(
                label: "Description",
                controller: descController,
              ),
              const SizedBox(height: 12),
              _input(
                label: "Specialization",
                controller: specController,
              ),
              const SizedBox(height: 12),
              _input(
                label: "Tools",
                controller: toolsController,
              ),
              const SizedBox(height: 12),
              _input(
                label: "Doctor",
                controller: drController,
              ),
              const SizedBox(height: 12),
              _input(
                label: "Teacher Assistant",
                controller: taController,
              ),
              const SizedBox(height: 12),
              _input(
                label: "Project Year",
                controller: yearController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              _input(
                label: "Future work",
                controller: futureWorkController,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        idController.text.isEmpty ||
                        yearController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please fill all fields",
                          ),
                        ),
                      );

                      return;
                    }

                    try {
                      await LibraryProjectService.addOldProject(
                        projectCode: idController.text.trim(),
                        title: nameController.text.trim(),
                        description: descController.text.trim(),
                        specialization: specController.text.split(','),
                        tools: toolsController.text.split(','),
                        doctor: drController.text.trim(),
                        ta: taController.text.trim(),
                        year: int.parse(
                          yearController.text,
                        ),
                        futureWork: futureWorkController.text.trim(),
                      );
                      if (!mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Project added successfully",
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );

                      context.go(
                        '/libraryAllProject',
                      );
                    } catch (e) {
                      if (!mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString(),
                          ),
                        ),
                      );
                    }
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
