import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'colors.dart';
import 'gradients.dart';
import 'typography.dart';

/// Calm Vitality Theme System
/// Based on VitalsLink 2.0 design tokens
class VitalsLinkTheme {
  VitalsLinkTheme()
      : lightTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: VitalsLinkColors.primary500,
            primary: VitalsLinkColors.primary500,
            secondary: VitalsLinkColors.accent400,
            surface: Colors.white,
            brightness: Brightness.light,
            error: VitalsLinkColors.error,
            onPrimary: VitalsLinkColors.text100,
            onSecondary: VitalsLinkColors.background900,
            onSurface: VitalsLinkColors.text100,
          ),
          scaffoldBackgroundColor: VitalsLinkColors.backgroundLight,
          textTheme: VitalsLinkTypography.light(),
          useMaterial3: true,
          cardTheme: CardThemeData(
            color: Colors.white.withAlpha((0.92 * 255).round()),
            margin: EdgeInsets.zero,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor:
                VitalsLinkColors.primary500.withAlpha((0.15 * 255).round()),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
          ),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ),
        darkTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: VitalsLinkColors.primary500,
            primary: VitalsLinkColors.primary500,
            secondary: VitalsLinkColors.accent400,
            surface: VitalsLinkColors.background800,
            brightness: Brightness.dark,
            error: VitalsLinkColors.error,
            onPrimary: VitalsLinkColors.text100,
            onSecondary: VitalsLinkColors.background900,
            onSurface: VitalsLinkColors.text100,
          ),
          scaffoldBackgroundColor: VitalsLinkColors.background900,
          textTheme: VitalsLinkTypography.dark(),
          useMaterial3: true,
          cardTheme: CardThemeData(
            color: VitalsLinkColors.background800.withAlpha((0.9 * 255).round()),
            margin: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.transparent,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
          ),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        );

  final ThemeData lightTheme;
  final ThemeData darkTheme;

  LinearGradient get primaryGradient => VitalsLinkGradients.primary;
  LinearGradient get heroGradient => VitalsLinkGradients.hero;
}

final appThemeProvider = Provider<VitalsLinkTheme>((ref) => VitalsLinkTheme());

/// Deprecated - use VitalsLinkTheme
@Deprecated('Use VitalsLinkTheme instead')
class AppTheme extends VitalsLinkTheme {}
