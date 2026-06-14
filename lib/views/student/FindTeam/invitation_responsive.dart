import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';
import 'package:graduation_project_recommender/views/student/FindTeam/inviations.dart';
import 'package:graduation_project_recommender/views/student/FindTeam/invitation_web.dart';

class InvitationResponsive extends StatelessWidget {
  const InvitationResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: TeamInvitationsView(),
        web: TeamInvitationsWebView());
  }
}
