import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/library_current_project.dart';
import '../../../services/send_documentayion_reminder.dart';
import '../../../services/submit_documentation_services.dart';

class CurrentYearProjectsWebView extends StatefulWidget {
  const CurrentYearProjectsWebView({
    super.key,
  });

  @override
  State<CurrentYearProjectsWebView> createState() =>
      _CurrentYearProjectsWebViewState();
}

class _CurrentYearProjectsWebViewState
    extends State<CurrentYearProjectsWebView> {
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
        ),
        body: Center(
          child: SizedBox(
            width: 1100,
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

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];

                      return Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1D2E),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project["title"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                try {
                                  await DocumentationReminderService
                                      .sendReminder(
                                    project["_id"],
                                  );

                                  if (!mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        "Documentation reminder sent successfully",
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  if (!mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(e.toString()),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.notifications),
                              label: const Text("Send Reminder"),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        ));
  }
}
