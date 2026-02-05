import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/doctor/dashboard.dart';

import 'package:graduation_project_recommender/views/splash.dart';
import 'package:graduation_project_recommender/views/login.dart';
import 'package:graduation_project_recommender/views/role_selection.dart';

import 'package:graduation_project_recommender/views/student/dashboard.dart';
import 'package:graduation_project_recommender/views/student/chats.dart';
import 'package:graduation_project_recommender/views/student/student_chat.dart';
import 'package:graduation_project_recommender/views/student/ai_recommend.dart';
import 'package:graduation_project_recommender/views/student/have_idea.dart';
import 'package:graduation_project_recommender/views/student/similarity_check.dart';
import 'package:graduation_project_recommender/views/student/choose_supervisor.dart';
import 'package:graduation_project_recommender/views/student/send_idea_to_dr.dart';
import 'package:graduation_project_recommender/views/student/confirm_submission.dart';

import 'package:graduation_project_recommender/views/model/project.dart';
import 'package:graduation_project_recommender/views/model/doctor.dart';

import '../design/dr_nav_bar.dart';
import '../design/nav_Bar.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [

    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashView(),
    ),

    GoRoute(
      path: '/roleSelection',
      builder: (context, state) => const RoleSelectionView(),
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) {
        final role = state.extra as String? ?? 'student';
        return LoginView(role: role);
      },
    ),

    // doctor
    ShellRoute(
      builder: (context, state, child) {

        return DoctorNavBar(child: child);
      },
      routes: [

        GoRoute(
          path: '/doctorDashboard',
          builder: (context, state) => const DashboardView(),
        ),


      ],
    ),

    // student

    ShellRoute(
      builder: (context, state, child) {
        return StudentNavBar(child: child);
      },
      routes: [

        GoRoute(
          path: '/studentDashboard',
          builder: (context, state) => const StudentDashboardView(),
        ),

        GoRoute(
          path: '/studentChat',
          builder: (context, state) => const StudentChatView(),
        ),


      ],
    ),
  ],
);


