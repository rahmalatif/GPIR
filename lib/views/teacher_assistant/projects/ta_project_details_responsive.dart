import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/teacher_assistant/projects/ta_project_details_mobile.dart';
import 'package:graduation_project_recommender/views/teacher_assistant/projects/ta_project_details_web.dart';

import '../../../core/design/responsive_layout.dart';

class TaProjectDetailsResponsive extends StatelessWidget {
  final String projectId;

  const TaProjectDetailsResponsive({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: TAProjectDetailsMobileView(
        projectId: projectId,
      ),
      web: TAProjectDetailsWebView(
        projectId: projectId,
      ),
    );
  }
}
