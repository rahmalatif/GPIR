import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/student/ai_recommend.dart';
import 'package:graduation_project_recommender/views/student/confirm_submission.dart';

import '../../views/student/dashboard.dart';
import '../../views/student/have_idea.dart';
import '../../views/student/similarity_check.dart';
import '../../views/student/choose_supervisor.dart';
import '../../views/student/send_idea_to_dr.dart';
import '../../views/model/project.dart';
import '../../views/model/doctor.dart';
import '../design/nav_Bar.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/studentDashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return NavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/studentDashboard',
          builder: (context, state) => const StudentDashboardView(),
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
      ],
    ),
    GoRoute(
        path: '/aiRecommend',
        builder: (context, state) {
          return AiRecommendView();
        }),

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
  ],
);
