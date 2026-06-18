import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../views/model/user_model.dart';

class AdminNavBar extends StatelessWidget {
  final Widget child;

  const AdminNavBar({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/adminDashboard')) return 0;
    if (location.startsWith('/adminTeam')) return 1;
    if (location.startsWith('/adminProfile')) return 2;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff4699A8),
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.black54),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.black54),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/adminDashboard');
              break;

            case 1:
              context.go('/adminTeam');
            case 2:
              context.go(
                '/adminProfile',
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
