import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/library_current_project.dart';
import '../../../services/submit_documentation_services.dart';

class CurrentYearProjectsView extends StatefulWidget {
  const CurrentYearProjectsView({
    super.key,
  });

  @override
  State<CurrentYearProjectsView> createState() =>
      _CurrentYearProjectsViewState();
}

class _CurrentYearProjectsViewState extends State<CurrentYearProjectsView> {
  late Future<List<dynamic>> projectsFuture;

  @override
  void initState() {
    super.initState();

    projectsFuture = LibraryCurrentProjectsService.getCurrentProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0F1A),
          title: const Text(
            "This Year Projects",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
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

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1D2E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project["title"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Code: ${project["project_code"]}",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "Doctor: ${project["doctor"]}",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CheckboxListTile(
                          value: project["documentation"] != null,
                          onChanged: (value) async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xFF1A1D2E),
                                  title: const Text(
                                    "Confirm",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: Text(
                                    value == true
                                        ? "Are you sure the documentation has been submitted?"
                                        : "Are you sure you want to mark documentation as not submitted?",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          false,
                                        );
                                      },
                                      child: const Text(
                                        "Cancel",
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.cyan,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          true,
                                        );
                                      },
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (result == true && value == true) {
                              try {
                                await LibrarySubmitDocumentationService
                                    .submitDocumentation(
                                  project["_id"],
                                );
                                final updatedProjects =
                                    await LibraryCurrentProjectsService
                                        .getCurrentProjects();

                                if (!mounted) return;

                                if (updatedProjects.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "All projects have been submitted",
                                      ),
                                    ),
                                  );

                                  context.go(
                                    '/libraryDashboard',
                                  );
                                  return;
                                }
                                setState(() {
                                  projectsFuture = Future.value(
                                    updatedProjects,
                                  );
                                });

                                if (!mounted) return;

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Documentation submitted successfully",
                                    ),
                                  ),
                                );
                              } catch (e) {
                                if (!mounted) return;

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      e.toString(),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          activeColor: Colors.cyan,
                          title: const Text(
                            "Documentation Submitted",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ],
                    ),
                  );
                },
              );
            }));
  }
}
