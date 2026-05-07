import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import 'project_assigned_mobile.dart';
import 'project_assigned_web.dart';

class ProjectAssignedResponsive extends StatelessWidget {
  final String projectId;
  final String status;

  const ProjectAssignedResponsive({
    super.key,
    required this.projectId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ProjectAssignedMobileView(
        projectId: projectId,
        status: status,
      ),
      web: ProjectAssignedWebView(
        projectId: projectId,
        status: status,
      ),
    );
  }
}
