import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Global motion system tokens for VitalsLink
/// Provides consistent animation durations, curves, and spring configurations
class MotionTokens {
  // Duration tokens
  static const Duration micro = Duration(milliseconds: 80);
  static const Duration small = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 360);
  static const Duration large = Duration(milliseconds: 600);
  static const Duration extraLarge = Duration(milliseconds: 900);

  // Stagger step for list animations
  static const Duration staggerStep = Duration(milliseconds: 60);

  // Standard easing curve
  static const Curve standardCurve = Cubic(0.2, 0.9, 0.4, 1.0);
  static const Curve easeOutCubic = Cubic(0.33, 1.0, 0.68, 1.0);
  static const Curve easeInCubic = Cubic(0.32, 0.0, 0.67, 0.0);

  // Spring configuration
  static const SpringDescription standardSpring = SpringDescription(
    mass: 1.0,
    stiffness: 120.0,
    damping: 16.0,
  );

  // Button press scale
  static const double buttonPressScale = 0.97;

  // Card entrance translate
  static const double cardEntranceTranslate = 12.0;
}

/// Motion utilities for checking reduced motion preferences
class MotionUtils {
  /// Check if animations should be reduced based on system settings
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.of(context).disableAnimations ||
        MediaQuery.of(context).textScaler.scale(1.0) > 1.3;
  }

  /// Get duration respecting reduced motion preferences
  static Duration getDuration(
    BuildContext context,
    Duration normalDuration,
  ) {
    if (shouldReduceMotion(context)) {
      return const Duration(milliseconds: 0);
    }
    return normalDuration;
  }

  /// Get curve respecting reduced motion preferences
  static Curve getCurve(BuildContext context, Curve normalCurve) {
    if (shouldReduceMotion(context)) {
      return Curves.linear;
    }
    return normalCurve;
  }

  /// Create a spring animation respecting reduced motion
  static Animation<double> createSpringAnimation(
    BuildContext context,
    AnimationController controller,
  ) {
    if (shouldReduceMotion(context)) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.linear,
        ),
      );
    }
    // Use SpringSimulation with AnimationController
    final simulation = SpringSimulation(
      MotionTokens.standardSpring,
      0.0,
      1.0,
      0.0,
    );
    controller.animateWith(simulation);
    return controller;
  }
}

/// Animation builders for common patterns
class MotionBuilders {
  /// Fade in animation
  static Widget fadeIn(
    BuildContext context,
    Widget child, {
    Duration? duration,
    Duration? delay,
  }) {
    final effectiveDuration = duration ?? MotionTokens.medium;
    return child
        .animate(
          delay: delay ?? Duration.zero,
        )
        .fadeIn(
          duration: MotionUtils.getDuration(context, effectiveDuration),
          curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
        );
  }

  /// Slide up animation
  static Widget slideUp(
    BuildContext context,
    Widget child, {
    Duration? duration,
    Duration? delay,
    double? distance,
  }) {
    final effectiveDuration = duration ?? MotionTokens.medium;
    return child
        .animate(
          delay: delay ?? Duration.zero,
        )
        .slideY(
          begin: distance ?? 0.1,
          end: 0,
          duration: MotionUtils.getDuration(context, effectiveDuration),
          curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
        )
        .fadeIn(
          duration: MotionUtils.getDuration(context, effectiveDuration),
        );
  }

  /// Scale in animation
  static Widget scaleIn(
    BuildContext context,
    Widget child, {
    Duration? duration,
    Duration? delay,
  }) {
    final effectiveDuration = duration ?? MotionTokens.small;
    return child
        .animate(
          delay: delay ?? Duration.zero,
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: MotionUtils.getDuration(context, effectiveDuration),
          curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
        )
        .fadeIn(
          duration: MotionUtils.getDuration(context, effectiveDuration),
        );
  }

  /// Staggered list animation
  static List<Widget> staggerList(
    BuildContext context,
    List<Widget> children, {
    Duration? staggerStep,
  }) {
    final step = staggerStep ?? MotionTokens.staggerStep;
    return children.asMap().entries.map((entry) {
      final index = entry.key;
      final child = entry.value;
      return child
          .animate(
            delay: step * index,
          )
          .fadeIn(
            duration: MotionUtils.getDuration(context, MotionTokens.medium),
            curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
          )
          .slideY(
            begin: MotionTokens.cardEntranceTranslate / 100,
            end: 0,
            duration: MotionUtils.getDuration(context, MotionTokens.medium),
            curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
          );
    }).toList();
  }
}
