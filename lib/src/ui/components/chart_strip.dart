import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'glass_card.dart';
import '../../utils/style_tokens.dart';

/// Chart Strip Component
/// Displays health metrics in a horizontal scrollable chart
class ChartStrip extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<ChartDataPoint> dataPoints;
  final String unit;
  final Color? color;
  final VoidCallback? onTap;

  const ChartStrip({
    super.key,
    required this.title,
    this.subtitle,
    required this.dataPoints,
    required this.unit,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ?? themeManager.currentTheme.primary;

    if (dataPoints.isEmpty) {
      return GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.all(StyleTokens.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: StyleTokens.spacing2),
            Text(
              'No data available',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                  ),
            ),
          ],
        ),
      );
    }

    final maxValue =
        dataPoints.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minValue =
        dataPoints.map((e) => e.value).reduce((a, b) => a < b ? a : b);

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: StyleTokens.getTextSecondaryStatic(
                                  isDark: isDark),
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              // Current value
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${dataPoints.last.value.toStringAsFixed(1)}$unit',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: effectiveColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${dataPoints.length} points',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: StyleTokens.getTextSecondaryStatic(
                              isDark: isDark),
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: StyleTokens.spacing4),

          // Chart
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: dataPoints.asMap().entries.map((entry) {
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value.value,
                      );
                    }).toList(),
                    isCurved: true,
                    color: effectiveColor,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: effectiveColor.withOpacity(0.1),
                    ),
                  ),
                ],
                minY: minValue * 0.9,
                maxY: maxValue * 1.1,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(1)}$unit',
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Data point for charts
class ChartDataPoint {
  final double value;
  final DateTime timestamp;

  ChartDataPoint({
    required this.value,
    required this.timestamp,
  });
}
