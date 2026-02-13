import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectAssignedView extends StatelessWidget {
  final String projectId;
  final String status;

  const ProjectAssignedView({
    super.key,
    required this.projectId,
    required this.status,
  });

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
              child: Icon(
                getStatusIcon(),
                size: 90,
                color: getStatusColor(),
              ),
            ),

            const SizedBox(height: 20),

            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Text(
                getStatusTitle(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Text(
                getStatusMessage(),
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            if (status == 'accepted')
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


  IconData getStatusIcon() {
    switch (status) {
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
    switch (status) {
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
    switch (status) {
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
    switch (status) {
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

  Future<String> getStatusMessages() async {
    if (status == 'accepted') return "The project has been assigned ID";
    if (status == 'pending') return "Your project is under review";
    return "Your project was not accepted";
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
          label: Text(status.toUpperCase()),
          backgroundColor: getStatusColor(),
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
