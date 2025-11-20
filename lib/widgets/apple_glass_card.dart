import 'package:flutter/material.dart';
import 'dart:ui';

/// Apple-style Glassmorphic Card Component
/// Matches iOS design language with blur effect and subtle shadows
class AppleGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  const AppleGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackground = backgroundColor ??
        (isDark
            ? const Color(0x801C1C1E) // 50% opacity dark surface
            : const Color(0x80FFFFFF)); // 50% opacity white surface

    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(16.0);

    Widget card = Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        color: effectiveBackground,
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: effectiveBorderRadius,
              color: Colors.transparent,
            ),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: card,
      );
    }

    return card;
  }
}
