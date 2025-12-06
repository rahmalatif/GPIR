import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/login.dart';
import 'package:graduation_project_recommender/views/role_selection.dart';
import 'package:graduation_project_recommender/views/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => const SplashView(),
        '/role_selection':(context)=>RoleSelectionView(),
        '/login' :(context)=>LoginView(),

      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}
