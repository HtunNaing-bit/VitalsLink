import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/gradients.dart';
import '../../shared_widgets/vitalslink_card.dart';

/// Streaks & Badges Card - Shows user achievements and streaks
class StreaksCard extends StatelessWidget {
  const StreaksCard({
    super.key,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.badges = const [],
  });

  final int currentStreak;
  final int longestStreak;
  final List<String> badges;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VitalsLinkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: VitalsLinkGradients.sunset,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Streaks & Badges',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: VitalsLinkColors.text100,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Current streak
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StreakItem(
                label: 'Current',
                value: currentStreak,
                icon: Icons.whatshot,
                color: VitalsLinkColors.accent600,
              ),
              _StreakItem(
                label: 'Longest',
                value: longestStreak,
                icon: Icons.star,
                color: VitalsLinkColors.accent400,
              ),
            ],
          ),
          // Badges
          if (badges.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Badges',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: VitalsLinkColors.text300,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: badges
                  .map(
                    (badge) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: VitalsLinkColors.surface700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            color: VitalsLinkColors.accent400,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            badge,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: VitalsLinkColors.text100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ] else ...[
            const SizedBox(height: 24),
            Text(
              'Complete goals to earn badges!',
              style: theme.textTheme.bodySmall?.copyWith(
                color: VitalsLinkColors.text500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _StreakItem extends StatelessWidget {
  const _StreakItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final int value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          '$value',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: VitalsLinkColors.text300,
          ),
        ),
      ],
    );
  }
}
