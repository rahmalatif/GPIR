import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/doctor_add_idea_service.dart';

class AddIdeaMobileView extends StatefulWidget {
  const AddIdeaMobileView({
    super.key,
  });

  @override
  State<AddIdeaMobileView> createState() => _AddIdeaMobileViewState();
}

class _AddIdeaMobileViewState extends State<AddIdeaMobileView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController ideaController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  final TextEditingController fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Add Idea",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _input(
                ideaController,
                "Project Idea",
              ),
              const SizedBox(height: 14),
              _input(
                descController,
                "Project Description",
                maxLines: 4,
              ),
              const SizedBox(height: 14),
              _input(
                fieldController,
                "Specialization",
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4FB6C1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    "Add Idea",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "This field is required" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        filled: true,
        fillColor: const Color(0xFF1A1D2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = ideaController.text.trim();

    final description = descController.text.trim();


    final specialization =
        fieldController.text.split(",").map((e) => e.trim()).toList();

    final similarityData = await DoctorAddIdeaService.checkSimilarity(
      title: title,
      description: description,

      specialization: specialization,
    );

    final allowed = similarityData['allowed'] ?? true;

    final similarity = similarityData['similarity'] ?? 0;

    final similarProject = similarityData['similarProject'];

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1D2E),
          title: const Text(
            "Similarity Result",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Similarity: "
                "${similarity.toString()}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              if (similarProject != null)
                Text(
                  "Similar Project ID:\n"
                  "${similarProject['_id']}",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
              ),
            ),
            if (allowed)
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);

                  final success = await DoctorAddIdeaService.addIdea(
                    title: title,
                    description: description,

                    specialization: specialization,
                  );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Idea added successfully ✅",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        context.pop();
                      },
                    );
                  }
                },
                child: const Text(
                  "Add Anyway",
                ),
              ),
          ],
        );
      },
    );

    return;
  }
}
