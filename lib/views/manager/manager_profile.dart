import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_service.dart';

class ManagerProfileView extends StatelessWidget {
  const ManagerProfileView({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    AuthService.token = null;
    AuthService.userId = null;
    AuthService.role = null;
    AuthService.name = null;
    AuthService.email = null;
    AuthService.studentId = null;

    if (!context.mounted) return;

    context.go('/roleSelection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0F1A),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.cyan,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AuthService.name ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AuthService.email ?? "",
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/roleSelection'),
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
