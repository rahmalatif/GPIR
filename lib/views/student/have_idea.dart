import 'package:flutter/material.dart';
import '../model/project.dart';

class HaveIdeaView extends StatefulWidget {
  const HaveIdeaView({super.key});

  @override
  State<HaveIdeaView> createState() => _HaveIdeaViewState();
}

class _HaveIdeaViewState extends State<HaveIdeaView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController specController = TextEditingController();
  final TextEditingController featuresController = TextEditingController();
  final TextEditingController techController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    specController.dispose();
    featuresController.dispose();
    techController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 38.0, top: 18),
                child: Text(
                  "Submit Your Idea",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 58.0),
                child: Text(
                  "Enter Details about your Graduation project",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              _InputText("Project Name", nameController),
              const SizedBox(height: 20),
              _InputText("Project Description", descController),
              const SizedBox(height: 20),
              _InputText("Project Specializations", specController),
              const SizedBox(height: 20),
              _InputText("Project Features", featuresController),
              const SizedBox(height: 20),
              _InputText("Project Technologies", techController),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4699A8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final projectIdea = ProjectIdea(
                        name: nameController.text.trim(),
                        description: descController.text.trim(),
                        specializations: specController.text.trim(),
                        features: featuresController.text.trim(),
                        technologies: techController.text.trim(),
                      );

                      Navigator.pushNamed(
                        context,
                        '/similarityCheck',
                        arguments: projectIdea,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all project details"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Check Similarity",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



Widget _InputText(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        const SizedBox(height: 3),
        Center(
          child: SizedBox(
            width: 350,
            height: 50,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "$label is required";
                }
                return null;
              },
              decoration: InputDecoration(
                errorStyle: const TextStyle(color: Colors.red),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xff4699A8), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xff4699A8), width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
