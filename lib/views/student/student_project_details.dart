import 'package:flutter/material.dart';
import '../model/library_project.dart';
import '../model/project.dart';

class StudentProjectDetailsView extends StatelessWidget {
  final ProjectIdea project;

  const StudentProjectDetailsView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text("Project Details",
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _statusRow(),

            const SizedBox(height: 14),

            _sectionTitle("Supervisor"),
            //_person(project.doctor),

            const SizedBox(height: 14),

            _sectionTitle("Teaching Assistant"),
         //   _person(project.TeachingAssestant),

            const SizedBox(height: 14),

            _sectionTitle("Team members"),
          //  ...project.team.map(_person),

          ],
        ),
      ),
    );
  }

  Widget _statusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text("Project Id:",
            style: TextStyle(color: Colors.grey)),
        Chip(
          label: Text("Accepted"),
          backgroundColor: Colors.green,
          labelStyle: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  Widget _descriptionCard(String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.cyan,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _person(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.cyan, size: 18),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
