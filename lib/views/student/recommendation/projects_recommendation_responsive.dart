import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/student/recommendation/projects_recommendation_mobile.dart';
import '../../../core/design/responsive_layout.dart';
import '../../model/project_idea.dart';
import 'projects_recommendation_web.dart';

class ProjectsRecommendationResponsive
    extends StatelessWidget {
  final List<String> tracks;
  final ProjectIdea projectIdea;

  const ProjectsRecommendationResponsive({
    super.key,
    required this.tracks,
    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile:
      ProjectsRecommendationMobileView(
        tracks: tracks,
        projectIdea: projectIdea,
      ),

      web:
      ProjectsRecommendationWebView(
        tracks: tracks,
        projectIdea: projectIdea,
      ),
    );
  }
}