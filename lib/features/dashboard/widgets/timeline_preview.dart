import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/health.dart';
import '../../../core/utils/formatters.dart';
import '../../../../src/ui/components/glass_card.dart';
// Timeline route: /timeline

class TimelinePreview extends StatelessWidget {
  const TimelinePreview({super.key, required this.events});

  final List<TimelineEvent> events;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preview = events.take(4).toList();
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Timeline', style: theme.textTheme.titleMedium),
              TextButton.icon(
                onPressed: () => context.go('/timeline'),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open timeline'),
              ),
            ],
          ),
          const Divider(height: 24),
          ...preview.map(
            (event) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(child: Text(event.icon ?? '•')),
              title: Text(event.title),
              subtitle: Text(event.description),
              trailing: Text(formatTime(event.timestamp)),
            ),
          ),
        ],
      ),
    );
  }
}
