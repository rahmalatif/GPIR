import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';

import 'library_project_details.dart';
import 'library_project_details_web.dart';

class LibraryProjectDetailsResponsive
    extends StatelessWidget {

  final Map<String, dynamic> project;

  const LibraryProjectDetailsResponsive({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(

      mobile:
      LibraryProjectDetailsView(
        project: project,
      ),

      web:
      LibraryProjectDetailsWebView(
        project: project,
      ),
    );
  }
}