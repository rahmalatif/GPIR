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

class _ProjectAssignedMobileViewState
    extends State<ProjectAssignedMobileView> {

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

    final data =
    await DashboardService.getDashboard();

    final project =
    data['project'];

    if (project != null) {

      setState(() {

        projectId =
            project['_id'] ?? "";

        doctorStatus =

            (project['doctor_status']
                ?? "pending")

                .toString()

                .toLowerCase()

                .trim();

        taStatus =

            (project['ta_status']
                ?? "pending")

                .toString()

                .toLowerCase()

                .trim();

        finalStatus =

            (project['status']
                ?? "pending")

                .toString()

                .toLowerCase()

                .trim();
      });
    }
  }

  String overallStatus() {

    if (

    doctorStatus == "rejected" ||

        taStatus == "rejected" ||

        finalStatus == "rejected") {

      return "rejected";
    }

    if (finalStatus == "approved") {

      return "accepted";
    }

    return "pending";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFF0D0F1A),

      body: SafeArea(

        child: Padding(

          padding:
          const EdgeInsets.all(22),

          child: Column(

            children: [

              FadeInDown(

                duration: const Duration(
                  milliseconds: 500,
                ),

                child: _statusHeader(),
              ),

              const SizedBox(
                height: 40,
              ),

              ZoomIn(

                duration: const Duration(
                  milliseconds: 700,
                ),

                curve:
                Curves.elasticOut,

                child: Container(

                  width: 120,

                  height: 120,

                  decoration: BoxDecoration(

                    shape: BoxShape.circle,

                    color:
                    getStatusColor()
                        .withOpacity(
                      0.15,
                    ),
                  ),

                  child: Icon(

                    getStatusIcon(),

                    size: 65,

                    color:
                    getStatusColor(),
                  ),
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

                  textAlign:
                  TextAlign.center,

                  style: const TextStyle(

                    color: Colors.white,

                    fontSize: 28,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              FadeInUp(

                delay: const Duration(
                  milliseconds: 200,
                ),

                child: Text(

                  getStatusMessage(),

                  textAlign:
                  TextAlign.center,

                  style: const TextStyle(

                    color: Colors.grey,

                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(
                height: 35,
              ),

              Expanded(

                child: SingleChildScrollView(

                  child: Column(

                    children: [

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

                      if (

                      doctorStatus ==
                          "approved" &&

                          taStatus ==
                              "approved")

                        _statusStep(
                          "Admin Approval",
                          finalStatus,
                        ),

                      const SizedBox(
                        height: 30,
                      ),

                      if (overallStatus() ==
                          "accepted")

                        BounceIn(

                          delay: const Duration(
                            milliseconds: 400,
                          ),

                          child: Container(

                            padding:
                            const EdgeInsets.symmetric(

                              horizontal: 20,

                              vertical: 14,
                            ),

                            decoration: BoxDecoration(

                              color:
                              const Color(
                                0xFF1A1D2E,
                              ),

                              borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                            ),

                            child: Column(

                              children: [

                                const Text(

                                  "Project ID",

                                  style: TextStyle(

                                    color: Colors.grey,

                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(
                                  height: 6,
                                ),

                                Text(

                                  projectId,

                                  style: const TextStyle(

                                    color: Colors.white,

                                    fontSize: 18,

                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              FadeInUp(

                delay: const Duration(
                  milliseconds: 600,
                ),

                child: SizedBox(

                  width: double.infinity,

                  height: 52,

                  child: ElevatedButton(

                    onPressed: () {

                      context.go(
                        '/studentDashboard',
                      );
                    },

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      const Color(
                        0xff6EC6D9,
                      ),

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),

                    child: const Text(

                      "Return to Home",

                      style: TextStyle(

                        color: Colors.black,

                        fontSize: 16,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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

        icon =
            Icons.hourglass_top_rounded;

        text = "Pending";
    }

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: const Color(0xFF1A1D2E),

        borderRadius:
        BorderRadius.circular(16),
      ),

      child: Row(

        children: [

          Container(

            width: 42,

            height: 42,

            decoration: BoxDecoration(

              shape: BoxShape.circle,

              color:
              color.withOpacity(
                0.15,
              ),
            ),

            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Text(

              title,

              style: const TextStyle(

                color: Colors.white,

                fontSize: 15,

                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),

          Text(

            text,

            style: TextStyle(

              color: color,

              fontWeight:
              FontWeight.bold,
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

        return "Project Under Review";

      case 'rejected':

        return "Project Rejected";

      default:

        return "Unknown";
    }
  }

  String getStatusMessage() {

    switch (overallStatus()) {

      case 'accepted':

        return
          "Your graduation project has been approved successfully";

      case 'pending':

        return
          "Your project is currently under review";

      case 'rejected':

        return
          "Unfortunately your project was rejected";

      default:

        return
          "Status not available";
    }
  }

  Widget _statusHeader() {

    return Row(

      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: [

        const Text(

          "Project Status",

          style: TextStyle(

            color: Colors.white,

            fontSize: 20,

            fontWeight:
            FontWeight.bold,
          ),
        ),

        Chip(

          label: Text(
            overallStatus().toUpperCase(),
          ),

          backgroundColor:
          getStatusColor(),

          labelStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}