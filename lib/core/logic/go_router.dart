import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/views/admin/admin_profile.dart';
import 'package:graduation_project_recommender/views/doctor/add_idea.dart';
import 'package:graduation_project_recommender/views/doctor/chat.dart';
import 'package:graduation_project_recommender/views/doctor/doctor_dashboard.dart';
import 'package:graduation_project_recommender/views/doctor/pending_ideas.dart';
import 'package:graduation_project_recommender/views/doctor/project_details.dart';
import 'package:graduation_project_recommender/views/doctor/projects.dart';
import 'package:graduation_project_recommender/views/doctor/reject_idea.dart';
import 'package:graduation_project_recommender/views/library/add_new_project.dart';
import 'package:graduation_project_recommender/views/library/all_project.dart';
import 'package:graduation_project_recommender/views/library/library_dashboard.dart';
import 'package:graduation_project_recommender/views/library/library_profile.dart';
import 'package:graduation_project_recommender/views/library/library_project_details.dart';
import 'package:graduation_project_recommender/views/model/admin.dart';
import 'package:graduation_project_recommender/views/model/library.dart';
import 'package:graduation_project_recommender/views/model/student.dart';
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
import 'package:graduation_project_recommender/views/student/student_project_details.dart';
import '../../views/admin/admin_dashboard.dart';
import '../../views/admin/all_projects.dart';
import '../../views/admin/approved_projects.dart';
import '../../views/admin/idea_details.dart';
import '../../views/admin/pending_projects.dart';
import '../../views/admin/project_id.dart';
import '../../views/doctor/profile.dart';
import '../../views/model/DR_project.dart';
import '../../views/model/admin_project.dart';
import '../../views/model/library_project.dart';
import '../../views/model/team.dart';
import '../../views/register.dart';
import '../../views/student/edit_team.dart';
import '../../views/student/project_assigned.dart';
import '../../views/student/recommended_projects.dart';
import '../../views/student/st_profile.dart';
import '../design/admin_nav_bar.dart';
import '../design/dr_nav_bar.dart';
import '../design/library_nav_bar.dart';
import '../design/nav_Bar.dart';
import 'go_router_refresh_stream.dart';

final db = FirebaseDatabase.instance.ref("users");

final GoRouter appRouter = GoRouter(
  initialLocation: '/roleSelection',

  refreshListenable:
  GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),

  redirect: (context, state) async {
    final user = FirebaseAuth.instance.currentUser;
    final path = state.uri.path;

    print("Redirect Path: $path, User: ${user?.uid}");

    if (user == null) {
      if (path == '/login' || path == '/register' || path == '/roleSelection') return null;
      return '/roleSelection';
    }

    final snapshot = await db.child(user.uid).get();

    if (!snapshot.exists) {
      print("No data found for user in Database");
      return null;
    }

    final role = snapshot.child("role").value.toString().toLowerCase();
    print("User Role Detected: $role");

    if (path == '/roleSelection' || path == '/login' || path == '/') {
      if (role == 'admin') return '/AdminDashboard';
      if (role == 'doctor') return '/doctorDashboard';
      if (role == 'library') return '/libraryDashboard';
      if (role == 'student') return '/studentDashboard';
    }

    return null;
  },


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
    GoRoute(
      path: '/register',
      builder: (context, state) {
        final role = state.extra as String;
        return RegisterView(role: role);
      },
    ),

    //student

    GoRoute(
      path: '/aiRecommend',
      builder: (context, state) {
        return AiRecommendView();
      },
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

    GoRoute(
      path: '/projectRecommendation',
      builder: (context, state) {
        final projectIdea = state.extra as ProjectIdea;

        return ProjectsRecommendationView(
          projectIdea: projectIdea,
          tracks: projectIdea.requiredTracks,
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


    //doctor

    GoRoute(
      path: '/drPendingIdeas',
      builder: (context, state) => PendingIdeasView(),
    ),

    GoRoute(
      path: '/ideaDetails',
      builder: (context, state) {
        final project = state.extra as ProjectDR;
        return ProjectDetailsView(project: project);
      },
    ),

    GoRoute(
      path: '/rejectIdea',
      builder: (context, state) => RejectIdeaView(),
    ),

    GoRoute(path: '/addIdea', builder: (context, state) => AddIdeaView()),

    //Admin

    GoRoute(
      path: '/adminPendingIdeas',
      builder: (context, state) => const PendingProjectsView(),
    ),

    GoRoute(
      path: '/adminIdeasDetails',
      builder: (context, state) {
        final project = state.extra as AdminProject;
        return AdminIdeaDetailsView(project: project);
      },
    ),

    GoRoute(
      path: '/projectId',
      builder: (context, state) => const ProjectIdView(),
    ),

    GoRoute(
      path: '/adminApprovedProjects',
      builder: (context, state) => const AdminApprovedProjectsView(),
    ),

    //Library
    GoRoute(
      path: '/libraryProjectDetails',
      builder: (context, state) {
        final library = state.extra as LibraryProject;
        return LibraryProjectDetails(project: library);
      },
    ),

    //AppBar shellRoute

    //Library
    ShellRoute(
      builder: (context, state, child) => LibraryNavBar(child: child),
      routes: [
        GoRoute(
          path: '/libraryDashboard',
          builder: (context, state) => const LibraryDashboardView(),
        ),
        GoRoute(
          path: '/libraryAddProject',
          builder: (context, state) => const AddNewProjectView(),
        ),
        GoRoute(
          path: '/libraryAllProject',
          builder: (context, state) => const AllProjectsView(),
        ),
        GoRoute(
          path: '/libraryProfile',
          builder: (context, state) {
            final library = state.extra as Library?;

            return LibraryProfileView(
              library: library ??
                  Library(
                    id: "LIB01",
                    name: "Main Library",
                    email: "library@test.com",
                  ),
            );
          },
        ),
      ],
    ),

    //Admin
    ShellRoute(
      builder: (context, state, child) => AdminNavBar(child: child),
      routes: [
        GoRoute(
          path: '/AdminDashboard',
          builder: (context, state) => const AdminDashboardView(),
        ),
        GoRoute(
          path: '/adminAllProjectsId',
          builder: (context, state) => const AdminAllProjectsIdView(),
        ),
        GoRoute(
          path: '/adminProfile',
          builder: (context, state) {
            final admin = state.extra as Admin?;

            return AdminProfileView(
              admin: admin ??
                  Admin(
                    id: "ADM001",
                    name: "Mr. Osama",
                    email: "admin@test.com",
                  ),
            );
          },
        ),
      ],
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
            builder: (context, state) => const ProjectsView()),
        GoRoute(
          path: '/doctorChat',
          builder: (context, state) => const ChatView(),
        ),
        GoRoute(
            path: '/doctorProfile',
            builder: (context, state) {
              final doctor = state.extra as Doctor?;
              return DoctorProfileView(doctor: doctor);
            }),
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
          builder: (context, state) => const ChatsView(),
        ),
        GoRoute(
          path: '/editTeam',
          builder: (context, state) {
            final team = state.extra as List<TeamMember>;
            return EditTeamView(members: team);
          },
        ),
        GoRoute(
            path: '/studentProject',
            builder: (context, state) {
              final project = state.extra as ProjectIdea?;
              return StudentProjectDetailsView(
                project: project ??
                    ProjectIdea(
                      description: "",
                      name: '',
                      specializations: '',
                      features: '',
                      technologies: '',
                      teamMembers: [],
                      requiredTracks: [],
                    ),
              );
            }),
        GoRoute(
          path: '/studentProfile',
          builder: (context, state) {
            final student = state.extra as Student?;

            return StudentProfileView(
              student: student ??
                  Student(
                    id: "STD01",
                    name: "Student Name",
                  ),
            );
          },
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
      break;
  }
}
