import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/student_dashboard_service.dart';

class ProjectAssignedWebView extends StatefulWidget {
  const ProjectAssignedWebView({
    super.key,
  });

  @override
  State<ProjectAssignedWebView> createState() => _ProjectAssignedWebViewState();
}

class _ProjectAssignedWebViewState extends State<ProjectAssignedWebView> {
  String projectId = "";

  String doctorStatus = "pending";

  String taStatus = "pending";

  String finalStatus = "pending";

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

        doctorStatus = (project['doctor_status'] ?? "pending")
            .toString()
            .toLowerCase()
            .trim();

        taStatus =
            (project['ta_status'] ?? "pending").toString().toLowerCase().trim();

        finalStatus =
            (project['status'] ?? "pending").toString().toLowerCase().trim();
        print(finalStatus);
      });
    }
  }

  String overallStatus() {
    if (doctorStatus == "rejected" ||
        taStatus == "rejected" ||
        finalStatus == "rejected") {
      return "rejected";
    }

    if (finalStatus == "ongoing" ) {
      return "accepted";
    }

    return "pending";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Center(
        child: SizedBox(
          width: 900,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                FadeInDown(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  child: _statusHeader(),
                ),
                const SizedBox(
                  height: 70,
                ),
                ZoomIn(
                  duration: const Duration(
                    milliseconds: 700,
                  ),
                  curve: Curves.elasticOut,
                  child: Icon(
                    getStatusIcon(),
                    size: 140,
                    color: getStatusColor(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInUp(
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                  child: Text(
                    getStatusTitle(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FadeInUp(
                  delay: const Duration(
                    milliseconds: 200,
                  ),
                  child: Text(
                    getStatusMessage(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                _statusStep(
                  "Doctor Approval",
                  doctorStatus,
                ),
                const SizedBox(
                  height: 14,
                ),
                if (doctorStatus == "approved")
                  _statusStep(
                    "TA Approval",
                    taStatus,
                  ),
                const SizedBox(
                  height: 14,
                ),
                if (doctorStatus == "approved" && taStatus == "approved")
                  _statusStep(
                    "Admin Approval",
                    finalStatus,
                  ),
                const SizedBox(
                  height: 35,
                ),
                if (overallStatus() == "accepted")
                  BounceIn(
                    delay: const Duration(
                      milliseconds: 400,
                    ),
                    child: Text(
                      projectId,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
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
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go(
                          '/studentDashboard',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xff6EC6D9,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Return to Home",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusStep(
    String title,
    String status,
  ) {
    Color color;

    IconData icon;

    String text;

    switch (status) {
      case "approved":
        color = Colors.green;

        icon = Icons.check_circle;

        text = "Approved";

        break;

      case "rejected":
        color = Colors.red;

        icon = Icons.cancel;

        text = "Rejected";

        break;

      default:
        color = Colors.orange;

        icon = Icons.hourglass_top_rounded;

        text = "Pending";
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData getStatusIcon() {
    switch (overallStatus()) {
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
    switch (overallStatus()) {
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
    switch (overallStatus()) {
      case 'accepted':
        return "Project Accepted";

      case 'pending':
        return "Waiting";

      case 'rejected':
        return "Project Rejected";

      default:
        return "Unknown";
    }
  }

  String getStatusMessage() {
    switch (overallStatus()) {
      case 'accepted':
        return "Your graduation project has been approved successfully";

      case 'pending':
        return "Your project is currently under review";

      case 'rejected':
        return "Unfortunately your project was rejected";

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
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Chip(
          label: Text(
            overallStatus().toUpperCase(),
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
