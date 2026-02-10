import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/library_project.dart';

class LibraryProjectDetails extends StatelessWidget {
  final LibraryProject project;

  const LibraryProjectDetails({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text("Project Details" , style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _item("Title:", project.name),
            _item("Project ID:", project.id),
            _item("Description:", project.description),

            const SizedBox(height: 20),

            const Text("Supervisor",
                style: TextStyle(color: Colors.cyan)),

            Text(project.doctor,
                style: const TextStyle(color: Colors.white)),

            const SizedBox(height: 14),

            const Text("Team members",
                style: TextStyle(color: Colors.cyan)),

            ...project.team.map((e) => Text(
              e,
              style: const TextStyle(color: Colors.white),
            )),

          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.cyan)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
