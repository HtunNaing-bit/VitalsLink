import 'package:flutter/material.dart';

import '../../../core/models/health.dart';
import '../../../../src/ui/components/glass_card.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.metric});

  final HealthMetric metric;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 220,
      child: Hero(
        tag: metric.id,
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metric.label.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                metric.value,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 32),
              ),
              if (metric.delta != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    metric.delta!,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              if (metric.insight != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    metric.insight!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
