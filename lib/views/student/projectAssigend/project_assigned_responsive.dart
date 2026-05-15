import 'package:flutter/cupertino.dart';
import 'package:graduation_project_recommender/views/student/projectAssigend/project_assigned_mobile.dart';
import 'package:graduation_project_recommender/views/student/projectAssigend/project_assigned_web.dart';

import '../../../core/design/responsive_layout.dart';

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
      mobile: ProjectAssignedMobileView(),
      web: ProjectAssignedWebView(),
    );
  }
}
