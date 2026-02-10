import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentNavBar extends StatelessWidget {
  final Widget child;

  const StudentNavBar({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/studentDashboard')) return 0;
    if (location.startsWith('/studentChat')) return 1;
    if (location.startsWith('/studentProject')) return 2;
    if (location.startsWith('/studentProfile')) return 3;

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
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/studentDashboard');
              break;
            case 1:
              context.go('/studentChat');
              break;
            case 2:
              context.go('/studentProject');
              break;
            case 3:
              context.go('/studentProfile');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.padding_rounded),
            label: 'Projects',
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
