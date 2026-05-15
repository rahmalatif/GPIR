import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';

import '../../model/project_idea.dart';

import 'choose_ta_mobile.dart';
import 'choose_ta_web.dart';

class ChooseTAResponsive extends StatelessWidget {
  final ProjectIdea projectIdea;
  final dynamic doctor;
  final double? similarityScore;

  const ChooseTAResponsive({
    super.key,
    required this.projectIdea,
    required this.doctor,
    required this.similarityScore,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ChooseTAMobileView(
        projectIdea: projectIdea,
        doctor: doctor,
        similarityScore: similarityScore,
      ),
      web: ChooseTAWebView(
        projectIdea: projectIdea,
        doctor: doctor,
        similarityScore: similarityScore,
      ),
    );
  }
}
