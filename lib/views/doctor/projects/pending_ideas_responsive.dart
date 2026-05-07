import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import 'pending_ideas_mobile.dart';
import 'pending_ideas_web.dart';

class PendingIdeasResponsive
    extends StatelessWidget {
  const PendingIdeasResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile:
      PendingIdeasMobileView(),

      web:
      PendingIdeasWebView(),
    );
  }
}