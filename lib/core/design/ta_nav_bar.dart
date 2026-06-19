import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'chat_badge.dart';

class TANavBar extends StatelessWidget {
  final Widget child;

  const TANavBar({
    super.key,
    required this.child,
  });

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/taDashboard')) return 0;
    if (location.startsWith('/taProjects')) return 1;
    if (location.startsWith('/taChats')) return 2;
    if (location.startsWith('/taProfile')) return 3;

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
                context.go('/taProjects');
                break;
              case 2:
                context.go('/taChats');
                break;
              case 3:
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
              icon: Icon(Icons.assignment),
              label: 'Projects',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.chat),
                  ChatBadge(),
                ],
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}