import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/gradients.dart';

/// AnimatedBottomNav - Bottom navigation with active state indicators
class AnimatedBottomNav extends StatelessWidget {
  const AnimatedBottomNav({
    super.key,
    required this.currentRoute,
  });

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: VitalsLinkColors.background800,
        border: Border(
          top: BorderSide(
            color: VitalsLinkColors.surface700,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.dashboard_outlined,
              activeIcon: Icons.dashboard,
              label: 'Dashboard',
              route: '/dashboard',
              currentRoute: currentRoute,
              onTap: () => context.go('/dashboard'),
            ),
            _NavItem(
              icon: Icons.auto_awesome_outlined,
              activeIcon: Icons.auto_awesome,
              label: 'AI Coach',
              route: '/ai-coach',
              currentRoute: currentRoute,
              onTap: () => context.go('/ai-coach'),
            ),
            _NavItem(
              icon: Icons.timeline_outlined,
              activeIcon: Icons.timeline,
              label: 'Timeline',
              route: '/timeline',
              currentRoute: currentRoute,
              onTap: () => context.go('/timeline'),
            ),
            _NavItem(
              icon: Icons.settings_outlined,
              activeIcon: Icons.settings,
              label: 'Settings',
              route: '/settings',
              currentRoute: currentRoute,
              onTap: () => context.go('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    required this.currentRoute,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final String currentRoute;
  final VoidCallback onTap;

  bool get isActive => currentRoute == route;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isActive ? VitalsLinkGradients.hero : null,
          color: isActive ? null : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? Colors.white : VitalsLinkColors.text300,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isActive ? Colors.white : VitalsLinkColors.text300,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
