import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectAssignedView extends StatelessWidget {
  final String projectId;

  const ProjectAssignedView({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),

            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: _statusHeader(),
            ),

            const SizedBox(height: 50),

            ZoomIn(
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
              child: const Icon(
                Icons.celebration_rounded,
                size: 90,
                color: Color(0xff4FC3F7),
              ),
            ),

            const SizedBox(height: 20),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: const Text(
                "Success",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),


            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: const Text(
                "The project has been assigned ID",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            BounceIn(
              delay: const Duration(milliseconds: 400),
              child: Text(
                projectId,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/studentDashboard');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6EC6D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Return to Home",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Project Status",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Chip(
          label: Text("Accepted"),
          backgroundColor: Colors.green,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
