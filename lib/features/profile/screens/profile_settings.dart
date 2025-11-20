import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/locale_provider.dart';
import '../../../../providers/theme_mode_provider.dart';
import '../../../src/ui/components/glass_card.dart';
import '../../../src/utils/style_tokens.dart';
import '../../../src/ui/pages/profile/rewards_page.dart';

/// Profile & Settings screen
class ProfileSettings extends ConsumerStatefulWidget {
  const ProfileSettings({super.key});

  @override
  ConsumerState<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends ConsumerState<ProfileSettings> {
  bool _reducedMotion = false;
  bool _analyticsEnabled = true;
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
    AnalyticsService().trackScreenView('profile');
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        title: Text(l10n.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Edit profile
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    // Profile section
                    _ProfileSection(),
                    const SizedBox(height: 24),

                    // Appearance
                    _SectionTitle(title: l10n.appearance),
                    const SizedBox(height: 12),
                    _AppearanceSettings(),
                    const SizedBox(height: 24),

                    // Accessibility
                    _SectionTitle(title: l10n.accessibility),
                    const SizedBox(height: 12),
                    _AccessibilitySettings(
                      reducedMotion: _reducedMotion,
                      onReducedMotionChanged: (value) {
                        setState(() {
                          _reducedMotion = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Share with Provider
                    _SectionTitle(title: 'Share Data'),
                    const SizedBox(height: 12),
                    _ShareDataSection(),
                    const SizedBox(height: 24),

                    // Rewards & Insurance
                    _SectionTitle(title: 'Rewards & Insurance'),
                    const SizedBox(height: 12),
                    _RewardsSection(),
                    const SizedBox(height: 24),

                    // Privacy
                    _SectionTitle(title: l10n.privacy),
                    const SizedBox(height: 12),
                    _PrivacySettings(
                      analyticsEnabled: _analyticsEnabled,
                      onAnalyticsChanged: (value) async {
                        setState(() {
                          _analyticsEnabled = value;
                        });
                        await AnalyticsService().setEnabled(value);
                      },
                    ),
                    const SizedBox(height: 24),

                    // Language
                    _SectionTitle(title: l10n.language),
                    const SizedBox(height: 12),
                    const _LanguageSettings(),
                    const SizedBox(height: 24),

                    // About
                    _SectionTitle(title: l10n.about),
                    const SizedBox(height: 12),
                    _AboutSection(version: _appVersion),
                    const SizedBox(height: 24),

                    // Danger zone
                    _SectionTitle(title: l10n.dangerZone),
                    const SizedBox(height: 12),
                    _DangerZone(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation (same as Dashboard)
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4,
      selectedItemColor: themeManager.currentTheme.primary,
      unselectedItemColor: StyleTokens.getTextSecondaryStatic(isDark: isDark),
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/dashboard');
            break;
          case 1:
            context.go('/journal');
            break;
          case 2:
            context.go('/ai-chat');
            break;
          case 3:
            context.go('/care');
            break;
          case 4:
            context.go('/profile');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: l10n.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.book_outlined),
          activeIcon: const Icon(Icons.book),
          label: l10n.journal,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat_bubble_outline),
          activeIcon: const Icon(Icons.chat_bubble),
          label: l10n.aiChat,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.medical_services_outlined),
          activeIcon: const Icon(Icons.medical_services),
          label: l10n.care,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.person, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@example.com',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _AppearanceSettings extends ConsumerWidget {
  const _AppearanceSettings();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeModeNotifier = ref.read(themeModeProvider.notifier);
    
    // Determine if dark mode is currently active
    final isDarkMode = themeMode == ThemeMode.dark || 
        (themeMode == ThemeMode.system && 
         MediaQuery.of(context).platformBrightness == Brightness.dark);

    final l10n = AppLocalizations.of(context)!;
    
    return GlassCard(
      child: SwitchListTile(
        title: Text(l10n.darkMode),
        subtitle: Text(l10n.useDarkTheme),
        value: isDarkMode,
        onChanged: (value) {
          themeModeNotifier.toggleDarkMode(value);
        },
      ),
    );
  }
}

class _AccessibilitySettings extends StatelessWidget {
  final bool reducedMotion;
  final Function(bool) onReducedMotionChanged;

  const _AccessibilitySettings({
    required this.reducedMotion,
    required this.onReducedMotionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return GlassCard(
      child: SwitchListTile(
        title: Text(l10n.reduceMotion),
        subtitle: Text(l10n.disableAnimationsForBetterAccessibility),
        value: reducedMotion,
        onChanged: onReducedMotionChanged,
      ),
    );
  }
}

class _PrivacySettings extends StatelessWidget {
  final bool analyticsEnabled;
  final Function(bool) onAnalyticsChanged;

  const _PrivacySettings({
    required this.analyticsEnabled,
    required this.onAnalyticsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return GlassCard(
      child: Column(
        children: [
          SwitchListTile(
            title: Text(l10n.analytics),
            subtitle: Text(l10n.helpUsImproveBySharingUsageData),
            value: analyticsEnabled,
            onChanged: onAnalyticsChanged,
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.privacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Open privacy policy
            },
          ),
          ListTile(
            title: Text(l10n.termsOfService),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Open terms
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageSettings extends ConsumerWidget {
  const _LanguageSettings();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final localeNotifier = ref.read(localeProvider.notifier);
    
    // Get current language code for radio button selection
    // Default to 'en' if locale is null (system locale)
    final currentLanguageCode = locale?.languageCode ?? 'en';
    
    final l10n = AppLocalizations.of(context)!;
    
    return GlassCard(
      child: Column(
        children: [
          RadioListTile<String>(
            title: Text(l10n.english),
            value: 'en',
            groupValue: currentLanguageCode,
            onChanged: (value) {
              if (value != null) {
                localeNotifier.setLocaleFromString(value);
              }
            },
          ),
          RadioListTile<String>(
            title: Text(l10n.myanmar),
            value: 'my',
            groupValue: currentLanguageCode,
            onChanged: (value) {
              if (value != null) {
                // Use 'my_MM' for Myanmar locale (with country code)
                localeNotifier.setLocaleFromString('my_MM');
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String version;

  const _AboutSection({required this.version});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            title: Text(l10n.appVersion),
            trailing: Text(version),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.contactSupport),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Open support
            },
          ),
          ListTile(
            title: Text(l10n.rateApp),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Open app store
            },
          ),
        ],
      ),
    );
  }
}

class _DangerZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.deleteAccount,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showDeleteAccountDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAccount),
        content: Text(l10n.areYouSureYouWantToDeleteYourAccount),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              // TODO: Delete account
              Navigator.of(context).pop();
            },
            child: Text(
              l10n.delete,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareDataSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: ListTile(
        leading: Icon(
          Icons.medical_services,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text('Share with My Doctor'),
        subtitle: const Text('Generate a secure link to share your dashboard'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.push('/profile/share-with-provider');
        },
      ),
    );
  }
}

class _RewardsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: ListTile(
        leading: Icon(
          Icons.paid_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text('VitalsLink Rewards & Insurance'),
        subtitle: const Text('View available rewards and insurance benefits'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RewardsPage(),
            ),
          );
        },
      ),
    );
  }
}
