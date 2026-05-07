import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../model/student.dart';

class StudentProfileMobileView
    extends StatelessWidget {
  final Student student;

  const StudentProfileMobileView({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Padding(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 40),

            Center(
              child: CircleAvatar(
                radius: 50,

                backgroundColor:
                Colors.grey.shade300,

                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text(
                student.name,

                style:
                const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            _infoItem(
              "ID",
              "stu",
            ),

            const SizedBox(height: 30),

            Center(
              child: IconButton(
                onPressed: () async {
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
      ),
    );
  }

  Widget _infoItem(
      String label,
      String value,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Text(
          label,

          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight:
            FontWeight.w500,
          ),
        ),
      ],
    );
  }
}