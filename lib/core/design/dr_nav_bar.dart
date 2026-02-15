import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorNavBar extends StatelessWidget {
  final Widget child;

  const DoctorNavBar({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/doctorDashboard')) return 0;
    if (location.startsWith('/doctorProjects')) return 1;
    if (location.startsWith('/doctorChat')) return 2;
    if (location.startsWith('/doctorProfile')) return 3;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff4699A8),
        currentIndex: _getIndex(context),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,

        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/doctorDashboard');
              break;
            case 1:
              context.go('/doctorProjects');
              break;
            case 2:
              context.go('/doctorChat');
              break;
            case 3:
              context.go('/doctorProfile');
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],

        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
