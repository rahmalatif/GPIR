import 'package:flutter/cupertino.dart';
import '../../core/design/responsive_layout.dart';
import 'login_mobile.dart';
import 'login_web.dart';

class LoginResponsive extends StatelessWidget {
  final String role;

  const LoginResponsive({required this.role});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: LoginMobileView(role: role),
      web: LoginWebView(role: role),
    );
  }
}