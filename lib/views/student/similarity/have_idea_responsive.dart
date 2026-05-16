import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import 'have_idea_mobile.dart';
import 'have_idea_web.dart';

class HaveIdeaResponsive extends StatelessWidget {
  final dynamic recommendedIdea;

  const HaveIdeaResponsive({
    super.key,
    this.recommendedIdea,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: HaveIdeaMobileView(
        recommendedIdea: recommendedIdea,
      ),
      web: HaveIdeaWebView(
        recommendedIdea: recommendedIdea,
      ),
    );
  }
}
