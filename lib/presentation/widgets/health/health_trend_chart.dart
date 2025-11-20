import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../domain/entities/health_data.dart';
import '../../providers/health_data_provider.dart';

/// Health Trend Chart Widget
/// Displays a 7-day trend chart for a health metric
class HealthTrendChart extends ConsumerWidget {
  final HealthMetricType type;
  final Color color;
  final String label;

  const HealthTrendChart({
    super.key,
    required this.type,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(healthDataSummaryProvider(type));

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
            Text(
              label,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            summaryAsync.when(
              data: (summary) {
                if (summary.dataPoints.isEmpty) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'No data available',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        _buildChartData(summary.dataPoints, color),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          context,
                          'Avg',
                          _formatValue(summary.average ?? 0, type),
                        ),
                        _buildStatItem(
                          context,
                          'Min',
                          _formatValue(summary.min ?? 0, type),
                        ),
                        _buildStatItem(
                          context,
                          'Max',
                          _formatValue(summary.max ?? 0, type),
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'Error loading data',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _buildChartData(List<HealthDataPoint> dataPoints, Color color) {
    // Sort by date
    final sortedPoints = List<HealthDataPoint>.from(dataPoints)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Create spots for the chart
    final spots = sortedPoints.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.value);
    }).toList();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: _calculateInterval(sortedPoints),
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= sortedPoints.length) {
                return const Text('');
              }
              final point = sortedPoints[value.toInt()];
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _formatDate(point.date),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      minX: 0,
      maxX: (sortedPoints.length - 1).toDouble(),
      minY: 0,
      maxY: _calculateMaxY(sortedPoints),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: color,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            color: color.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  double _calculateInterval(List<HealthDataPoint> points) {
    if (points.isEmpty) return 1;
    final max = points.map((p) => p.value).reduce((a, b) => a > b ? a : b);
    return max / 4;
  }

  double _calculateMaxY(List<HealthDataPoint> points) {
    if (points.isEmpty) return 100;
    final max = points.map((p) => p.value).reduce((a, b) => a > b ? a : b);
    return max * 1.2; // Add 20% padding
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  String _formatValue(double value, HealthMetricType type) {
    switch (type) {
      case HealthMetricType.sleepDuration:
        return '${value.toStringAsFixed(1)}h';
      case HealthMetricType.stepCount:
        return value.toStringAsFixed(0);
      case HealthMetricType.heartRate:
        return '${value.toStringAsFixed(0)} bpm';
      case HealthMetricType.mindfulnessMinutes:
        return '${value.toStringAsFixed(0)}m';
    }
  }

  String _formatDate(DateTime date) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }
}

