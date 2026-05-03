import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';
import 'package:graduation_project_recommender/views/auth/role_selection_mobile.dart';
import 'package:graduation_project_recommender/views/auth/role_selection_web.dart';

class ResponsiveRoleSelection extends StatelessWidget {
  const ResponsiveRoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: RoleSelectionMobileView(),
        web: RoleSelectionWeb());
  }
}
