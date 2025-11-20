import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants.dart';

/// Locale provider that manages and persists locale preference
class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier() : super(null) {
    _loadLocale();
  }

  /// Load locale from SharedPreferences
  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeString = prefs.getString(AppConstants.storageKeyLocale);
      
      if (localeString != null) {
        state = _parseLocale(localeString);
      } else {
        // Default to system locale or English
        state = null; // null means use system locale
      }
    } catch (e) {
      // If loading fails, use system default
      state = null;
    }
  }

  /// Set locale and persist it
  Future<void> setLocale(Locale locale) async {
    state = locale;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.storageKeyLocale, _localeToString(locale));
    } catch (e) {
      // If saving fails, continue with the change
    }
  }

  /// Set locale from string (e.g., 'en', 'my_MM')
  Future<void> setLocaleFromString(String localeString) async {
    final locale = _parseLocale(localeString);
    await setLocale(locale);
  }

  /// Parse locale string to Locale object
  Locale _parseLocale(String localeString) {
    // Handle formats like 'en', 'my', 'my_MM'
    final parts = localeString.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(parts[0]);
    }
  }

  /// Convert Locale object to string
  String _localeToString(Locale locale) {
    if (locale.countryCode != null) {
      return '${locale.languageCode}_${locale.countryCode}';
    }
    return locale.languageCode;
  }

  /// Get current locale string representation
  String? get currentLocaleString {
    if (state == null) return null;
    return _localeToString(state!);
  }
}

/// Provider for locale
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>(
  (ref) => LocaleNotifier(),
);

