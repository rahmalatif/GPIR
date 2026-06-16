import 'package:flutter/material.dart';

import '../../services/manager_services.dart';
import '../model/doctor_with_projects_model.dart';

class ManageDoctorView extends StatefulWidget {
  const ManageDoctorView({super.key});

  @override
  State<ManageDoctorView> createState() => _ManageStaffViewState();
}

class _ManageStaffViewState extends State<ManageDoctorView> {
  late Future<List<DoctorWithProjectsModel>> doctorsFuture;

  @override
  void initState() {
    super.initState();

    doctorsFuture = ManagerService.getDoctorsWithProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Manage Staff",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<DoctorWithProjectsModel>>(
        future: doctorsFuture,
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

          final doctors = snapshot.data ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];

              return Card(
                color: const Color(0xFF1A1D2E),
                margin: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: ListTile(
                  title: Text(
                    doctor.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    doctor.email,
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
                      "${doctor.projectsCount} Projects",
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
