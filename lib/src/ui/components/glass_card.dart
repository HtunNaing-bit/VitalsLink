import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/style_tokens.dart';

/// Glass Card Component with Inner Glow & Accessible Contrast
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool animate;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeManager = ThemeManager();
    final surfaceColor = themeManager.getSurfaceColor(isDark: isDark);

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            blurRadius: StyleTokens.glassBlur,
            offset: const Offset(0, 4),
          ),
          // Inner glow
          BoxShadow(
            color: themeManager.currentTheme.primary
                .withOpacity(StyleTokens.innerGlowOpacity),
            blurRadius: StyleTokens.innerGlowRadius,
            spreadRadius: -1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: StyleTokens.glassBlur,
            sigmaY: StyleTokens.glassBlur,
          ),
          child: Container(
            padding: padding ?? const EdgeInsets.all(StyleTokens.spacing4),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
            ),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
        child: card,
      );
    }

    if (animate) {
      card = card
          .animate()
          .fadeIn(
            duration: 300.ms,
            curve: Curves.easeOut,
          )
          .slideY(
            begin: 0.1,
            end: 0,
            duration: 300.ms,
            curve: Curves.easeOut,
          );
    }

    return card;
  }
}
