import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';

import 'projects_recommendation_mobile.dart';
import 'projects_recommendation_web.dart';

class ProjectsRecommendationResponsive
    extends StatelessWidget {

  final List<dynamic> ideas;

  const ProjectsRecommendationResponsive({

    super.key,

    required this.ideas,
  });

  @override
  Widget build(BuildContext context) {

    return ResponsiveLayout(

      mobile:
      ProjectsRecommendationMobileView(

        ideas: ideas,
      ),

      web:
      ProjectsRecommendationWebView(

        ideas: ideas,
      ),
    );
  }
}