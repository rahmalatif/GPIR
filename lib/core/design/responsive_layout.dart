import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget web;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.web,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 900;

  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width >= 900) {
      return web;
    } else if (width >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}