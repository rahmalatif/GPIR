import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget web;

  const ResponsiveLayout({
    required this.mobile,
    required this.web,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width >= 900) return web;
    return mobile;
  }
}