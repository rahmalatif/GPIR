import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';

class LoginView extends StatelessWidget {
  final String role;

  const LoginView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            AppImage(
              image: "assets/png/logo.png",
              height: 184,
              width: 184,
            ),
            const SizedBox(height: 20),
            Text(
              "Login as $role",
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please sign in to continue",
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            _InputText("ID", false),
            const SizedBox(height: 20),
            _InputText("Password", true),
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF46F0D2),
                minimumSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                if (role == "Student") {
                  context.go('/studentDashboard');
                } else if (role == "Doctor") {
                  context.go('/doctorDashboard');
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget _InputText(String label, bool isPassword) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF46F0D2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.lightBlueAccent),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    ),
  );
}
