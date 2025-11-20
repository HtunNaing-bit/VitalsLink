import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/utils/motion_utils.dart';

/// Professional bottom navigation bar with animations
class ProBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<NavItem> items;

  const ProBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shouldReduce = MotionUtils.shouldReduceMotion(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: _NavItemWidget(
                    item: item,
                    isSelected: isSelected,
                    animate: !shouldReduce,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ).animate().slideY(
          begin: 0.1,
          end: 0,
          duration: MotionUtils.getDuration(context, MotionTokens.medium),
          curve: MotionUtils.getCurve(context, MotionTokens.standardCurve),
        );
  }
}

class _NavItemWidget extends StatelessWidget {
  final NavItem item;
  final bool isSelected;
  final bool animate;

  const _NavItemWidget({
    required this.item,
    required this.isSelected,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withOpacity(0.6);

    Widget icon = Icon(
      item.icon,
      color: color,
      size: 24,
    );

    if (animate && isSelected) {
      icon = icon
          .animate(
            onPlay: (controller) => controller.repeat(),
          )
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.1, 1.1),
            duration: MotionTokens.small,
            curve: Curves.easeInOut,
          );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 4),
        Text(
          item.label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

/// Navigation item model
class NavItem {
  final IconData icon;
  final String label;
  final String route;

  const NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
