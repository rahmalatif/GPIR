import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/library_all_projects.dart';
import '../../model/library_data.dart';

class AllProjectsView extends StatefulWidget {
  const AllProjectsView({super.key});

  @override
  State<AllProjectsView> createState() => _AllProjectsViewState();
}

class _AllProjectsViewState extends State<AllProjectsView> {
  late Future<List<dynamic>> projectsFuture;

  String searchText = "";

  @override
  void initState() {
    super.initState();

    projectsFuture = LibraryAllProjectsService.getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
          backgroundColor: const Color(0xFF0D0F1A),
          title: const Text(
            "All Projects",
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Search Project",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: const Color(0xFF1A1D2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: projectsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Failed to load projects",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  final projects = snapshot.data ?? [];

                  final filteredProjects = projects.where((project) {
                    final title =
                        (project["title"] ?? "").toString().toLowerCase();

                    final code = (project["project_code"] ?? "")
                        .toString()
                        .toLowerCase();

                    final year =
                        (project["Year"] ?? "").toString().toLowerCase();

                    final query = searchText.toLowerCase();

                    return title.contains(query) ||
                        code.contains(query) ||
                        year.contains(query);
                  }).toList();
                  return ListView.builder(
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      final project = filteredProjects[index];

                      return GestureDetector(
                          onTap: () {
                            context.push(
                              '/libraryProjectDetails',
                              extra: project,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1D2E),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project["title"] ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Code: ${project["project_code"]}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Year: ${project["Year"]}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
