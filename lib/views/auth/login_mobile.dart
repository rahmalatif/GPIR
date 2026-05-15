import 'package:flutter/material.dart';

import 'login_content.dart';

class LoginMobileView
    extends StatelessWidget {

  final String role;

  const LoginMobileView({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: SafeArea(
        child: LoginContent(
          role: role,
        ),
      ),
    );
  }
}