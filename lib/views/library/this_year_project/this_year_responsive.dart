import 'package:flutter/cupertino.dart';
import 'package:graduation_project_recommender/views/library/this_year_project/this_year_project.dart';
import 'package:graduation_project_recommender/views/library/this_year_project/this_year_project_web.dart';

import '../../../core/design/responsive_layout.dart';

class CurrentYearProjectsResponsive extends StatelessWidget {
  const CurrentYearProjectsResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const CurrentYearProjectsView(),
      web: const CurrentYearProjectsWebView(),
    );
  }
}
