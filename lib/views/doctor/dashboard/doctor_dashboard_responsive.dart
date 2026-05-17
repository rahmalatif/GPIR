import 'package:flutter/material.dart';

import '../../../core/design/responsive_layout.dart';
import '../../model/user_model.dart';

import 'doctor_dashboard_mobile.dart';
import 'doctor_dashboard_web.dart';

class DashboardResponsive extends StatelessWidget {


  const DashboardResponsive({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: DashboardMobileView(),
      web: DashboardWebView(

      ),
    );
  }
}
