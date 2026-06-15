import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    final role = prefs.getString('role');
    await AuthService.loadUserData();
    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      switch (role) {
        case 'student':
          context.go('/studentDashboard');
          break;

        case 'doctor':
          context.go('/doctorDashboard');
          break;

        case 'ta':
          context.go('/taDashboard');
          break;

        case 'library':
          context.go('/libraryDashboard');
          break;

        case 'admin':
          context.go('/adminDashboard');
          break;

        default:
          context.go('/roleSelection');
      }
    } else {
      context.go('/roleSelection');
    }
  }

  void _navigateOnTap() {
    context.go('/roleSelection');
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
