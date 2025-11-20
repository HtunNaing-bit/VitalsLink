import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';
import 'data_source_settings_page.dart';

/// Onboarding Connect Screen (Page 2 of 3)
/// Allows users to connect their health data sources
class OnboardingConnectScreen extends StatefulWidget {
  const OnboardingConnectScreen({super.key});

  @override
  State<OnboardingConnectScreen> createState() =>
      _OnboardingConnectScreenState();
}

class _OnboardingConnectScreenState extends State<OnboardingConnectScreen> {
  final Map<String, bool> _connectedSources = {};

  static const List<DataSource> _dataSources = [
    DataSource(
      id: 'healthkit',
      name: 'Apple Health',
      icon: Icons.health_and_safety,
      description: 'Sync health data from Apple Health',
    ),
    DataSource(
      id: 'googlefit',
      name: 'Google Fit',
      icon: Icons.fitness_center,
      description: 'Sync activity and health data',
    ),
    DataSource(
      id: 'oura',
      name: 'Oura Ring',
      icon: Icons.circle,
      description: 'Sync sleep and recovery data',
    ),
    DataSource(
      id: 'garmin',
      name: 'Garmin',
      icon: Icons.watch,
      description: 'Connect your Garmin device',
    ),
    DataSource(
      id: 'labcorp_quest',
      name: 'Labcorp / Quest',
      icon: Icons.science,
      description: 'Connect lab results from Labcorp or Quest Diagnostics',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/welcome'),
        ),
        title: const Text('Connect Your Data'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: StyleTokens.spacing4),
              // Header
              Text(
                'Link your health apps and devices to get started',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Data Sources List
              ..._dataSources.map((source) => _DataSourceCard(
                    source: source,
                    isConnected: _connectedSources[source.id] ?? false,
                    themeManager: themeManager,
                    isDark: isDark,
                    onCardTap: () => _handleCardTap(context, source),
                    onCheckmarkTap: () => _toggleSelection(source.id),
                  )),
              const SizedBox(height: StyleTokens.spacing6),
              // Continue Button
              ElevatedButton(
                onPressed: () => context.go('/onboarding/personalize'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeManager.currentTheme.primary,
                  foregroundColor: themeManager.currentTheme.accentContrast,
                  padding: const EdgeInsets.symmetric(
                      vertical: StyleTokens.spacing4),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusMedium),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handles card tap - navigates to detail page for configurable sources
  void _handleCardTap(BuildContext context, DataSource source) {
    if (source.id == 'labcorp_quest') {
      // Labcorp/Quest doesn't have granular permissions, just toggle
      _toggleSelection(source.id);
    } else {
      // Navigate to detail page for other sources
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DataSourceSettingsPage(
            dataSourceId: source.id,
            dataSourceName: source.name,
            dataSourceIcon: source.icon,
          ),
        ),
      );
    }
  }

  /// Toggles the selection state of a data source
  void _toggleSelection(String sourceId) {
    setState(() {
      _connectedSources[sourceId] = !(_connectedSources[sourceId] ?? false);
    });
  }
}

/// Data Source Card Widget
class _DataSourceCard extends StatelessWidget {
  final DataSource source;
  final bool isConnected;
  final ThemeManager themeManager;
  final bool isDark;
  final VoidCallback onCardTap;
  final VoidCallback onCheckmarkTap;

  const _DataSourceCard({
    required this.source,
    required this.isConnected,
    required this.themeManager,
    required this.isDark,
    required this.onCardTap,
    required this.onCheckmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: StyleTokens.spacing3),
      child: GlassCard(
        padding: const EdgeInsets.all(StyleTokens.spacing4),
        onTap: onCardTap,
        child: Row(
          children: [
            // Icon
            _buildIcon(),
            const SizedBox(width: StyleTokens.spacing3),
            // Content
            Expanded(
              child: _buildContent(context),
            ),
            // Checkmark
            _buildCheckmark(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(StyleTokens.spacing3),
      decoration: BoxDecoration(
        color: isConnected
            ? themeManager.currentTheme.primary
            : themeManager.currentTheme.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        source.icon,
        color: isConnected
            ? themeManager.currentTheme.accentContrast
            : themeManager.currentTheme.primary,
        size: 24,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          source.name,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          source.description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
              ),
        ),
      ],
    );
  }

  Widget _buildCheckmark(BuildContext context) {
    return GestureDetector(
      onTap: onCheckmarkTap,
      child: Icon(
        isConnected ? Icons.check_circle : Icons.circle_outlined,
        color: isConnected
            ? themeManager.currentTheme.primary
            : StyleTokens.getTextSecondaryStatic(isDark: isDark),
      ),
    );
  }
}

/// Data Source Model
class DataSource {
  final String id;
  final String name;
  final IconData icon;
  final String description;

  const DataSource({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}
