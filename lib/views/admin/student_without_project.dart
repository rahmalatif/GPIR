import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/whatsapp_services.dart';
import '../../services/without_project.dart';
import '../../services/auth_service.dart';
import '../model/student.dart';
import '../model/team_without_project.dart';

class StudentsWithoutProjectsView extends StatefulWidget {
  const StudentsWithoutProjectsView({super.key});

  @override
  State<StudentsWithoutProjectsView> createState() =>
      _StudentsWithoutProjectsViewState();
}

class _StudentsWithoutProjectsViewState
    extends State<StudentsWithoutProjectsView> {
  late Future<List<TeamWithoutProjectModel>> teamsFuture;

  @override
  void initState() {
    super.initState();
    teamsFuture = WithoutProjectService().getTeamsWithoutProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Students Without Projects",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<TeamWithoutProjectModel>>(
        future: teamsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final teams = snapshot.data ?? [];

          if (teams.isEmpty) {
            return const Center(
              child: Text(
                "All teams have projects 🎉",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];

              return Card(
                color: Color(0xff4699A8),
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        team.teamName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Leader: ${team.leader.name}",
                      ),
                      Text(
                        "Members: ${team.members.length}",
                      ),
                      const Divider(),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await WhatsAppService.openWhatsApp(
                            phone: team.leader.phone,
                            message:
                                'Hello ${team.leader.name}, please register your graduation project as soon as possible.\nModern Academy,computer science department',
                          );
                        },
                        icon: const Icon(Icons.message),
                        label: const Text('Notify Leader'),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Team Members",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...team.members.map(
                        (member) => Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text("• ${member.name}"),
                        ),
                      ),
                    ],
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
