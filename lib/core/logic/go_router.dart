import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/doctor/dashboard.dart';
import 'package:graduation_project_recommender/views/doctor/pending_ideas.dart';

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

    //student
    GoRoute(
      path: '/studentChat',
      builder: (context, state) => const StudentChatView(),
    ),

    GoRoute(
      path: '/aiRecommend',
      builder: (context, state) => const AiRecommendView(),
    ),

    GoRoute(
      path: '/haveIdea',
      builder: (context, state) => const HaveIdeaView(),
    ),

    GoRoute(
      path: '/similarityCheck',
      builder: (context, state) {
        final projectIdea = state.extra as ProjectIdea;
        return SimilarityCheckView(projectIdea: projectIdea);
      },
    ),

    GoRoute(
      path: '/chooseSupervisor',
      builder: (context, state) {
        final projectIdea = state.extra as ProjectIdea;
        return ChooseSupervisorView(projectIdea: projectIdea);
      },
    ),

    GoRoute(
      path: '/sendIdeaToDr',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return SendIdeaToDrView(
          projectIdea: data['projectIdea'] as ProjectIdea,
          doctor: data['doctor'] as Doctor,
        );
      },
    ),

    GoRoute(
      path: '/confirmSubmission',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ConfirmSubmissionView(
          projectIdea: data['projectIdea'] as ProjectIdea,
          doctor: data['doctor'] as Doctor,
          teamMembers: const [],
        );
      },
    ),






    //doctor

    GoRoute(
      path: '/drPendingIdeas',
      builder: (context, state) => PendingIdeasView(),
    ),




    //Doctor
    ShellRoute(
      builder: (context, state, child) => DoctorNavBar(child: child),
      routes: [

        GoRoute(
          path: '/doctorDashboard',
          builder: (context, state) => const DashboardView(),
        ),

        GoRoute(
          path: '/doctorProjects',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text("Doctor Projects")),
          ),
        ),

        GoRoute(
          path: '/doctorChat',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text("Doctor Chat")),
          ),
        ),

        GoRoute(
          path: '/doctorProfile',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text("Doctor Profile")),
          ),
        ),
      ],
    ),

// Student
    ShellRoute(
      builder: (context, state, child) => StudentNavBar(child: child),
      routes: [

        GoRoute(
          path: '/studentDashboard',
          builder: (context, state) => const StudentDashboardView(),
        ),

        GoRoute(
          path: '/studentChat',
          builder: (context, state) => const StudentChatView(),
        ),

        GoRoute(
          path: '/studentProfile',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text("Student Profile")),
          ),
        ),
      ],
    ),

  ],
);


