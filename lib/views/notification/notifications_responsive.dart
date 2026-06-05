import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/notification/mobile_notifications.dart';

import '../../../core/design/responsive_layout.dart';
import 'notifications_web.dart';

class StudentNotificationsResponsive extends StatelessWidget {
  const StudentNotificationsResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: NotificationsMobileView(),
      web: NotificationsWebView(),
    );
  }
}
