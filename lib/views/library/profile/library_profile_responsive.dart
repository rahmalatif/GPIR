import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/responsive_layout.dart';
import 'package:graduation_project_recommender/views/library/profile/library_profile.dart';
import '../../model/library.dart';
import 'library_profile_web.dart';

class LibraryProfileResponsive extends StatelessWidget {

  const LibraryProfileResponsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: LibraryProfileView(),
      web: LibraryProfileWebView(),
    );
  }
}