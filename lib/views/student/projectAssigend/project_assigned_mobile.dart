import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/student_dashboard_service.dart';

class ProjectAssignedMobileView extends StatefulWidget {
  const ProjectAssignedMobileView({
    super.key,
  });

  @override
  State<ProjectAssignedMobileView> createState() =>
      _ProjectAssignedMobileViewState();
}

class _ProjectAssignedMobileViewState extends State<ProjectAssignedMobileView> {
  String projectId = "";

  String status = "pending";

  String normalizedStatus = "pending";

  @override
  void initState() {
    super.initState();

    loadProjectStatus();
  }

  Future<void> loadProjectStatus() async {
    final data = await DashboardService.getDashboard();

    final project = data['project'];

    if (project != null) {
      setState(() {
        projectId = project['_id'] ?? "";

        status = project['status'] ?? "pending";

        normalizedStatus = status.toLowerCase().trim();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            FadeInDown(
              duration: const Duration(
                milliseconds: 500,
              ),
              child: _statusHeader(),
            ),
            const SizedBox(
              height: 50,
            ),
            ZoomIn(
              duration: const Duration(
                milliseconds: 700,
              ),
              curve: Curves.elasticOut,
              child: Icon(
                getStatusIcon(),
                size: 90,
                color: getStatusColor(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FadeInUp(
              duration: const Duration(
                milliseconds: 600,
              ),
              child: Text(
                getStatusTitle(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            FadeInUp(
              delay: const Duration(
                milliseconds: 200,
              ),
              child: Text(
                getStatusMessage(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (normalizedStatus == 'accepted')
              BounceIn(
                delay: const Duration(
                  milliseconds: 400,
                ),
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
              delay: const Duration(
                milliseconds: 600,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(
                      '/studentDashboard',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6EC6D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Return to Home",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getStatusIcon() {
    switch (normalizedStatus) {
      case 'accepted':
        return Icons.celebration_rounded;

      case 'pending':
        return Icons.hourglass_top_rounded;

      case 'rejected':
        return Icons.cancel_rounded;

      default:
        return Icons.help_outline;
    }
  }

  Color getStatusColor() {
    switch (normalizedStatus) {
      case 'accepted':
        return Colors.green;

      case 'pending':
        return Colors.orange;

      case 'rejected':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  String getStatusTitle() {
    switch (normalizedStatus) {
      case 'accepted':
        return "Success";

      case 'pending':
        return "Waiting";

      case 'rejected':
        return "Rejected";

      default:
        return "Unknown";
    }
  }

  String getStatusMessage() {
    switch (normalizedStatus) {
      case 'accepted':
        return "Your project has been accepted";

      case 'pending':
        return "Your project is under review";

      case 'rejected':
        return "Your project was rejected";

      default:
        return "Status not available";
    }
  }

  Widget _statusHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Project Status",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Chip(
          label: Text(
            normalizedStatus.toUpperCase(),
          ),
          backgroundColor: getStatusColor(),
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
