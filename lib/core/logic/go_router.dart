import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/admin/admin_profile.dart';
import 'package:graduation_project_recommender/views/auth/login_responsive.dart';
import 'package:graduation_project_recommender/views/auth/register_responsive.dart';
import 'package:graduation_project_recommender/views/auth/responsive_role_selection.dart';
import 'package:graduation_project_recommender/views/auth/role_selection_mobile.dart';
import 'package:graduation_project_recommender/views/doctor/add_idea/add_idea_mobile.dart';
import 'package:graduation_project_recommender/views/doctor/dashboard/doctor_dashboard_mobile.dart';
import 'package:graduation_project_recommender/views/doctor/notifications/doctor_notifications.dart';
import 'package:graduation_project_recommender/views/doctor/projects/pending_ideas_mobile.dart';
import 'package:graduation_project_recommender/views/doctor/projects/project_details_mobile.dart';
import 'package:graduation_project_recommender/views/doctor/projects/projects_mobile.dart';
import 'package:graduation_project_recommender/views/doctor/projects/reject_idea_mobile.dart';
import 'package:graduation_project_recommender/views/library/add_new_project.dart';
import 'package:graduation_project_recommender/views/library/all_project.dart';
import 'package:graduation_project_recommender/views/library/library_dashboard.dart';
import 'package:graduation_project_recommender/views/library/library_profile.dart';
import 'package:graduation_project_recommender/views/library/library_project_details.dart';
import 'package:graduation_project_recommender/views/model/library.dart';
import 'package:graduation_project_recommender/views/model/student.dart';
import 'package:graduation_project_recommender/views/splash.dart';
import 'package:graduation_project_recommender/views/student/dashboard/dashboardMobile.dart';
import 'package:graduation_project_recommender/views/student/chatting/student_chat.dart';
import 'package:graduation_project_recommender/views/student/similarity/have_idea_mobile.dart';
import 'package:graduation_project_recommender/views/student/similarity/similarity_check_mobile.dart';
import 'package:graduation_project_recommender/views/student/similarity/choose_supervisor_mobile.dart';
import 'package:graduation_project_recommender/views/student/similarity/send_idea_to_dr_mobile.dart';
import 'package:graduation_project_recommender/views/student/similarity/confirm_submission_mobile.dart';
import 'package:graduation_project_recommender/views/model/project_idea.dart';
import 'package:graduation_project_recommender/views/model/doctor.dart';
import 'package:graduation_project_recommender/views/student/dashboard/student_project_details.dart';
import '../../views/admin/admin_dashboard.dart';
import '../../views/admin/admin_notifications.dart';
import '../../views/admin/approved_projects.dart';
import '../../views/admin/idea_details.dart';
import '../../views/admin/pending_projects.dart';
import '../../views/admin/project_id.dart';
import '../../views/auth/login_mobile.dart';
import '../../views/doctor/add_idea/add_idea_responsive.dart';
import '../../views/doctor/dashboard/doctor_dashboard_responsive.dart';
import '../../views/doctor/profile/profile.dart';
import '../../views/doctor/projects/pending_ideas_responsive.dart';
import '../../views/doctor/projects/project_details_responsive.dart';
import '../../views/doctor/projects/projects_responsive.dart';
import '../../views/doctor/projects/reject_idea_responsive.dart';
import '../../views/model/DR_project.dart';
import '../../views/model/admin_project.dart';
import '../../views/model/library_project.dart';
import '../../views/model/team.dart';
import '../../views/model/user_model.dart';
import '../../views/student/dashboard/dashboard_responsive.dart';
import '../../views/student/dashboard/edit_team.dart';
import '../../views/student/notification/student_notifications_responsive.dart';
import '../../views/student/profile/st_profile_responsive.dart';
import '../../views/student/projectAssigend/project_assigned_mobile.dart';
import '../../views/student/projectAssigend/project_assigned_responsive.dart';
import '../../views/student/recommendation/ai_recommend.dart';
import '../../views/student/recommendation/ai_recommend_responsive.dart';
import '../../views/student/recommendation/projects_recommendation_responsive.dart';
import '../../views/student/recommendation/projects_recommendation_mobile.dart';
import '../../views/student/similarity/choose_supervisor_responsive.dart';
import '../../views/student/similarity/choose_ta_responsive.dart';
import '../../views/student/similarity/confirm_submission_responsive.dart';
import '../../views/student/similarity/have_idea_responsive.dart';
import '../../views/student/similarity/send_idea_to_dr_responsive.dart';
import '../../views/student/similarity/similarity_check_responsive.dart';
import '../../views/student/profile/st_profile_mobile.dart';
import '../../views/student/notification/student_notifications.dart';

import '../design/admin_nav_bar.dart';
import '../design/dr_nav_bar.dart';
import '../design/library_nav_bar.dart';
import '../design/nav_Bar.dart';

final GoRouter appRouter = GoRouter(initialLocation: '/splash', routes: [
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
    path: '/projectRecommendation',
    builder: (context, state) {
      final ideas = state.extra as List<dynamic>;
      return ProjectsRecommendationResponsive(
        ideas: ideas,
      );
    },
  ),

  GoRoute(
    path: '/aiRecommend',
    builder: (context, state) => const AiRecommendMobile(),
  ),

  GoRoute(
    path: '/haveIdea',
    builder: (context, state) {
      final recommendedIdea = state.extra;

      print(
        "ROUTER IDEA: "
        "$recommendedIdea",
      );

      return HaveIdeaResponsive(
        recommendedIdea: recommendedIdea,
      );
    },
  ),

  GoRoute(
    path: '/similarityCheck',
    builder: (context, state) {
      final data = state.extra as Map<String, dynamic>;

      return SimilarityCheckMobileView(
        result: data['result'],
        projectIdea: data['projectIdea'],
      );
    },
  ),

  GoRoute(
    path: '/chooseTA',
    builder: (context, state) {
      final data = state.extra as Map<String, dynamic>;

      return ChooseTAResponsive(
        projectIdea: data['projectIdea'],
        doctor: data['doctor'],
        similarityScore: data['similarity_score'],
      );
    },
  ),

  GoRoute(
    path: '/chooseSupervisor',
    builder: (context, state) {
      ProjectIdea projectIdea;
      double similarityScore = 0;

      if (state.extra is Map<String, dynamic>) {
        final data = state.extra as Map<String, dynamic>;

        projectIdea = data['projectIdea'] as ProjectIdea;

        similarityScore = (data['similarityScore'] ?? 0).toDouble();
      } else {
        projectIdea = state.extra as ProjectIdea;
      }

      return ChooseSupervisorResponsive(
        projectIdea: projectIdea,
        similarityScore: similarityScore,
      );
    },
  ),

  GoRoute(
    path: '/studentNotifications',
    builder: (context, state) => const StudentNotificationsResponsive(),
  ),

  GoRoute(
    path: '/studentProfile',
    builder: (context, state) {
      return const StudentProfileMobileView();
    },
  ),

  GoRoute(
    path: '/confirmSubmission',
    builder: (context, state) {
      final data = state.extra as Map<String, dynamic>;

      return ConfirmSubmissionResponsive(
        doctor: data['doctor'],
        ta: data['ta'],
        projectIdea: data['projectIdea'],
        similarityScore: data['similarityScore'],
        teamMembers: [],
      );
    },
  ),

  GoRoute(
    path: '/projectAssigned',
    builder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return ProjectAssignedResponsive(
        projectId: data['projectId'],
        status: data['status'],
      );
    },
  ),

// ================= DOCTOR =================

  GoRoute(
    path: '/drPendingIdeas',
    builder: (context, state) => const PendingIdeasResponsive(),
  ),

  GoRoute(
    path: '/rejectIdea',
    builder: (context, state) => const RejectIdeaResponsive(),
  ),

  GoRoute(
    path: '/ideaDetails',
    builder: (context, state) {
      final projectId = state.extra as String;

      return ProjectDetailsMobileView(
        projectId: projectId,
      );
    },
  ),

  GoRoute(
    path: '/addIdea',
    builder: (context, state) => const AddIdeaResponsive(),
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

  GoRoute(
      path: '/projectId',
      builder: (context, state) {
        final projectId = state.extra as String;

        return ProjectIdView(projectId: projectId);
      }),
  GoRoute(
    path: '/adminIdeaDetails',
    builder: (context, state) {
      final projectId = state.extra as String;

      return AdminIdeaDetailsView(
        projectId: projectId,
      );
    },
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
        path: '/adminDashboard',
        builder: (context, state) => const AdminDashboardView(),
      ),
      GoRoute(
        path: '/adminProfile',
        builder: (context, state) => const AdminProfileView(),
      ),
      ShellRoute(
        builder: (context, state, child) => DoctorNavBar(child: child),
        routes: [
          GoRoute(
            path: '/doctorDashboard',
            builder: (context, state) {
              return const DashboardMobileView();
            },
          ),
          GoRoute(
            path: '/doctorProjects',
            builder: (context, state) {
              return const ProjectsResponsive();
            },
          ),
          GoRoute(
            path: '/doctorProfile',
            builder: (context, state) {
              return const DoctorProfileView();
            },
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) => StudentNavBar(child: child),
        routes: [
          GoRoute(
            path: '/studentDashboard',
            builder: (context, state) {
              return const StudentDashboardResponsive();
            },
          ),
          GoRoute(
            path: '/studentChat',
            builder: (context, state) {
              return const StudentChatView();
            },
          ),
          GoRoute(
            path: '/studentProject',
            builder: (context, state) {
              return const ProjectAssignedMobileView();
            },
          ),
        ],
      ),
    ],
  )
]);

void routeByRole(
  BuildContext context,
  String role, {
  UserModel? user,
}) {
  switch (role.toLowerCase()) {
    case 'admin':
      context.go('/adminDashboard');
      break;

    case 'doctor':
      context.go(
        '/doctorDashboard',
        extra: user,
      );
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
