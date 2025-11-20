import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// VitalsLink Theme Tokens & Theme Manager
/// Supports: Default Blue, Teal Gradient, Deep Indigo, Auto (time-of-day)
class StyleTokens {
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

  // Glass Opacity
  static const double glassOpacityLight = 0.8;
  static const double glassOpacityDark = 0.6;
  static const double glassBlur = 20.0;

  // Inner Glow
  static const double innerGlowRadius = 1.0;
  static const double innerGlowOpacity = 0.1;

  /// Static helper for text secondary color
  static Color getTextSecondaryStatic({required bool isDark}) {
    return isDark ? const Color(0xFF8E8E93) : const Color(0xFF8E8E93);
  }

  /// Static helper for text primary color
  static Color getTextPrimaryStatic({required bool isDark}) {
    return isDark ? Colors.white : Colors.black;
  }
}

/// Theme Variant Definition
class ThemeVariant {
  final String id;
  final String name;
  final Color primary;
  final List<Color> accentGradient;
  final Color accentContrast;

  const ThemeVariant({
    required this.id,
    required this.name,
    required this.primary,
    required this.accentGradient,
    required this.accentContrast,
  });
}

/// Theme Presets
class ThemePresets {
  // Default Blue (#007AFF)
  static const defaultBlue = ThemeVariant(
    id: 'defaultBlue',
    name: 'Default Blue',
    primary: Color(0xFF007AFF),
    accentGradient: [Color(0xFF007AFF), Color(0xFF0051D5)],
    accentContrast: Colors.white,
  );

  // Teal Gradient (#5EE6C4 → #A3F3FF)
  static const tealGradient = ThemeVariant(
    id: 'tealGradient',
    name: 'Teal Gradient',
    primary: Color(0xFF5EE6C4),
    accentGradient: [Color(0xFF5EE6C4), Color(0xFFA3F3FF)],
    accentContrast: Color(0xFF1C1C1E),
  );

  // Deep Indigo Gradient (#3B3BFF → #7A5CFF)
  static const deepIndigo = ThemeVariant(
    id: 'deepIndigo',
    name: 'Deep Indigo',
    primary: Color(0xFF3B3BFF),
    accentGradient: [Color(0xFF3B3BFF), Color(0xFF7A5CFF)],
    accentContrast: Colors.white,
  );

  static const List<ThemeVariant> all = [
    defaultBlue,
    tealGradient,
    deepIndigo,
  ];
}

/// Theme Manager - Singleton
class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  ThemeVariant _currentTheme = ThemePresets.defaultBlue;
  bool _autoMode = false;
  final ValueNotifier<ThemeVariant> themeNotifier =
      ValueNotifier(ThemePresets.defaultBlue);

  ThemeVariant get currentTheme => _currentTheme;
  bool get isAutoMode => _autoMode;

  /// Initialize theme from storage
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final themeId = prefs.getString('vitalslink_theme_id') ?? 'defaultBlue';
    _autoMode = prefs.getBool('vitalslink_theme_auto') ?? false;

    if (_autoMode) {
      _updateAutoTheme();
    } else {
      _currentTheme = ThemePresets.all.firstWhere(
        (t) => t.id == themeId,
        orElse: () => ThemePresets.defaultBlue,
      );
      themeNotifier.value = _currentTheme;
    }
  }

  /// Set theme variant
  Future<void> setTheme(ThemeVariant theme) async {
    _currentTheme = theme;
    _autoMode = false;
    themeNotifier.value = theme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('vitalslink_theme_id', theme.id);
    await prefs.setBool('vitalslink_theme_auto', false);
  }

  /// Enable auto mode (time-of-day based)
  Future<void> setAutoMode(bool enabled) async {
    _autoMode = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('vitalslink_theme_auto', enabled);

    if (enabled) {
      _updateAutoTheme();
    } else {
      await initialize();
    }
  }

  /// Update theme based on time of day
  void _updateAutoTheme() {
    final hour = DateTime.now().hour;
    // Morning (6-12): Teal, Day (12-18): Blue, Evening (18-6): Indigo
    if (hour >= 6 && hour < 12) {
      _currentTheme = ThemePresets.tealGradient;
    } else if (hour >= 12 && hour < 18) {
      _currentTheme = ThemePresets.defaultBlue;
    } else {
      _currentTheme = ThemePresets.deepIndigo;
    }
    themeNotifier.value = _currentTheme;
  }

  /// Get ThemeData for Flutter
  ThemeData getThemeData({required bool isDark}) {
    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _currentTheme.primary,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      scaffoldBackgroundColor:
          isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
        ),
      ),
    );
  }

  /// Get surface color for glass cards
  Color getSurfaceColor({required bool isDark}) {
    return isDark
        ? const Color(0x801C1C1E) // 50% opacity dark
        : const Color(0x80FFFFFF); // 50% opacity light
  }

  /// Get text primary color
  Color getTextPrimary({required bool isDark}) {
    return isDark ? Colors.white : Colors.black;
  }

  /// Get text secondary color
  Color getTextSecondary({required bool isDark}) {
    return isDark ? const Color(0xFF8E8E93) : const Color(0xFF8E8E93);
  }
}
