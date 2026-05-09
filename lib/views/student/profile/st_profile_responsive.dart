import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/student/profile/st_profile_mobile.dart';
import 'package:graduation_project_recommender/views/student/profile/st_profile_web.dart';
import '../../../core/design/responsive_layout.dart';
import '../../model/student.dart';

class StudentProfileResponsive extends StatelessWidget {
  final Student student;

  const StudentProfileResponsive({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: StudentProfileMobileView(
      ),
      web: StudentProfileWebView(
        student: student,
      ),
    );
  }
}
