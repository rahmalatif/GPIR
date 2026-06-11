import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';
import 'package:graduation_project_recommender/services/library_dashboard_service.dart';
import 'package:graduation_project_recommender/views/library/dashboard/library_dashboard.dart';
import 'package:graduation_project_recommender/views/library/dashboard/library_dashboard_web.dart';

class LibraryDashboardResponsove extends StatelessWidget {
  const LibraryDashboardResponsove({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: LibraryDashboardView(), web: LibraryDashboarWebdView());
  }
}
