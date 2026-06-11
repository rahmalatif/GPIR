import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryProjectDetailsView extends StatelessWidget {
  final Map<String, dynamic> project;

  const LibraryProjectDetailsView({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Project Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                project["title"] ?? project["title"] ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            _infoCard(
              "Project Code",
              project["project_code"] ??
                  project["Project Code"] ??
                  project["Project Code"] ??
                  "",
            ),
            _infoCard(
              "Year",
              project["Year"] ?? "",
            ),
            _infoCard(
              "Status",
              project["Status"] ?? "",
            ),
            _infoCard(
              "Doctor",
              project["Doctor"] ?? "",
            ),
            _infoCard(
              "Teacher Assistant",
              project["TA"] ?? "",
            ),
            _infoCard(
              "Specialization",
              project["Specialization"] ?? "",
            ),
            _infoCard(
              "Tools",
              project["Tools"] ?? "",
            ),
            _bigCard(
              "Description",
              project["description"] ?? project["Description"] ?? "",
            ),
            _bigCard(
              "Future Work",
              project["Future Work"] ?? project["FutureWork"] ?? "",
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoCard(
  String title,
  String value,
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(
      bottom: 12,
    ),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _bigCard(
  String title,
  String value,
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(
      bottom: 12,
    ),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1D2E),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}
