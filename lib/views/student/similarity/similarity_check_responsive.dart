import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import '../../model/project_idea.dart';
import 'similarity_check_mobile.dart';
import 'similarity_check_web.dart';

class SimilarityCheckResponsive
    extends StatelessWidget {
  final ProjectIdea projectIdea;

  const SimilarityCheckResponsive({
    super.key,
    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile:
      SimilarityCheckMobileView(
         result: {},
      ),

      web: SimilarityCheckWebView(
        projectIdea: projectIdea,
      ),
    );
  }
}