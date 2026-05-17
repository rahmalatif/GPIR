import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/doctor/add_idea/doctor_ideas_mobile.dart';
import 'package:graduation_project_recommender/views/doctor/add_idea/doctor_ideas_web.dart';

import '../../../core/design/responsive_layout.dart';


class DoctorIdeasResponsive
    extends StatelessWidget {

  const DoctorIdeasResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return const ResponsiveLayout(

      mobile:
      DoctorMyIdeasMobileView(),

      web:
      DoctorMyIdeasWebView(),
    );
  }
}