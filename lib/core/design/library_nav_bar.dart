import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../views/model/library.dart';

class LibraryNavBar extends StatelessWidget {
  final Widget child;

  const LibraryNavBar({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/libraryDashboard')) return 0;
    if (location.startsWith('/libraryAddProject')) return 1;
    if (location.startsWith('/libraryAllProject')) return 2;
    if (location.startsWith('/libraryProfile')) return 3;

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
              context.go('/libraryDashboard');
              break;
            case 1:
              context.go('/libraryAddProject');
            case 2:
              context.go('/libraryAllProject');
              break;
            case 3:
              context.go(
                '/libraryProfile',
              );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: 'projects',
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
