import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../services/ai_service.dart';
import '../../utils/style_tokens.dart';
import 'glass_card.dart';

/// Insight Card Component (Daily Health Summaries)
class InsightCard extends StatelessWidget {
  final AIInsight insight;

  const InsightCard({
    super.key,
    required this.insight,
  });

  IconData _getSourceIcon(String source) {
    switch (source.toLowerCase()) {
      case 'journal':
        return Icons.book_outlined;
      case 'sleep':
        return Icons.bedtime_outlined;
      case 'activity':
        return Icons.directions_walk;
      case 'heart':
      case 'hrv':
        return Icons.favorite_outline;
      default:
        return Icons.data_usage;
    }
  }

  void _showDataLineageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DataLineageBottomSheet(insight: insight),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isCorrelative = insight.type == InsightType.correlative;

    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (isCorrelative)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: StyleTokens.spacing2,
                          vertical: StyleTokens.spacing1,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(StyleTokens.radiusSmall),
                        ),
                        child: Text(
                          l10n.correlative,
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (isCorrelative)
                      const SizedBox(width: StyleTokens.spacing2),
                    Expanded(
                      child: Text(
                        insight.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              // Info Icon for Correlative Insights
              if (isCorrelative)
                IconButton(
                  icon: Icon(
                    Icons.info_outline,
                    size: 20,
                    color: themeManager.currentTheme.primary,
                  ),
                  onPressed: () => _showDataLineageBottomSheet(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              // Confidence Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: StyleTokens.spacing3,
                  vertical: StyleTokens.spacing1,
                ),
                decoration: BoxDecoration(
                  color: themeManager.currentTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
                ),
                child: Text(
                  '${(insight.confidence * 100).toInt()}% ${l10n.confidence}',
                  style: TextStyle(
                    color: themeManager.currentTheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: StyleTokens.spacing3),
          // Sources Row (for correlative insights)
          if (isCorrelative && insight.sources.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.link,
                  size: 16,
                  color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                ),
                const SizedBox(width: StyleTokens.spacing2),
                ...insight.sources.map((source) {
                  return Padding(
                    padding: const EdgeInsets.only(right: StyleTokens.spacing3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getSourceIcon(source),
                          size: 16,
                          color: themeManager.currentTheme.primary,
                        ),
                        const SizedBox(width: StyleTokens.spacing1),
                        Text(
                          source.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: themeManager.currentTheme.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: StyleTokens.spacing3),
          ],
          // Description
          Text(
            insight.snippet,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                ),
          ),
          const SizedBox(height: StyleTokens.spacing4),
          // Recommendation Box
          Container(
            padding: const EdgeInsets.all(StyleTokens.spacing4),
            decoration: BoxDecoration(
              color: themeManager.currentTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: themeManager.currentTheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: StyleTokens.spacing2),
                    Text(
                      l10n.recommendation,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: themeManager.currentTheme.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: StyleTokens.spacing2),
                Text(
                  insight.recommendation.nextSteps,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: StyleTokens.spacing3),
          // Data Points
          Wrap(
            spacing: StyleTokens.spacing2,
            children: insight.dataPoints.map((point) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: StyleTokens.spacing2,
                  vertical: StyleTokens.spacing1,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1C1C1E)
                      : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
                ),
                child: Text(
                  point,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color:
                            StyleTokens.getTextSecondaryStatic(isDark: isDark),
                      ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Data Lineage Bottom Sheet
class _DataLineageBottomSheet extends StatelessWidget {
  final AIInsight insight;

  const _DataLineageBottomSheet({required this.insight});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(StyleTokens.radiusLarge),
        ),
      ),
      padding: const EdgeInsets.all(StyleTokens.spacing5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: StyleTokens.spacing4),
              decoration: BoxDecoration(
                color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Title
          Text(
            l10n.howThisInsightWasGenerated,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: StyleTokens.spacing4),
          // Explanation
          Text(
            l10n.yourDataIsProcessedLocally,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                ),
          ),
          const SizedBox(height: StyleTokens.spacing4),
          // Sources List
          if (insight.sources.isNotEmpty) ...[
            Text(
              l10n.dataSources,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: StyleTokens.spacing2),
            ...insight.sources.map((source) {
              return Padding(
                padding: const EdgeInsets.only(bottom: StyleTokens.spacing2),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: themeManager.currentTheme.primary,
                    ),
                    const SizedBox(width: StyleTokens.spacing2),
                    Text(
                      source.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }),
          ],
          const SizedBox(height: StyleTokens.spacing4),
          // Privacy Note
          Container(
            padding: const EdgeInsets.all(StyleTokens.spacing4),
            decoration: BoxDecoration(
              color: themeManager.currentTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: themeManager.currentTheme.primary,
                ),
                const SizedBox(width: StyleTokens.spacing3),
                Expanded(
                  child: Text(
                    l10n.yourDataIsProcessedLocally,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: themeManager.currentTheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: StyleTokens.spacing4),
          // Close Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeManager.currentTheme.primary,
                foregroundColor: themeManager.currentTheme.accentContrast,
                padding:
                    const EdgeInsets.symmetric(vertical: StyleTokens.spacing4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
                ),
              ),
              child: Text(l10n.gotIt),
            ),
          ),
        ],
      ),
    );
  }
}
