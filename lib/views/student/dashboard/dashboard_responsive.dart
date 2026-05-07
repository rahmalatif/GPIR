import 'package:flutter/material.dart';
import '../../../core/design/responsive_layout.dart';
import 'dashboardMobile.dart';
import 'dashboard_web.dart';


class StudentDashboardResponsive extends StatelessWidget {
  const StudentDashboardResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: StudentDashboardMobile(),
      web: StudentDashboardWeb(),
    );
  }
}