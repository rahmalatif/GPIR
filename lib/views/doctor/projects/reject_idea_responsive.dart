import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import 'reject_idea_mobile.dart';
import 'reject_idea_web.dart';

class RejectIdeaResponsive
    extends StatelessWidget {
  const RejectIdeaResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile:
      RejectIdeaMobileView(),

      web:
      RejectIdeaWebView(),
    );
  }
}