import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../views/student/dashboard.dart';
import '../../views/student/have_idea.dart';
import '../../views/student/similarity_check.dart';
import '../../views/student/choose_supervisor.dart';
import '../../views/student/send_idea_to_dr.dart';

import '../../views/model/project.dart';
import '../../views/model/doctor.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/studentDashboard',

  routes: [

    /// ================= Dashboard =================
    GoRoute(
      path: '/studentDashboard',
      builder: (context, state) => const StudentDashboardView(),
    ),

    /// ================= Have Idea =================
    GoRoute(
      path: '/haveIdea',
      builder: (context, state) => const HaveIdeaView(),
    ),

    /// ================= Similarity Check =================
    GoRoute(
      path: '/similarityCheck',
      builder: (context, state) {
        final projectIdea = state.extra as ProjectIdea;

        return SimilarityCheckView(
          projectIdea: projectIdea,
        );
      },
    ),

    /// ================= Choose Supervisor =================
    GoRoute(
      path: '/chooseSupervisor',
      builder: (context, state) {
        final projectIdea = state.extra as ProjectIdea;

        return ChooseSupervisorView(
          projectIdea: projectIdea,
        );
      },
    ),

    /// ================= Send Idea To Doctor =================
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


  ],
);
