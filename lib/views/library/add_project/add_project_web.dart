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
  void dispose() {
    nameController.dispose();
    idController.dispose();
    yearController.dispose();
    specController.dispose();
    descController.dispose();
    drController.dispose();
    taController.dispose();
    futureWorkController.dispose();
    toolsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 768;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        title: const Text(
          "Add New Project",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Container(
              constraints: BoxConstraints(maxWidth: isWeb ? 800 : double.infinity),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isWeb) ...[
                    Row(
                      children: [
                        Expanded(child: _input(label: "Project Name", controller: nameController)),
                        const SizedBox(width: 20),
                        Expanded(child: _input(label: "Project Code", controller: idController)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _input(label: "Description", controller: descController, maxLines: 3),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _input(label: "Specialization (comma separated)", controller: specController)),
                        const SizedBox(width: 20),
                        Expanded(child: _input(label: "Tools (comma separated)", controller: toolsController)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _input(label: "Doctor", controller: drController)),
                        const SizedBox(width: 20),
                        Expanded(child: _input(label: "Teacher Assistant", controller: taController)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _input(label: "Project Year", controller: yearController, keyboardType: TextInputType.number)),
                        const SizedBox(width: 20),
                        Expanded(child: _input(label: "Future work", controller: futureWorkController)),
                      ],
                    ),
                  ] else ...[
                    _input(label: "Project Name", controller: nameController),
                    const SizedBox(height: 12),
                    _input(label: "Project Code", controller: idController),
                    const SizedBox(height: 12),
                    _input(label: "Description", controller: descController, maxLines: 3),
                    const SizedBox(height: 12),
                    _input(label: "Specialization (comma separated)", controller: specController),
                    const SizedBox(height: 12),
                    _input(label: "Tools (comma separated)", controller: toolsController),
                    const SizedBox(height: 12),
                    _input(label: "Doctor", controller: drController),
                    const SizedBox(height: 12),
                    _input(label: "Teacher Assistant", controller: taController),
                    const SizedBox(height: 12),
                    _input(label: "Project Year", controller: yearController, keyboardType: TextInputType.number),
                    const SizedBox(height: 12),
                    _input(label: "Future work", controller: futureWorkController),
                  ],
                  const SizedBox(height: 32),
                  Center(
                    child: SizedBox(
                      width: isWeb ? 300 : double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.trim().isEmpty ||
                              idController.text.trim().isEmpty ||
                              yearController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please fill all required fields (*)")),
                            );
                            return;
                          }

                          try {
                            await LibraryProjectService.addOldProject(
                              projectCode: idController.text.trim(),
                              title: nameController.text.trim(),
                              description: descController.text.trim(),
                              specialization: specController.text.split(',').map((e) => e.trim()).toList(),
                              tools: toolsController.text.split(',').map((e) => e.trim()).toList(),
                              doctor: drController.text.trim(),
                              ta: taController.text.trim(),
                              year: int.parse(yearController.text.trim()),
                              futureWork: futureWorkController.text.trim(),
                            );

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Project added successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );

                            context.go('/libraryAllProject');
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
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
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF161926),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xff6EC6D9),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}