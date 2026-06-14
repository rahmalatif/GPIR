import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';
import 'package:graduation_project_recommender/views/student/FindTeam/findteammobile.dart';
import 'package:graduation_project_recommender/views/student/FindTeam/findteamweb.dart';

class Findteamresponsive extends StatelessWidget {
  const Findteamresponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: FindStudentMobileView(), web: FindStudentWebView());
  }
}
