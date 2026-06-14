import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';

import '../../doctor/add_idea/add_idea_mobile.dart';
import 'add_new_project.dart';

class LibaddProjectResponsive extends StatelessWidget {
  const LibaddProjectResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: LibAddNewProjectView(),
        web: LibAddNewProjectView());
  }
}
