import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';

import '../../model/project_idea.dart';

import 'confirm_submission_mobile.dart';
import 'confirm_submission_web.dart';

class ConfirmSubmissionResponsive extends StatelessWidget {
  final dynamic doctor;
  final dynamic ta;
  final ProjectIdea projectIdea;
  final List teamMembers;

  const ConfirmSubmissionResponsive({
    super.key,
    required this.doctor,
    required this.ta,
    required this.projectIdea,
    required this.teamMembers,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ConfirmSubmissionMobileView(
        doctor: doctor,
        ta: ta,
        projectIdea: projectIdea,
      ),
      web: ConfirmSubmissionWebView(
        doctor: doctor,
        projectIdea: projectIdea,
        ta: ta,
      ),
    );
  }
}
