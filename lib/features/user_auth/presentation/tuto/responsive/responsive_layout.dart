import 'package:flutter/material.dart';
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1800 &&
          MediaQuery.of(context).size.width >= 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1800;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1800) {
          return desktop;
        } else if (constraints.maxWidth >= 1200) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}