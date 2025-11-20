import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../widgets/animated_gradient_bg.dart';
import '../../../../src/ui/components/glass_card.dart';
import '../../../../widgets/motion_button.dart';
import '../../../../widgets/pro_bottom_nav.dart';

/// Data Hub screen with vault and sources management
class DataHubScreen extends ConsumerStatefulWidget {
  const DataHubScreen({super.key});

  @override
  ConsumerState<DataHubScreen> createState() => _DataHubScreenState();
}

class _DataHubScreenState extends ConsumerState<DataHubScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<DataSource> _dataSources = [
    DataSource(
      id: '1',
      name: 'Apple Health',
      type: DataSourceType.health,
      connected: true,
      lastSync: DateTime.now().subtract(const Duration(hours: 2)),
      status: SyncStatus.synced,
    ),
    DataSource(
      id: '2',
      name: 'Google Fit',
      type: DataSourceType.health,
      connected: false,
      lastSync: null,
      status: SyncStatus.disconnected,
    ),
    DataSource(
      id: '3',
      name: 'Fitbit',
      type: DataSourceType.health,
      connected: true,
      lastSync: DateTime.now().subtract(const Duration(days: 1)),
      status: SyncStatus.error,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    AnalyticsService().trackScreenView('data_hub');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _createBackup() async {
    // TODO: Implement backup creation
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup created successfully')),
      );
    }
  }

  Future<void> _restoreBackup() async {
    // TODO: Implement backup restore
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup restored successfully')),
      );
    }
  }

  Future<void> _exportData() async {
    // TODO: Implement data export
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data exported successfully')),
      );
    }
  }

  void _deleteData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Data'),
        content: const Text(
          'Are you sure you want to delete all your data? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Delete all data
              Navigator.of(context).pop();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data deleted')),
                );
              }
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _DataHubHeader(),

              // Tabs
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Sources'),
                  Tab(text: 'Vault'),
                ],
              ),

              // Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _SourcesTab(dataSources: _dataSources),
                    _VaultTab(
                      onCreateBackup: _createBackup,
                      onRestoreBackup: _restoreBackup,
                      onExportData: _exportData,
                      onDeleteData: _deleteData,
                    ),
                  ],
                ),
              ),

              // Bottom navigation
              ProBottomNav(
                currentIndex: 0,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/dashboard');
                      break;
                    case 1:
                      context.go('/coach');
                      break;
                    case 2:
                      context.go('/insights');
                      break;
                    case 3:
                      context.go('/profile');
                      break;
                  }
                },
                items: const [
                  NavItem(
                      icon: Icons.dashboard,
                      label: 'Dashboard',
                      route: '/dashboard'),
                  NavItem(
                      icon: Icons.chat_bubble, label: 'Coach', route: '/coach'),
                  NavItem(
                      icon: Icons.insights,
                      label: 'Insights',
                      route: '/insights'),
                  NavItem(
                      icon: Icons.person, label: 'Profile', route: '/profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DataHubHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Data Hub',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              // TODO: Trigger sync
            },
          ),
        ],
      ),
    );
  }
}

class _SourcesTab extends StatelessWidget {
  final List<DataSource> dataSources;

  const _SourcesTab({required this.dataSources});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connected Sources',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ...dataSources.map((source) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _DataSourceCard(source: source),
            );
          }),
        ],
      ),
    );
  }
}

class _DataSourceCard extends StatelessWidget {
  final DataSource source;

  const _DataSourceCard({required this.source});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getColorForStatus(source.status).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getIconForType(source.type),
            color: _getColorForStatus(source.status),
          ),
        ),
        title: Text(source.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getStatusText(source.status),
              style: theme.textTheme.bodySmall,
            ),
            if (source.lastSync != null)
              Text(
                'Last synced: ${_formatTime(source.lastSync!)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                ),
              ),
          ],
        ),
        trailing: source.connected
            ? IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // TODO: Show options menu
                },
              )
            : MotionButton(
                onPressed: () {
                  // TODO: Connect source
                },
                child: const Text('Connect'),
              ),
      ),
    );
  }

  Color _getColorForStatus(SyncStatus status) {
    switch (status) {
      case SyncStatus.synced:
        return Colors.green;
      case SyncStatus.syncing:
        return Colors.blue;
      case SyncStatus.error:
        return Colors.red;
      case SyncStatus.disconnected:
        return Colors.grey;
    }
  }

  IconData _getIconForType(DataSourceType type) {
    switch (type) {
      case DataSourceType.health:
        return Icons.favorite;
      case DataSourceType.fitness:
        return Icons.directions_run;
      case DataSourceType.nutrition:
        return Icons.restaurant;
    }
  }

  String _getStatusText(SyncStatus status) {
    switch (status) {
      case SyncStatus.synced:
        return 'Synced';
      case SyncStatus.syncing:
        return 'Syncing...';
      case SyncStatus.error:
        return 'Error';
      case SyncStatus.disconnected:
        return 'Disconnected';
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class _VaultTab extends StatelessWidget {
  final VoidCallback onCreateBackup;
  final VoidCallback onRestoreBackup;
  final VoidCallback onExportData;
  final VoidCallback onDeleteData;

  const _VaultTab({
    required this.onCreateBackup,
    required this.onRestoreBackup,
    required this.onExportData,
    required this.onDeleteData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Vault',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Encrypted backups and data management',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Backup section
          _VaultSection(
            title: 'Backup',
            icon: Icons.backup,
            children: [
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: const Text('Create Backup'),
                subtitle: const Text('Create an encrypted backup'),
                trailing: const Icon(Icons.chevron_right),
                onTap: onCreateBackup,
              ),
              ListTile(
                leading: const Icon(Icons.restore),
                title: const Text('Restore Backup'),
                subtitle: const Text('Restore from a backup'),
                trailing: const Icon(Icons.chevron_right),
                onTap: onRestoreBackup,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Export section
          _VaultSection(
            title: 'Export',
            icon: Icons.download,
            children: [
              ListTile(
                leading: const Icon(Icons.file_download),
                title: const Text('Export Data'),
                subtitle: const Text('Export your data as JSON'),
                trailing: const Icon(Icons.chevron_right),
                onTap: onExportData,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Delete section
          _VaultSection(
            title: 'Delete',
            icon: Icons.delete,
            children: [
              ListTile(
                leading: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  'Delete All Data',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                subtitle: const Text('Permanently delete all your data'),
                trailing: const Icon(Icons.chevron_right),
                onTap: onDeleteData,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VaultSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _VaultSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const Divider(),
          ...children,
        ],
      ),
    );
  }
}

class DataSource {
  final String id;
  final String name;
  final DataSourceType type;
  final bool connected;
  final DateTime? lastSync;
  final SyncStatus status;

  DataSource({
    required this.id,
    required this.name,
    required this.type,
    required this.connected,
    this.lastSync,
    required this.status,
  });
}

enum DataSourceType {
  health,
  fitness,
  nutrition,
}

enum SyncStatus {
  synced,
  syncing,
  error,
  disconnected,
}
