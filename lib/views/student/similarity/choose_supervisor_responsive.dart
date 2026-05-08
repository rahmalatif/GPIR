import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';

import 'choose_supervisor_mobile.dart';
import 'choose_supervisor_web.dart';

class ChooseSupervisorResponsive
    extends StatelessWidget {

  final dynamic projectIdea;

  const ChooseSupervisorResponsive({

    super.key,

    required this.projectIdea,
  });

  @override
  Widget build(BuildContext context) {

    return ResponsiveLayout(

      mobile:
          
      ChooseSupervisorMobileView(

        projectIdea:
        projectIdea, doctor: null,
      ),

      web:
      ChooseSupervisorWebView(

        projectIdea:
        projectIdea,
      ),
    );
  }
}