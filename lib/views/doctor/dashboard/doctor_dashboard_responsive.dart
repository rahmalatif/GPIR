import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import '../../model/user_model.dart';

import 'doctor_dashboard_mobile.dart';
import 'doctor_dashboard_web.dart';

class DashboardResponsive
    extends StatelessWidget {
  final UserModel user;

  const DashboardResponsive({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile:
      DashboardMobileView(
        user: user,
      ),

      web: DashboardWebView(
        user: user,
      ),
    );
  }
}