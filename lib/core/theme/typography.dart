import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Calm Vitality Typography System
/// Based on VitalsLink 2.0 design tokens
class VitalsLinkTypography {
  static TextTheme light() {
    final base = ThemeData.light().textTheme;
    return base.copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -0.02,
        color: VitalsLinkColors.text100,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.01,
        color: VitalsLinkColors.text100,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0,
        color: VitalsLinkColors.text100,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: VitalsLinkColors.text100,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: VitalsLinkColors.text100,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0,
        color: VitalsLinkColors.text100,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0,
        color: VitalsLinkColors.text300,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: VitalsLinkColors.text300,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: 0.01,
        color: VitalsLinkColors.text300,
      ),
    );
  }

  static TextTheme dark() {
    final base = ThemeData.dark().textTheme;
    return base.copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -0.02,
        color: VitalsLinkColors.text100,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.01,
        color: VitalsLinkColors.text100,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0,
        color: VitalsLinkColors.text100,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: VitalsLinkColors.text100,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: VitalsLinkColors.text100,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0,
        color: VitalsLinkColors.text100,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0,
        color: VitalsLinkColors.text300,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: VitalsLinkColors.text300,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: 0.01,
        color: VitalsLinkColors.text300,
      ),
    );
  }
}

/// Deprecated - use VitalsLinkTypography
@Deprecated('Use VitalsLinkTypography instead')
class HybridTypography extends VitalsLinkTypography {}
