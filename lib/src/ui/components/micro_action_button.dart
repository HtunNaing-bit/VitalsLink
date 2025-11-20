import 'package:flutter/material.dart';
import '../../utils/style_tokens.dart';

/// Micro Action Button Component
/// Small, tappable action buttons for quick interactions
class MicroActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isSelected;
  final bool isLoading;

  const MicroActionButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.isSelected = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveBackground = backgroundColor ??
        (isSelected
            ? themeManager.currentTheme.primary
            : (isDark ? Colors.white.withOpacity(0.1) : Colors.white));

    final effectiveForeground = foregroundColor ??
        (isSelected ? Colors.white : (isDark ? Colors.white : Colors.black));

    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleTokens.spacing3,
          vertical: StyleTokens.spacing2,
        ),
        decoration: BoxDecoration(
          color: effectiveBackground,
          borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
          border: isSelected
              ? null
              : Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  width: 0.5,
                ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(effectiveForeground),
                ),
              )
            else if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: effectiveForeground,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: effectiveForeground,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
