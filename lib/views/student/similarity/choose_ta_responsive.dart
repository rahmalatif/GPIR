import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import '../../model/project.dart';
import 'choose_ta_mobile.dart';
import 'choose_ta_web.dart';

class ChooseTAResponsive
    extends StatelessWidget {
  final ProjectIdea projectIdea;

  const ChooseTAResponsive({
    super.key,
    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ChooseTAMobileView(
        projectIdea: projectIdea,
      ),

      web: ChooseTAWebView(
        projectIdea: projectIdea,
      ),
    );
  }
}