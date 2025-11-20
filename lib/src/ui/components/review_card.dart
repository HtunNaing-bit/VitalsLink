import 'package:flutter/material.dart';
import '../../utils/style_tokens.dart';
import 'glass_card.dart';

/// Review Card Component (Star + Text Feedback UI)
class ReviewCard extends StatelessWidget {
  final int rating;
  final String? reviewText;
  final String? reviewerName;
  final DateTime? timestamp;
  final bool isEditable;
  final Function(int)? onRatingChanged;
  final Function(String)? onReviewChanged;
  final Function()? onSubmit;

  const ReviewCard({
    super.key,
    this.rating = 0,
    this.reviewText,
    this.reviewerName,
    this.timestamp,
    this.isEditable = false,
    this.onRatingChanged,
    this.onReviewChanged,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              if (reviewerName != null) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor:
                      themeManager.currentTheme.primary.withOpacity(0.1),
                  child: Text(
                    reviewerName!.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: themeManager.currentTheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: StyleTokens.spacing3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewerName!,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      if (timestamp != null)
                        Text(
                          _formatTimestamp(timestamp!),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: StyleTokens.getTextSecondaryStatic(
                                        isDark: isDark),
                                  ),
                        ),
                    ],
                  ),
                ),
              ] else
                Expanded(
                  child: Text(
                    'Your Review',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: StyleTokens.spacing3),
          // Star Rating
          _buildStarRating(context, themeManager),
          const SizedBox(height: StyleTokens.spacing3),
          // Review Text
          if (isEditable)
            TextField(
              onChanged: onReviewChanged,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Share your thoughts...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
                ),
                filled: true,
                fillColor: isDark
                    ? const Color(0xFF1C1C1E)
                    : Colors.white.withOpacity(0.5),
              ),
            )
          else if (reviewText != null && reviewText!.isNotEmpty)
            Text(
              reviewText!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          // Emoji Feedback (if editable)
          if (isEditable) ...[
            const SizedBox(height: StyleTokens.spacing3),
            _buildEmojiFeedback(context, themeManager),
          ],
          // Submit Button (if editable)
          if (isEditable && onSubmit != null) ...[
            const SizedBox(height: StyleTokens.spacing4),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: rating > 0 ? onSubmit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeManager.currentTheme.primary,
                  foregroundColor: themeManager.currentTheme.accentContrast,
                  padding: const EdgeInsets.symmetric(
                      vertical: StyleTokens.spacing3),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusMedium),
                  ),
                ),
                child: const Text(
                  'Submit Review',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStarRating(BuildContext context, ThemeManager themeManager) {
    return Row(
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isSelected = starIndex <= rating;

        return GestureDetector(
          onTap: isEditable && onRatingChanged != null
              ? () => onRatingChanged!(starIndex)
              : null,
          child: Icon(
            isSelected ? Icons.star : Icons.star_border,
            color: isSelected
                ? themeManager.currentTheme.primary
                : StyleTokens.getTextSecondaryStatic(
                    isDark: Theme.of(context).brightness == Brightness.dark,
                  ),
            size: 32,
          ),
        );
      }),
    );
  }

  Widget _buildEmojiFeedback(BuildContext context, ThemeManager themeManager) {
    final emojis = ['😊', '👍', '❤️', '🎉', '💯'];
    final labels = ['Happy', 'Good', 'Love', 'Great', 'Perfect'];

    return Wrap(
      spacing: StyleTokens.spacing3,
      runSpacing: StyleTokens.spacing2,
      children: List.generate(emojis.length, (index) {
        return GestureDetector(
          onTap: () {
            // Add emoji to review text
            if (onReviewChanged != null) {
              final currentText = reviewText ?? '';
              onReviewChanged!('$currentText ${emojis[index]}');
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: StyleTokens.spacing3,
              vertical: StyleTokens.spacing2,
            ),
            decoration: BoxDecoration(
              color: themeManager.currentTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
              border: Border.all(
                color: themeManager.currentTheme.primary.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emojis[index], style: const TextStyle(fontSize: 20)),
                const SizedBox(width: StyleTokens.spacing1),
                Text(
                  labels[index],
                  style: TextStyle(
                    fontSize: 12,
                    color: themeManager.currentTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
