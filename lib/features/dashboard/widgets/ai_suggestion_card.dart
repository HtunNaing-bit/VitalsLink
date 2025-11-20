import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/gradients.dart';
import '../../shared_widgets/vitalslink_card.dart';
import '../../shared_widgets/primary_button.dart';

/// AI Suggestions Card - Shows AI insights with one-tap to convert to goal
class AISuggestionCard extends StatelessWidget {
  const AISuggestionCard({
    super.key,
    required this.title,
    required this.description,
    this.dataPoints = const [],
    this.confidence,
    this.onSaveAsGoal,
  });

  final String title;
  final String description;
  final List<String> dataPoints;
  final double? confidence;
  final VoidCallback? onSaveAsGoal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VitalsLinkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with AI icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: VitalsLinkGradients.hero,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'AI Suggestion',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: VitalsLinkColors.text100,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (confidence != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: VitalsLinkColors.surface700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${(confidence! * 100).toInt()}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: VitalsLinkColors.accent400,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: VitalsLinkColors.text100,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: VitalsLinkColors.text300,
            ),
          ),
          // Data points
          if (dataPoints.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: dataPoints
                  .map(
                    (point) => Chip(
                      label: Text(point),
                      backgroundColor: VitalsLinkColors.surface700,
                      labelStyle: theme.textTheme.bodySmall?.copyWith(
                        color: VitalsLinkColors.text300,
                      ),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 16),
          // Actions
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Save as Goal',
                  icon: Icons.add_task,
                  onPressed: onSaveAsGoal ?? () {},
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.flag_outlined),
                onPressed: () {
                  // Flag for clinician review
                },
                color: VitalsLinkColors.text300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
