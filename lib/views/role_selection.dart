import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_recommender/core/design/app_image.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F1A),
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

            const Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Please select your role",
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),

            const SizedBox(height: 30),

            _selectButton(context, "🎓 Student", "student"),
            const SizedBox(height: 30),
            _selectButton(context, "👨‍🏫 Doctor", "doctor"),
            const SizedBox(height: 30),
            _selectButton(context, "🧾 Admin", "admin"),
            const SizedBox(height: 30),
            _selectButton(context, "📚 Library", "library"),

          ],
        ),
      ),
    );
  }
}

Widget _selectButton(BuildContext context, String role, String argument) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF46F0D2),
      minimumSize: const Size(300, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: () {
      context.go(
        '/login',
        extra: argument,
      );

    },
    child: Text(
      role,
      style: const TextStyle(fontSize: 18, color: Colors.black),

    ),

  );
}
