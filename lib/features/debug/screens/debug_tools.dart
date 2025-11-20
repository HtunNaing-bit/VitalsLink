import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../core/services/sync_service.dart';
import '../../../../widgets/animated_gradient_bg.dart';
import '../../../../src/ui/components/glass_card.dart';

/// Debug tools screen (only in debug mode)
class DebugTools extends ConsumerStatefulWidget {
  const DebugTools({super.key});

  @override
  ConsumerState<DebugTools> createState() => _DebugToolsState();
}

class _DebugToolsState extends ConsumerState<DebugTools> {
  bool _isOffline = false;
  final SyncService _syncService = SyncService();

  @override
  void initState() {
    super.initState();
    AnalyticsService().trackScreenView('debug');
  }

  Future<void> _toggleOffline() async {
    setState(() {
      _isOffline = !_isOffline;
    });
    // TODO: Implement offline simulation
  }

  Future<void> _clearLocalDB() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Local Database'),
        content: const Text(
          'Are you sure you want to clear all local data? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Clear',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // TODO: Clear all local storage
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Local database cleared')),
      );
    }
  }

  Future<void> _triggerSync() async {
    final result = await _syncService.syncNow(force: true);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.success ? 'Sync successful' : 'Sync failed'),
        ),
      );
    }
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
                _DebugHeader(),
                const SizedBox(height: 24),

                // Sync section
                const _SectionTitle(title: 'Sync'),
                const SizedBox(height: 12),
                _SyncSection(
                  onSync: _triggerSync,
                  isOffline: _isOffline,
                  onToggleOffline: _toggleOffline,
                ),
                const SizedBox(height: 24),

                // Storage section
                const _SectionTitle(title: 'Storage'),
                const SizedBox(height: 12),
                _StorageSection(
                  onClear: _clearLocalDB,
                ),
                const SizedBox(height: 24),

                // Analytics section
                const _SectionTitle(title: 'Analytics'),
                const SizedBox(height: 12),
                _AnalyticsSection(),
                const SizedBox(height: 24),

                // Mock data section
                const _SectionTitle(title: 'Mock Data'),
                const SizedBox(height: 12),
                _MockDataSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DebugHeader extends StatelessWidget {
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
                'Debug Tools',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Development tools and diagnostics',
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
    );
  }
}

class _SyncSection extends StatelessWidget {
  final VoidCallback onSync;
  final bool isOffline;
  final VoidCallback onToggleOffline;

  const _SyncSection({
    required this.onSync,
    required this.isOffline,
    required this.onToggleOffline,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            title: const Text('Trigger Sync'),
            subtitle: const Text('Force a sync now'),
            trailing: IconButton(
              icon: const Icon(Icons.sync),
              onPressed: onSync,
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Simulate Offline'),
            subtitle: const Text('Simulate offline mode'),
            value: isOffline,
            onChanged: (_) => onToggleOffline(),
          ),
        ],
      ),
    );
  }
}

class _StorageSection extends StatelessWidget {
  final VoidCallback onClear;

  const _StorageSection({required this.onClear});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            title: const Text('Storage Size'),
            subtitle: const Text('View storage statistics'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show storage stats
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Clear Local Database'),
            subtitle: const Text('Delete all local data'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onClear,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final analyticsService = AnalyticsService();
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            title: const Text('Analytics Status'),
            subtitle: Text(
              analyticsService.isEnabled ? 'Enabled' : 'Disabled',
            ),
            trailing: Switch(
              value: analyticsService.isEnabled,
              onChanged: (value) {
                analyticsService.setEnabled(value);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Queued Events'),
            subtitle: Text('${analyticsService.queuedEventsCount} events'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show queued events
            },
          ),
        ],
      ),
    );
  }
}

class _MockDataSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          ListTile(
            title: const Text('Load Mock Data'),
            subtitle: const Text('Load sample health data'),
            trailing: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // TODO: Load mock data
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mock data loaded')),
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Health Profile'),
            subtitle: const Text('Simulate different health profiles'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showProfileDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Health Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Healthy'),
              subtitle: const Text('Optimal health metrics'),
              onTap: () {
                // TODO: Load healthy profile
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Average'),
              subtitle: const Text('Average health metrics'),
              onTap: () {
                // TODO: Load average profile
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Poor'),
              subtitle: const Text('Below average health metrics'),
              onTap: () {
                // TODO: Load poor profile
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
