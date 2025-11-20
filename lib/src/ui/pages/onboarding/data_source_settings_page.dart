import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';

/// Data Source Settings Page (Granular Consent)
class DataSourceSettingsPage extends StatefulWidget {
  final String dataSourceId;
  final String dataSourceName;
  final IconData dataSourceIcon;

  const DataSourceSettingsPage({
    super.key,
    required this.dataSourceId,
    required this.dataSourceName,
    required this.dataSourceIcon,
  });

  @override
  State<DataSourceSettingsPage> createState() => _DataSourceSettingsPageState();
}

class _DataSourceSettingsPageState extends State<DataSourceSettingsPage> {
  // Granular permission toggles
  bool _syncSleepData = false;
  bool _syncActivitySteps = false;
  bool _syncHeartRateData = false;
  bool _syncMindfulMinutes = false;
  bool _syncWorkoutData = false;

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine which permissions to show based on data source
    final isHealthKit = widget.dataSourceId == 'healthkit';
    final isGoogleFit = widget.dataSourceId == 'googlefit';
    final isOura = widget.dataSourceId == 'oura';
    final isGarmin = widget.dataSourceId == 'garmin';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(widget.dataSourceName),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: StyleTokens.spacing4),
              // Header
              GlassCard(
                padding: const EdgeInsets.all(StyleTokens.spacing5),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(StyleTokens.spacing4),
                      decoration: BoxDecoration(
                        color:
                            themeManager.currentTheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.dataSourceIcon,
                        size: 32,
                        color: themeManager.currentTheme.primary,
                      ),
                    ),
                    const SizedBox(width: StyleTokens.spacing4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.dataSourceName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: StyleTokens.spacing1),
                          Text(
                            'Control what data you share',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: StyleTokens.getTextSecondaryStatic(
                                      isDark: isDark),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Permissions Section
              Text(
                'Data Permissions',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: StyleTokens.spacing3),
              // Sleep Data
              if (isHealthKit || isGoogleFit || isOura || isGarmin)
                GlassCard(
                  child: SwitchListTile(
                    title: const Text('Sync Sleep Data'),
                    subtitle: const Text('Sleep duration, quality, and stages'),
                    value: _syncSleepData,
                    onChanged: (value) {
                      setState(() {
                        _syncSleepData = value;
                      });
                    },
                    secondary: const Icon(Icons.bedtime_outlined),
                  ),
                ),
              const SizedBox(height: StyleTokens.spacing3),
              // Activity & Steps
              if (isHealthKit || isGoogleFit || isGarmin)
                GlassCard(
                  child: SwitchListTile(
                    title: const Text('Sync Activity & Steps'),
                    subtitle: const Text('Steps, distance, and active minutes'),
                    value: _syncActivitySteps,
                    onChanged: (value) {
                      setState(() {
                        _syncActivitySteps = value;
                      });
                    },
                    secondary: const Icon(Icons.directions_walk),
                  ),
                ),
              const SizedBox(height: StyleTokens.spacing3),
              // Heart Rate Data
              if (isHealthKit || isGoogleFit || isOura || isGarmin)
                GlassCard(
                  child: SwitchListTile(
                    title: const Text('Sync Heart Rate Data'),
                    subtitle: const Text('Resting heart rate and HRV'),
                    value: _syncHeartRateData,
                    onChanged: (value) {
                      setState(() {
                        _syncHeartRateData = value;
                      });
                    },
                    secondary: const Icon(Icons.favorite_outline),
                  ),
                ),
              const SizedBox(height: StyleTokens.spacing3),
              // Mindful Minutes
              if (isHealthKit || isGoogleFit)
                GlassCard(
                  child: SwitchListTile(
                    title: const Text('Sync Mindful Minutes'),
                    subtitle: const Text('Meditation and mindfulness data'),
                    value: _syncMindfulMinutes,
                    onChanged: (value) {
                      setState(() {
                        _syncMindfulMinutes = value;
                      });
                    },
                    secondary: const Icon(Icons.self_improvement),
                  ),
                ),
              const SizedBox(height: StyleTokens.spacing3),
              // Workout Data (for Garmin)
              if (isGarmin)
                GlassCard(
                  child: SwitchListTile(
                    title: const Text('Sync Workout Data'),
                    subtitle:
                        const Text('Exercise sessions and performance metrics'),
                    value: _syncWorkoutData,
                    onChanged: (value) {
                      setState(() {
                        _syncWorkoutData = value;
                      });
                    },
                    secondary: const Icon(Icons.fitness_center),
                  ),
                ),
              const SizedBox(height: StyleTokens.spacing6),
              // Info Section
              GlassCard(
                padding: const EdgeInsets.all(StyleTokens.spacing4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 20,
                      color: themeManager.currentTheme.primary,
                    ),
                    const SizedBox(width: StyleTokens.spacing3),
                    Expanded(
                      child: Text(
                        'You can change these permissions at any time in Settings. Only the data types you enable will be synced to VitalsLink.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: StyleTokens.getTextSecondaryStatic(
                                  isDark: isDark),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Save Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Save permissions
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Permissions saved for ${widget.dataSourceName}'),
                      backgroundColor: themeManager.currentTheme.primary,
                    ),
                  );
                  context.pop();
                },
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
                  'Save Permissions',
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
}
