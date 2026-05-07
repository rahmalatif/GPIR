import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import '../../model/doctor.dart';
import '../../model/project.dart';
import 'send_idea_to_dr_mobile.dart';
import 'send_idea_to_dr_web.dart';

class SendIdeaToDrResponsive
    extends StatelessWidget {
  final Doctor doctor;
  final ProjectIdea projectIdea;

  const SendIdeaToDrResponsive({
    super.key,
    required this.doctor,
    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile:
      SendIdeaToDrMobileView(
        doctor: doctor,
        projectIdea: projectIdea,
      ),

      web: SendIdeaToDrWebView(
        doctor: doctor,
        projectIdea: projectIdea,
      ),
    );
  }
}