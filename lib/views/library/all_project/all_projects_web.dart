import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/library_all_projects.dart';
import '../../model/library_data.dart';

class AllProjectsWebView extends StatefulWidget {
  const AllProjectsWebView({super.key});

  @override
  State<AllProjectsWebView> createState() => _AllProjectsViewState();
}

class _AllProjectsViewState extends State<AllProjectsWebView> {
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
        elevation: 0,
        title: const Text(
          "All Projects",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWeb = constraints.maxWidth > 768;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: isWeb ? 600 : double.infinity),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search Project",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: const Color(0xFF1A1D2E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: FutureBuilder<List<dynamic>>(
                      future: projectsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Failed to load projects",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final projects = snapshot.data ?? [];
                        final filteredProjects = projects.where((project) {
                          final title = (project["title"] ?? "").toString().toLowerCase();
                          final code = (project["project_code"] ?? "").toString().toLowerCase();
                          final year = (project["Year"] ?? "").toString().toLowerCase();
                          final query = searchText.toLowerCase();

                          return title.contains(query) || code.contains(query) || year.contains(query);
                        }).toList();

                        if (filteredProjects.isEmpty) {
                          return const Center(
                            child: Text(
                              "No projects found",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          );
                        }

                        if (isWeb) {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: constraints.maxWidth > 1024 ? 3 : 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2.2,
                            ),
                            itemCount: filteredProjects.length,
                            itemBuilder: (context, index) {
                              return _buildProjectCard(filteredProjects[index]);
                            },
                          );
                        } else {
                          return ListView.builder(
                            itemCount: filteredProjects.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildProjectCard(filteredProjects[index]),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectCard(dynamic project) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/libraryProjectDetails',
          extra: project,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1D2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              project["title"] ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Code: ${project["project_code"]}",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              "Year: ${project["Year"]}",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}