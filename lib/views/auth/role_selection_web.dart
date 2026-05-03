import 'package:flutter/material.dart';
import 'role_selection_mobile.dart';

class RoleSelectionWeb extends StatelessWidget {
  const RoleSelectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const RoleSelectionMobileView(),
        ),
      ),
    );
  }
}