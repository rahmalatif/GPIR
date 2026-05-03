import 'package:flutter/material.dart';
import 'register_mobile.dart';

class RegisterWebView extends StatelessWidget {
  final String role;

  const RegisterWebView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: RegisterMobileView(role: role),
        ),
      ),
    );
  }
}
