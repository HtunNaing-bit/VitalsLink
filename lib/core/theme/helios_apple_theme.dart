import 'package:flutter/material.dart';

/// VitalsLink Apple-Style Design System
/// Production-ready theme matching Apple's design language
class VitalsLinkAppleTheme {
  // Primary Color - Apple Blue
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color primaryBlueDark = Color(0xFF0A84FF);

  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundGray = Color(0xFFF2F2F7);
  static const Color backgroundDark = Color(0xFF000000);
  static const Color backgroundDarkSecondary = Color(0xFF1C1C1E);

  // Surface Colors (Glassmorphic)
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceLightBlur = Color(0x80FFFFFF); // 50% opacity
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color surfaceDarkBlur = Color(0x801C1C1E); // 50% opacity

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textTertiary = Color(0xFFC7C7CC);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF8E8E93);

  // Semantic Colors
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = primaryBlue;

  // Spacing System (8pt grid)
  static const double spacing1 = 4.0;
  static const double spacing2 = 8.0;
  static const double spacing3 = 12.0;
  static const double spacing4 = 16.0;
  static const double spacing5 = 20.0;
  static const double spacing6 = 24.0;
  static const double spacing8 = 32.0;
  static const double spacing10 = 40.0;
  static const double spacing12 = 48.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  static const double radiusRound = 999.0;

  // Typography Scale (SF Pro equivalent)
  static TextStyle get displayLarge => const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.37,
        height: 1.2,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.36,
        height: 1.2,
      );

  static TextStyle get headline => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.35,
        height: 1.3,
      );

  static TextStyle get title1 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.38,
        height: 1.3,
      );

  static TextStyle get title2 => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.41,
        height: 1.3,
      );

  static TextStyle get title3 => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.24,
        height: 1.3,
      );

  static TextStyle get body => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.41,
        height: 1.4,
      );

  static TextStyle get bodyBold => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.41,
        height: 1.4,
      );

  static TextStyle get callout => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
        height: 1.4,
      );

  static TextStyle get subhead => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.24,
        height: 1.4,
      );

  static TextStyle get footnote => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.08,
        height: 1.4,
      );

  static TextStyle get caption1 => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        height: 1.3,
      );

  static TextStyle get caption2 => const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.07,
        height: 1.3,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.24,
        height: 1.4,
      );

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: primaryBlue,
        scaffoldBackgroundColor: backgroundGray,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          secondary: primaryBlue,
          surface: surfaceLight,
          surfaceContainerHighest: backgroundGray,
          error: error,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: textPrimary,
          onSurfaceVariant: textPrimary,
          onError: Colors.white,
        ),
        textTheme: TextTheme(
          displayLarge: displayLarge.copyWith(color: textPrimary),
          displayMedium: displayMedium.copyWith(color: textPrimary),
          headlineLarge: headline.copyWith(color: textPrimary),
          titleLarge: title1.copyWith(color: textPrimary),
          titleMedium: title2.copyWith(color: textPrimary),
          titleSmall: title3.copyWith(color: textPrimary),
          bodyLarge: body.copyWith(color: textPrimary),
          bodyMedium: body.copyWith(color: textPrimary),
          bodySmall: subhead.copyWith(color: textSecondary),
          labelLarge: callout.copyWith(color: textPrimary),
          labelMedium: footnote.copyWith(color: textSecondary),
          labelSmall: caption1.copyWith(color: textTertiary),
        ),
        cardTheme: const CardThemeData(
          color: surfaceLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
          ),
          margin: EdgeInsets.zero,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: textPrimary),
          titleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
                horizontal: spacing6, vertical: spacing3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusRound),
            ),
            textStyle: title3,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: spacing4,
            vertical: spacing3,
          ),
        ),
      );

  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: primaryBlueDark,
        scaffoldBackgroundColor: backgroundDark,
        colorScheme: const ColorScheme.dark(
          primary: primaryBlueDark,
          secondary: primaryBlueDark,
          surface: surfaceDark,
          surfaceContainerHighest: backgroundDark,
          error: error,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: textPrimaryDark,
          onSurfaceVariant: textPrimaryDark,
          onError: Colors.white,
        ),
        textTheme: TextTheme(
          displayLarge: displayLarge.copyWith(color: textPrimaryDark),
          displayMedium: displayMedium.copyWith(color: textPrimaryDark),
          headlineLarge: headline.copyWith(color: textPrimaryDark),
          titleLarge: title1.copyWith(color: textPrimaryDark),
          titleMedium: title2.copyWith(color: textPrimaryDark),
          titleSmall: title3.copyWith(color: textPrimaryDark),
          bodyLarge: body.copyWith(color: textPrimaryDark),
          bodyMedium: body.copyWith(color: textPrimaryDark),
          bodySmall: subhead.copyWith(color: textSecondaryDark),
          labelLarge: callout.copyWith(color: textPrimaryDark),
          labelMedium: footnote.copyWith(color: textSecondaryDark),
          labelSmall: caption1.copyWith(color: textTertiary),
        ),
        cardTheme: const CardThemeData(
          color: surfaceDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
          ),
          margin: EdgeInsets.zero,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: textPrimaryDark),
          titleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: textPrimaryDark,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlueDark,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
                horizontal: spacing6, vertical: spacing3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusRound),
            ),
            textStyle: title3,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: spacing4,
            vertical: spacing3,
          ),
        ),
      );
}
