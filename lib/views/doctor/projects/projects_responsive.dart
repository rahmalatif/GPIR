import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import 'projects_mobile.dart';
import 'projects_web.dart';

class ProjectsResponsive extends StatelessWidget {
  const ProjectsResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: ProjectsMobileView(),
      web: ProjectsWebView(),
    );
  }
}
