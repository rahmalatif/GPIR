import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning\nMr. Osama";
    if (hour < 17) return "Good Afternoon\nMr. Osama";
    return "Good Evening\nMr. Osama";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 40),

            Text(
              greeting(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                project(
                  title: "Pending\nProjects",
                  icon: Icons.pending_actions,
                  onTap: () {
                    context.push(
                      '/adminPendingIdeas'
                    );
                  },
                ),
                const SizedBox(width: 14),
                project(
                  title: "Approved\nProjects",
                  icon: Icons.check_circle_outline,
                  onTap: () {
                    context.push(
                      '/adminApprovedProjects'
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

        GestureDetector(
          onTap: (){
            context.push('/adminAllProjectsId');
          },
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1D2E),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Icon(Icons.menu, color: Colors.cyan, size: 28),
                const SizedBox(width: 12),
                Text(
                  "All projects with IDs",
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        )
          ],
        ),
      ),
    );
  }
}

Widget project({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1D2E),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.cyan, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


