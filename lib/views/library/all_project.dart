import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/library_data.dart';

class AllProjectsView extends StatelessWidget {
  const AllProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0F1A),
          title: const Text("All Projects"),
        ),
        body: ListView.builder(
          itemCount: LibraryData.projects.length,
          itemBuilder: (context, index) {
            final project = LibraryData.projects[index];

            return GestureDetector(
              onTap: () {
                context.push(
                  '/libraryProjectDetails',
                  extra: project,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.name,
                        style: const TextStyle(color: Colors.white)),
                    Text("ID: ${project.id}",
                        style: const TextStyle(color: Colors.grey)),
                    Text("Year: ${project.year}",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
