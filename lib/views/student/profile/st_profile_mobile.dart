import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/profile_service.dart';

class StudentProfileMobileView extends StatefulWidget {
  const StudentProfileMobileView({
    super.key,
  });

  @override
  State<StudentProfileMobileView> createState() =>
      _StudentProfileMobileViewState();
}

class _StudentProfileMobileViewState extends State<StudentProfileMobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            context.go('/studentDashboard');
          },
        ),
      ),
      backgroundColor: const Color(0xFF0D0F1A),
      body: FutureBuilder(
        future: StudentProfileService.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No profile data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final data = snapshot.data!;

          final student = data['student'] ?? {};

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    student['name'] ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _infoItem(
                  "College Code",
                  student['collegeCode']?.toString() ?? "",
                ),
                const SizedBox(
                  height: 20,
                ),
                _infoItem(
                  "Specialization",
                  student['specialization'] ?? "",
                ),
                const SizedBox(
                  height: 20,
                ),
                _infoItem(
                  "Leader",
                  student['isLeader'] == true ? "Yes" : "No",
                ),
                const Spacer(),
                Center(
                  child: IconButton(
                    onPressed: () {
                      context.go(
                        '/roleSelection',
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoItem(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
