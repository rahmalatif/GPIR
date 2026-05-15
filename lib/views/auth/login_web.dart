import 'package:flutter/material.dart';

import 'login_content.dart';

class LoginWebView
    extends StatelessWidget {

  final String role;

  const LoginWebView({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
      const Color(0xFF0D0F1A),

      body: Center(
        child:
        SingleChildScrollView(
          child: Container(
            width: 450,

            padding:
            const EdgeInsets.all(
                25),

            decoration:
            BoxDecoration(
              color: Colors.black
                  .withOpacity(0.25),

              borderRadius:
              BorderRadius.circular(
                  20),
            ),

            child: LoginContent(
              role: role,
            ),
          ),
        ),
      ),
    );
  }
}