import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/health_data.dart';
import '../../providers/health_data_provider.dart';

/// Health Metric Card Widget
/// Displays a single health metric with latest value and trend
class HealthMetricCard extends ConsumerWidget {
  final HealthMetricType type;
  final IconData icon;
  final Color color;
  final String label;

  const HealthMetricCard({
    super.key,
    required this.type,
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestDataAsync = ref.watch(latestHealthDataProvider(type));

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            latestDataAsync.when(
              data: (data) {
                if (data == null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No data',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enable permissions to track',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatValue(data.value, type),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                        ),
                        if (data.unit != null) ...[
                          const SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              data.unit!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTimestamp(data.timestamp),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(
                height: 40,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Error',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red[300],
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

  String _formatValue(double value, HealthMetricType type) {
    switch (type) {
      case HealthMetricType.sleepDuration:
        return '${value.toStringAsFixed(1)}';
      case HealthMetricType.stepCount:
        return value.toStringAsFixed(0);
      case HealthMetricType.heartRate:
        return value.toStringAsFixed(0);
      case HealthMetricType.mindfulnessMinutes:
        return value.toStringAsFixed(0);
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

