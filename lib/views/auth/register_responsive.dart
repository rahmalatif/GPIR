import 'package:flutter/material.dart';
import '../../../core/design/responsive_layout.dart';
import 'register_mobile.dart';
import 'register_web.dart';

class RegisterResponsive extends StatelessWidget {
  final String role;

  const RegisterResponsive({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: RegisterMobileView(role: role),
      web: RegisterWebView(role: role),
    );
  }
}