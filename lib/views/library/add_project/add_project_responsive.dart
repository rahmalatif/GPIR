import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';

import '../../doctor/add_idea/add_idea_mobile.dart';
import 'add_new_project.dart';

class addProjectResponsive extends StatelessWidget {
  const addProjectResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: AddIdeaMobileView(),
        web: AddNewProjectView());
  }
}
