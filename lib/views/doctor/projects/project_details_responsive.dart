import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import '../../model/DR_project.dart';
import 'project_details_mobile.dart';
import 'project_details_web.dart';

class ProjectDetailsResponsive
    extends StatelessWidget {
  final String? projectId;
  final ProjectDR? project;

  const ProjectDetailsResponsive({
    super.key,
    this.projectId,
    this.project,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile:
      ProjectDetailsMobileView(
        projectId: projectId,
        project: project,
      ),

      web:
      ProjectDetailsWebView(
        projectId: projectId,
        project: project,
      ),
    );
  }
}