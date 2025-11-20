import 'package:flutter/material.dart';
import 'apple_glass_card.dart';
import '../core/theme/vitalslink_apple_theme.dart';

/// Insight Card Component
/// Displays AI-generated health insights with confidence scores and actions
class InsightCard extends StatelessWidget {
  final String title;
  final String description;
  final String? recommendation;
  final double confidence; // 0.0 to 1.0
  final List<String>? dataPoints;
  final VoidCallback? onTap;
  final VoidCallback? onAction;
  final String? actionLabel;

  const InsightCard({
    super.key,
    required this.title,
    required this.description,
    this.recommendation,
    this.confidence = 1.0,
    this.dataPoints,
    this.onTap,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppleGlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with confidence indicator
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: VitalsLinkAppleTheme.title2.copyWith(
                    color: isDark
                        ? VitalsLinkAppleTheme.textPrimaryDark
                        : VitalsLinkAppleTheme.textPrimary,
                  ),
                ),
              ),
              if (confidence < 1.0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: VitalsLinkAppleTheme.warning.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${(confidence * 100).toInt()}% confidence',
                    style: VitalsLinkAppleTheme.caption1.copyWith(
                      color: VitalsLinkAppleTheme.warning,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            description,
            style: VitalsLinkAppleTheme.body.copyWith(
              color: isDark
                  ? VitalsLinkAppleTheme.textSecondaryDark
                  : VitalsLinkAppleTheme.textSecondary,
            ),
          ),

          // Recommendation
          if (recommendation != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: VitalsLinkAppleTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: VitalsLinkAppleTheme.primaryBlue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      recommendation!,
                      style: VitalsLinkAppleTheme.subhead.copyWith(
                        color: VitalsLinkAppleTheme.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Data points used
          if (dataPoints != null && dataPoints!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Based on: ${dataPoints!.join(", ")}',
              style: VitalsLinkAppleTheme.caption1.copyWith(
                color: isDark
                    ? VitalsLinkAppleTheme.textTertiary
                    : VitalsLinkAppleTheme.textTertiary,
              ),
            ),
          ],

          // Action button
          if (onAction != null && actionLabel != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: VitalsLinkAppleTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(actionLabel!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
