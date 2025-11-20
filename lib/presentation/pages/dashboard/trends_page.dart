import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/health/health_trend_chart.dart';
import '../../../domain/entities/health_data.dart';

/// Trends Page
/// Displays 7-day trend charts for all health metrics
class TrendsPage extends ConsumerWidget {
  const TrendsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Trends'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '7-Day Trends',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track your health metrics over time',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 24),
              
              // Sleep Duration Trend
              HealthTrendChart(
                type: HealthMetricType.sleepDuration,
                color: Colors.blue,
                label: 'Sleep Duration',
              ),
              
              const SizedBox(height: 16),
              
              // Step Count Trend
              HealthTrendChart(
                type: HealthMetricType.stepCount,
                color: Colors.green,
                label: 'Step Count',
              ),
              
              const SizedBox(height: 16),
              
              // Heart Rate Trend
              HealthTrendChart(
                type: HealthMetricType.heartRate,
                color: Colors.red,
                label: 'Heart Rate',
              ),
              
              const SizedBox(height: 16),
              
              // Mindfulness Minutes Trend
              HealthTrendChart(
                type: HealthMetricType.mindfulnessMinutes,
                color: Colors.purple,
                label: 'Mindfulness Minutes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

