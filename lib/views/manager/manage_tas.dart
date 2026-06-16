import 'package:flutter/material.dart';

import '../../services/manager_services.dart';
import '../model/ta_with_projects_model.dart';

class ManageTasView extends StatefulWidget {
  const ManageTasView({super.key});

  @override
  State<ManageTasView> createState() => _ManageTasViewState();
}

class _ManageTasViewState extends State<ManageTasView> {
  late Future<List<TaWithProjectsModel>> tasFuture;

  @override
  void initState() {
    super.initState();

    tasFuture = ManagerService.getTasWithProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Teaching Assistants",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<TaWithProjectsModel>>(
        future: tasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final tas = snapshot.data ?? [];

          if (tas.isEmpty) {
            return const Center(
              child: Text(
                "No TAs Found",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tas.length,
            itemBuilder: (context, index) {
              final ta = tas[index];

              return Card(
                color: const Color(0xFF1A1D2E),
                margin: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.cyan,
                    child: Icon(
                      Icons.school,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    ta.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    ta.email,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${ta.projectsCount}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
