import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/admin/admin_profile.dart';
import 'package:graduation_project_recommender/views/auth/login_responsive.dart';
import 'package:graduation_project_recommender/views/auth/register_responsive.dart';
import 'package:graduation_project_recommender/views/auth/responsive_role_selection.dart';
import 'package:graduation_project_recommender/views/auth/role_selection_mobile.dart';
import 'package:graduation_project_recommender/views/doctor/add_idea.dart';
import 'package:graduation_project_recommender/views/doctor/chat.dart';
import 'package:graduation_project_recommender/views/doctor/doctor_dashboard.dart';
import 'package:graduation_project_recommender/views/doctor/doctor_notifications.dart';
import 'package:graduation_project_recommender/views/doctor/pending_ideas.dart';
import 'package:graduation_project_recommender/views/doctor/project_details.dart';
import 'package:graduation_project_recommender/views/doctor/projects.dart';
import 'package:graduation_project_recommender/views/doctor/reject_idea.dart';
import 'package:graduation_project_recommender/views/library/add_new_project.dart';
import 'package:graduation_project_recommender/views/library/all_project.dart';
import 'package:graduation_project_recommender/views/library/library_dashboard.dart';
import 'package:graduation_project_recommender/views/library/library_profile.dart';
import 'package:graduation_project_recommender/views/library/library_project_details.dart';
import 'package:graduation_project_recommender/views/model/library.dart';
import 'package:graduation_project_recommender/views/model/student.dart';
import 'package:graduation_project_recommender/views/splash.dart';
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
import 'package:graduation_project_recommender/views/student/student_project_details.dart';

import '../../views/admin/admin_dashboard.dart';
import '../../views/admin/admin_notifications.dart';
import '../../views/admin/all_projects.dart';
import '../../views/admin/approved_projects.dart';
import '../../views/admin/idea_details.dart';
import '../../views/admin/pending_projects.dart';
import '../../views/admin/project_id.dart';
import '../../views/auth/login_mobile.dart';
import '../../views/doctor/profile.dart';
import '../../views/model/DR_project.dart';
import '../../views/model/admin_project.dart';
import '../../views/model/library_project.dart';
import '../../views/model/team.dart';
import '../../views/model/user_model.dart';
import '../../views/student/edit_team.dart';
import '../../views/student/project_assigned.dart';
import '../../views/student/recommended_projects.dart';
import '../../views/student/st_profile.dart';
import '../../views/student/student_notifications.dart';

import '../design/admin_nav_bar.dart';
import '../design/dr_nav_bar.dart';
import '../design/library_nav_bar.dart';
import '../design/nav_Bar.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',

  routes: [
    // Splash
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashView(),
    ),

    // Auth
    GoRoute(
      path: '/roleSelection',
      builder: (context, state) => const ResponsiveRoleSelection(),
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) {
        final role = state.extra as String? ?? 'student';
        return LoginResponsive(role: role);
      },
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) {
        final role = state.extra as String;
        return RegisterResponsive(role: role);
      },
    ),

    // ================= STUDENT =================

    GoRoute(
      path: '/aiRecommend',
      builder: (context, state) => AiRecommendView(),
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
          projectIdea: data['projectIdea'],
          doctor: data['doctor'],
        );
      },
    ),

    GoRoute(
      path: '/confirmSubmission',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ConfirmSubmissionView(
          projectIdea: data['projectIdea'],
          doctor: data['doctor'],
          teamMembers: const [],
        );
      },
    ),

    GoRoute(
      path: '/projectAssigned',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ProjectAssignedView(
          projectId: data["projectId"],
          status: data["status"],
        );
      },
    ),

    // ================= DOCTOR =================

    GoRoute(
      path: '/drPendingIdeas',
      builder: (context, state) => PendingIdeasView(),
    ),

    GoRoute(
      path: '/addIdea',
      builder: (context, state) => AddIdeaView(),
    ),

    GoRoute(
      path: '/doctorNotifications',
      builder: (context, state) {
        final doctorId = state.extra as String;
        return DoctorNotificationsView(doctorId: doctorId);
      },
    ),

    // ================= ADMIN =================

    GoRoute(
      path: '/adminPendingIdeas',
      builder: (context, state) => const PendingProjectsView(),
    ),

    GoRoute(
      path: '/adminApprovedProjects',
      builder: (context, state) => const AdminApprovedProjectsView(),
    ),

    // ================= LIBRARY =================

    GoRoute(
      path: '/libraryProjectDetails',
      builder: (context, state) {
        final library = state.extra as LibraryProject;
        return LibraryProjectDetails(project: library);
      },
    ),

    // ================= NAVIGATION =================

    ShellRoute(
      builder: (context, state, child) => LibraryNavBar(child: child),
      routes: [
        GoRoute(
          path: '/libraryDashboard',
          builder: (context, state) => const LibraryDashboardView(),
        ),
      ],
    ),

    ShellRoute(
      builder: (context, state, child) => AdminNavBar(child: child),
      routes: [
        GoRoute(
          path: '/AdminDashboard',
          builder: (context, state) => const AdminDashboardView(),
        ),
      ],
    ),

    ShellRoute(
      builder: (context, state, child) => DoctorNavBar(child: child),
      routes: [
        GoRoute(
          path: '/doctorDashboard',
          builder: (context, state) {
            final user = state.extra as UserModel;
            return DashboardView(user: user);
          },
        ),
      ],
    ),

    ShellRoute(
      builder: (context, state, child) => StudentNavBar(child: child),
      routes: [
        GoRoute(
          path: '/studentDashboard',
          builder: (context, state) => const StudentDashboardView(),
        ),
      ],
    ),
  ],
);

void routeByRole(BuildContext context, String role) {
  switch (role.toLowerCase()) {
    case 'admin':
      context.go('/AdminDashboard');
      break;
    case 'doctor':
      context.go('/doctorDashboard');
      break;
    case 'library':
      context.go('/libraryDashboard');
      break;
    case 'student':
      context.go('/studentDashboard');
      break;
    default:
      context.go('/roleSelection');
  }
}