import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';
import 'package:graduation_project_recommender/views/student/FindTeam/join_student_mobile.dart';
import 'package:graduation_project_recommender/views/student/FindTeam/join_student_web.dart';

class JoinStudentResponsive extends StatelessWidget {
  const JoinStudentResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: JoinStudentView(), web: JoinStudentWebView());
  }
}
