import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import 'add_idea_mobile.dart';
import 'add_idea_web.dart';

class AddIdeaResponsive extends StatelessWidget {
  const AddIdeaResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: AddIdeaMobileView(),
      web: AddIdeaWebView(),
    );
  }
}
