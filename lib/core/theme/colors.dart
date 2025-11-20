import 'package:flutter/material.dart';

/// Calm Vitality Design System Colors
/// Based on VitalsLink 2.0 design tokens
class VitalsLinkColors {
  // Background
  static const background900 = Color(0xFF0F1720);
  static const background800 = Color(0xFF141820);

  // Surface
  static const surface700 = Color(0x08FFFFFF); // rgba(255,255,255,0.03)
  static const surface600 = Color(0x0DFFFFFF); // rgba(255,255,255,0.05)

  // Primary
  static const primary500 = Color(0xFF7B7CFF);
  static const primary400 = Color(0xFF9B9CFF);
  static const primary600 = Color(0xFF5B5CFF);

  // Accent
  static const accent400 = Color(0xFF6AE7C7);
  static const accent600 = Color(0xFFFF7AA2);

  // Status
  static const success = Color(0xFF4CD964);
  static const warning = Color(0xFFFF9500);
  static const error = Color(0xFFFF3B30);

  // Text
  static const text100 = Color(0xFFF5F7FA);
  static const text300 = Color(0xFFBFC8D3);
  static const text500 = Color(0xFF8A95A6);

  // Legacy aliases for compatibility
  static const primary = primary500;
  static const secondary = accent400;
  static const accent = accent400;
  static const backgroundLight = Color(0xFFF9FAFB);
  static const backgroundDark = background900;
  static const text = text100;
  static const cardDark = background800;
  static const glass = surface700;
  static const danger = error;
}

/// Deprecated - use VitalsLinkColors
@Deprecated('Use VitalsLinkColors instead')
class HybridColors extends VitalsLinkColors {}
