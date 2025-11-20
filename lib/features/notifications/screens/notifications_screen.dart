import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../src/ui/components/glass_card.dart';
import '../../../../src/utils/style_tokens.dart';

/// Notifications & Reminders screen
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'Goal Reminder',
      body: 'Time to check in on your sleep goal',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      type: NotificationType.goal,
      read: false,
    ),
    NotificationItem(
      id: '2',
      title: 'Sync Complete',
      body: 'All data synced successfully',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.sync,
      read: false,
    ),
    NotificationItem(
      id: '3',
      title: 'Weekly Summary',
      body: 'Your weekly health report is ready',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.summary,
      read: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    AnalyticsService().trackScreenView('notifications');
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(read: true);
      }
    });
  }

  void _dismiss(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Notifications'),
            if (_notifications.where((n) => !n.read).isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: themeManager.currentTheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_notifications.where((n) => !n.read).length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
      body: SafeArea(
        child: _notifications.isEmpty
            ? _EmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(StyleTokens.spacing4),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: StyleTokens.spacing3),
                    child: _NotificationTile(
                      notification: notification,
                      onTap: () => _markAsRead(notification.id),
                      onDismiss: () => _dismiss(notification.id),
                    ),
                  );
                },
              ),
      ),
      // Bottom Navigation - matching Dashboard
      bottomNavigationBar: _buildBottomNav(context, themeManager, isDark),
    );
  }

  Widget _buildBottomNav(
      BuildContext context, ThemeManager themeManager, bool isDark) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          activeIcon: Icon(Icons.book),
          label: 'Journal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: 'AI Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services_outlined),
          activeIcon: Icon(Icons.medical_services),
          label: 'Care',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnread = !notification.read;

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GlassCard(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getColorForType(notification.type).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconForType(notification.type),
                color: _getColorForType(notification.type),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight:
                                isUnread ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: theme.textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTimestamp(notification.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.goal:
        return Colors.blue;
      case NotificationType.sync:
        return Colors.green;
      case NotificationType.summary:
        return Colors.purple;
      case NotificationType.reminder:
        return Colors.orange;
    }
  }

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.goal:
        return Icons.flag;
      case NotificationType.sync:
        return Icons.sync;
      case NotificationType.summary:
        return Icons.summarize;
      case NotificationType.reminder:
        return Icons.notifications;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "You're all caught up!",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final NotificationType type;
  final bool read;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    required this.read,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? timestamp,
    NotificationType? type,
    bool? read,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      read: read ?? this.read,
    );
  }
}

enum NotificationType {
  goal,
  sync,
  summary,
  reminder,
}
