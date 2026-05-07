import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import 'have_idea_mobile.dart';
import 'have_idea_web.dart';

class HaveIdeaResponsive
    extends StatelessWidget {
  const HaveIdeaResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: HaveIdeaMobileView(),
      web: HaveIdeaMobileView(),
    //  web: HaveIdeaWebView(),
    );
  }
}