import 'package:flutter/material.dart';

import '../../../core/models/health.dart';
import '../../../../src/ui/components/glass_card.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({super.key, required this.event});

  final TimelineEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GlassCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: theme.colorScheme.secondary.withAlpha(
                (0.18 * 255).round(),
              ),
              child: Text(
                event.icon ?? '•',
                style: theme.textTheme.titleMedium,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(event.description, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            Text(
              '${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}',
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
