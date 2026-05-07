import 'package:flutter/material.dart';
import 'login_mobile.dart';

class LoginWebView extends StatelessWidget {
  final String role;

  const LoginWebView({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1A),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),

            child: Container(
              width: 400,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),

              child: LoginMobileView(role: role),
            ),
          ),
        ),
      ),
    );
  }
}