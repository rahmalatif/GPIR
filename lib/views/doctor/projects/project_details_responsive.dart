import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import 'project_details_mobile.dart';
import 'project_details_web.dart';

class ProjectDetailsResponsive extends StatelessWidget {
  final String projectId;

  const ProjectDetailsResponsive({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ProjectDetailsMobileView(
        projectId: projectId,
      ),
      web: ProjectDetailsWebView(
        projectId: projectId,
      ),
    );
  }
}
