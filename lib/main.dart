import 'package:flutter/material.dart';
import 'package:graduation_project_recommender/views/login.dart';
import 'package:graduation_project_recommender/views/role_selection.dart';
import 'package:graduation_project_recommender/views/splash.dart';
import 'package:graduation_project_recommender/views/student/choose_supervisor.dart';
import 'package:graduation_project_recommender/views/student/dashboard.dart';
import 'package:graduation_project_recommender/views/student/have_idea.dart';
import 'package:graduation_project_recommender/views/student/idea_to_dr.dart';
import 'package:graduation_project_recommender/views/student/similarity_check.dart';

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
        '/studentDashboard': (context) => StudentDashboardView(),
        '/haveIdea':(context) =>HaveIdeaView(),
        '/similarityCheck' :(context)=>SimilarityCheckView(),
        '/chooseSupervisor' :(context) =>ChooseSupervisorView(),
        '/ideaToDrView' :(context)=>IdeaToDrView(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/chooseSupervisor',
    );

  }
}
