import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/teacher_assistant/projects/ta_project_mobile.dart';
import 'package:graduation_project_recommender/views/teacher_assistant/projects/ta_project_web.dart';

import '../../../core/design/responsive_layout.dart';

class TAProjectsResponsive extends StatelessWidget {
  const TAProjectsResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: TAProjectsMobileView(),
      web: TAProjectsWebView(),
    );
  }
}
