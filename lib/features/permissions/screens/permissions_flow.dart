import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../core/utils/motion_utils.dart';
import '../../../../widgets/animated_gradient_bg.dart';
import '../../../../src/ui/components/glass_card.dart';
import '../../../../widgets/motion_button.dart';

/// Permissions & Connectors flow
class PermissionsFlow extends ConsumerStatefulWidget {
  const PermissionsFlow({super.key});

  @override
  ConsumerState<PermissionsFlow> createState() => _PermissionsFlowState();
}

class _PermissionsFlowState extends ConsumerState<PermissionsFlow> {
  final Map<String, bool> _permissions = {
    'health_data': false,
    'notifications': false,
    'location': false,
  };

  final Map<String, bool> _connectors = {
    'apple_health': false,
    'google_fit': false,
    'fitbit': false,
    'garmin': false,
  };

  @override
  void initState() {
    super.initState();
    AnalyticsService().trackScreenView('permissions');
  }

  Future<void> _requestPermission(String permission) async {
    // TODO: Implement actual permission request
    setState(() {
      _permissions[permission] = true;
    });
  }

  Future<void> _connectProvider(String provider) async {
    // TODO: Implement actual connector logic
    setState(() {
      _connectors[provider] = true;
    });
  }

  void _revokeAccess(String provider) {
    setState(() {
      _connectors[provider] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _PermissionsHeader(),
                const SizedBox(height: 24),

                // Permissions section
                const _SectionTitle(title: 'Permissions'),
                const SizedBox(height: 12),
                ..._permissions.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _PermissionCard(
                      permission: entry.key,
                      enabled: entry.value,
                      onToggle: (value) {
                        if (value) {
                          _requestPermission(entry.key);
                        } else {
                          setState(() {
                            _permissions[entry.key] = false;
                          });
                        }
                      },
                    ),
                  );
                }),

                const SizedBox(height: 32),

                // Connectors section
                const _SectionTitle(title: 'Connect Data Sources'),
                const SizedBox(height: 12),
                ..._connectors.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ConnectorCard(
                      provider: entry.key,
                      connected: entry.value,
                      onConnect: () => _connectProvider(entry.key),
                      onRevoke: () => _revokeAccess(entry.key),
                    ),
                  );
                }),

                const SizedBox(height: 32),

                // Done button
                MotionButton(
                  onPressed: () {
                    context.go('/dashboard');
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PermissionsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Permissions',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Grant access to health data',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
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
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ).animate().fadeIn(
          duration: MotionUtils.getDuration(context, MotionTokens.medium),
        );
  }
}

class _PermissionCard extends StatelessWidget {
  final String permission;
  final bool enabled;
  final Function(bool) onToggle;

  const _PermissionCard({
    required this.permission,
    required this.enabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = _getTitle(permission);
    final description = _getDescription(permission);
    final icon = _getIcon(permission);

    return GlassCard(
      child: ExpansionTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title),
        subtitle: Text(description),
        trailing: Switch(
          value: enabled,
          onChanged: onToggle,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why we need this:',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getWhyText(permission),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Text(
                  'Data we read:',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ..._getDataTypes(permission).map((type) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            size: 16, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(type, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(String permission) {
    switch (permission) {
      case 'health_data':
        return 'Health Data';
      case 'notifications':
        return 'Notifications';
      case 'location':
        return 'Location';
      default:
        return permission;
    }
  }

  String _getDescription(String permission) {
    switch (permission) {
      case 'health_data':
        return 'Read sleep, activity, and heart rate data';
      case 'notifications':
        return 'Receive reminders and updates';
      case 'location':
        return 'Track location for activity data';
      default:
        return '';
    }
  }

  IconData _getIcon(String permission) {
    switch (permission) {
      case 'health_data':
        return Icons.favorite;
      case 'notifications':
        return Icons.notifications;
      case 'location':
        return Icons.location_on;
      default:
        return Icons.settings;
    }
  }

  String _getWhyText(String permission) {
    switch (permission) {
      case 'health_data':
        return 'We read Sleep & Activity to give personalized insights. You can revoke anytime.';
      case 'notifications':
        return 'We send reminders to help you stay on track with your health goals.';
      case 'location':
        return 'We use location to track outdoor activities and provide better insights.';
      default:
        return '';
    }
  }

  List<String> _getDataTypes(String permission) {
    switch (permission) {
      case 'health_data':
        return ['Sleep duration', 'Heart rate', 'Steps', 'Activity'];
      case 'notifications':
        return ['Goal reminders', 'Sync status', 'Weekly summaries'];
      case 'location':
        return ['Activity location', 'Route data'];
      default:
        return [];
    }
  }
}

class _ConnectorCard extends StatelessWidget {
  final String provider;
  final bool connected;
  final VoidCallback onConnect;
  final VoidCallback onRevoke;

  const _ConnectorCard({
    required this.provider,
    required this.connected,
    required this.onConnect,
    required this.onRevoke,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = _getTitle(provider);
    final description = _getDescription(provider);
    final icon = _getIcon(provider);

    return GlassCard(
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title),
        subtitle: Text(description),
        trailing: connected
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _showRevokeDialog(context),
                    child: const Text('Revoke'),
                  ),
                ],
              )
            : MotionButton(
                onPressed: onConnect,
                child: const Text('Connect'),
              ),
      ),
    );
  }

  void _showRevokeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revoke Access'),
        content: Text(
          'Are you sure you want to revoke access to ${_getTitle(provider)}? This will stop syncing data from this source.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onRevoke();
              Navigator.of(context).pop();
            },
            child: Text(
              'Revoke',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(String provider) {
    switch (provider) {
      case 'apple_health':
        return 'Apple Health';
      case 'google_fit':
        return 'Google Fit';
      case 'fitbit':
        return 'Fitbit';
      case 'garmin':
        return 'Garmin';
      default:
        return provider;
    }
  }

  String _getDescription(String provider) {
    switch (provider) {
      case 'apple_health':
        return 'Sync data from Apple Health';
      case 'google_fit':
        return 'Sync data from Google Fit';
      case 'fitbit':
        return 'Sync data from Fitbit';
      case 'garmin':
        return 'Sync data from Garmin';
      default:
        return '';
    }
  }

  IconData _getIcon(String provider) {
    switch (provider) {
      case 'apple_health':
        return Icons.favorite;
      case 'google_fit':
        return Icons.directions_run;
      case 'fitbit':
        return Icons.watch;
      case 'garmin':
        return Icons.sports;
      default:
        return Icons.link;
    }
  }
}
