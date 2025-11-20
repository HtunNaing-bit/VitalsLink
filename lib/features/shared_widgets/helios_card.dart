import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

/// VitalsLinkCard - Modular card component with glassmorphic design
/// Supports expand animation and skeleton state
class VitalsLinkCard extends StatelessWidget {
  const VitalsLinkCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.isExpanded = false,
    this.showSkeleton = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool isExpanded;
  final bool showSkeleton;

  @override
  Widget build(BuildContext context) {
    if (showSkeleton) {
      return _SkeletonCard(margin: margin);
    }

    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: VitalsLinkColors.background800.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: VitalsLinkColors.surface700,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({this.margin});

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: VitalsLinkColors.background800.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: VitalsLinkColors.surface700,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 16,
            decoration: BoxDecoration(
              color: VitalsLinkColors.surface700,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: VitalsLinkColors.surface700,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
