import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/vitalslink_apple_theme.dart';
import 'l10n/app_localizations.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_mode_provider.dart';
import 'src/routes.dart';

class VitalsLinkApp extends ConsumerWidget {
  const VitalsLinkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    
    // Create a key that changes with locale to force rebuild
    final localeKey = ValueKey(locale?.toString() ?? 'system');
    
    return MaterialApp.router(
      key: localeKey,
      debugShowCheckedModeBanner: false,
      title: 'VitalsLink',
      themeMode: themeMode,
      theme: VitalsLinkAppleTheme.lightTheme,
      darkTheme: VitalsLinkAppleTheme.darkTheme,
      locale: locale,
      routerConfig: appRoutes,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
