import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManagerNavBar extends StatelessWidget {
  final Widget child;

  const ManagerNavBar({
    super.key,
    required this.child,
  });

  int _getIndex(BuildContext context) {
    final location =
    GoRouterState.of(context).uri.toString();

    if (location.startsWith('/managerDashboard')) {
      return 0;
    }


    if (location.startsWith('/managerProfile')) {
      return 1;
    }

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
        selectedIconTheme:
        const IconThemeData(color: Colors.white),
        unselectedIconTheme:
        const IconThemeData(color: Colors.black54),
        selectedLabelStyle:
        const TextStyle(color: Colors.white),
        unselectedLabelStyle:
        const TextStyle(color: Colors.black54),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/managerDashboard');
              break;
            case 1:
              context.go('/managerProfile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}