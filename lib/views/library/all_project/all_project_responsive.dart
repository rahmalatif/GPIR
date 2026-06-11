import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';

import 'all_project.dart';
import 'all_projects_web.dart';

class AllProjectResponsive extends StatelessWidget {
  const AllProjectResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: AllProjectsView(), web: AllProjectsWebView());
  }
}
