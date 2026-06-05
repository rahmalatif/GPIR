import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TANavBar extends StatelessWidget {
  final Widget child;

  const TANavBar({
    super.key,
    required this.child,
  });

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/taDashboard')) return 0;
    if (location.startsWith('/taChats')) return 1;
    if (location.startsWith('/taProfile')) return 2;

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
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/taDashboard');
                break;

              case 1:
                context.go('/taChats');
                break;
              case 2:
                context.go('/taProfile');
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}
