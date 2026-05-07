import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import '../../model/doctor.dart';
import '../../model/project_idea.dart';
import 'confirm_submission_mobile.dart';
import 'confirm_submission_web.dart';

class ConfirmSubmissionResponsive
    extends StatelessWidget {
  final Doctor doctor;
  final ProjectIdea projectIdea;
  final List teamMembers;

  const ConfirmSubmissionResponsive({
    super.key,
    required this.doctor,
    required this.projectIdea,
    required this.teamMembers,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile:
      ConfirmSubmissionMobileView(
        doctor: doctor,
        projectIdea: projectIdea,
        teamMembers: teamMembers,
      ),

      web: ConfirmSubmissionWebView(
        doctor: doctor,
        projectIdea: projectIdea,
        teamMembers: teamMembers,
      ),
    );
  }
}