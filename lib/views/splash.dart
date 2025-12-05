import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(131321),
      body: Center(
        child: ElasticInDown(
          child: AppImage(image: "assets/png/logo.png"),
        ),
      ),
    );
  }
}
