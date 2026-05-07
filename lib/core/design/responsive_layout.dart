import 'package:flutter/material.dart';

class ResponsiveLayout
    extends StatelessWidget {

  final Widget mobile;
  final Widget web;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.web,
  });

  static bool isMobile(
      BuildContext context) {
    return MediaQuery.of(context)
        .size
        .width <
        700;
  }

  static bool isWeb(
      BuildContext context) {
    return MediaQuery.of(context)
        .size
        .width >=
        700;
  }

  @override
  Widget build(
      BuildContext context) {

    final width =
        MediaQuery.of(context)
            .size
            .width;

    if (width >= 700) {
      return web;
    }

    return mobile;
  }
}