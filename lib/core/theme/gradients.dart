import 'package:flutter/material.dart';
import 'colors.dart';

/// Calm Vitality Gradient System
/// Based on VitalsLink 2.0 design tokens
class VitalsLinkGradients {
  /// Primary gradient - calm purple to teal (vertical, top to bottom)
  /// Matches the polished UI background: soft lavender/periwinkle to light teal
  static const primary = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [VitalsLinkColors.primary500, VitalsLinkColors.accent400],
  );

  /// Light theme background gradient - softer, more pastel version
  /// For light mode: soft lavender to gentle teal
  static const lightBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFB8B9FF), // Soft lavender/periwinkle (lighter primary500)
      Color(0xFFA8F5E8), // Gentle teal/aqua (lighter accent400)
    ],
  );

  /// Dark theme background gradient - deeper, richer version
  /// For dark mode: deep indigo to dark teal
  static const darkBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4B4CFF), // Deep indigo (darker primary500)
      Color(0xFF3AD7B7), // Dark teal (darker accent400)
    ],
  );

  /// Pulse gradient - purple variants
  static const pulse = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [VitalsLinkColors.primary500, VitalsLinkColors.primary600],
  );

  /// Aqua gradient - teal to purple
  static const aqua = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [VitalsLinkColors.accent400, VitalsLinkColors.primary500],
  );

  /// Sunset gradient - pink to purple
  static const sunset = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [VitalsLinkColors.accent600, VitalsLinkColors.primary500],
  );

  /// Hero gradient for CTAs (diagonal for buttons)
  static const hero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [VitalsLinkColors.primary500, VitalsLinkColors.accent400],
  );
}

/// Deprecated - use VitalsLinkGradients
@Deprecated('Use VitalsLinkGradients instead')
class HybridGradients extends VitalsLinkGradients {}
