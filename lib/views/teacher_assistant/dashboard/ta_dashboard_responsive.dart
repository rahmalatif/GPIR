import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import '../../model/user_model.dart';

import 'ta_dashboard_mobile.dart';
import 'ta_dashboard_web.dart';

class TADashboardResponsive extends StatelessWidget {
  final UserModel user;

  const TADashboardResponsive({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const TADashboardMobileView(),
      web: TADashboardWebView(
        user: user,
      ),
    );
  }
}
