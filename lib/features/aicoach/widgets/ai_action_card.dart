import 'package:flutter/material.dart';

import '../../../core/models/ai_message.dart';
import '../../../../src/ui/components/glass_card.dart';

class AIActionCard extends StatelessWidget {
  const AIActionCard({super.key, required this.action, required this.onTap});

  final AIAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(action.title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(action.description, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: onTap,
            icon: const Icon(Icons.play_circle_outline),
            label: Text(action.command),
          ),
        ],
      ),
    );
  }
}
