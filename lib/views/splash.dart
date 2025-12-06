import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();

    Timer( Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/role_selection');
    });
  }

  void _navigateOnTap() {
    Navigator.pushNamed(context, '/role_selection');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateOnTap,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0F1A),
        body: Center(
          child: ElasticInDown(
            child: AppImage(image: "assets/png/logo.png"),
          ),
        ),
      ),
    );
  }
}


