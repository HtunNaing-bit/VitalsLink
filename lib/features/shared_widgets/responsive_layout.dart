import 'package:flutter/material.dart';

/// ResponsiveLayout - Adapts UI based on screen size
/// Mobile <600, Tablet 600-1024, Desktop >1024
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1024 && desktop != null) {
      return desktop!;
    } else if (width > 600 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

/// Responsive breakpoints
class ResponsiveBreakpoints {
  static const mobile = 600;
  static const tablet = 1024;
}

/// Responsive utilities
class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < ResponsiveBreakpoints.mobile;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= ResponsiveBreakpoints.mobile &&
        width < ResponsiveBreakpoints.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= ResponsiveBreakpoints.tablet;
  }

  static int getColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }
}
