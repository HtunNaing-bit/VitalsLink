import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Routes handled by app_router.dart

class NavItem {
  const NavItem(this.icon, this.label, this.route);

  final IconData icon;
  final String label;
  final String route;
}

const _items = [
  NavItem(Icons.dashboard_outlined, 'Dashboard', '/dashboard'),
  NavItem(Icons.hub_outlined, 'Data Hub', '/datahub'),
  NavItem(Icons.bolt_outlined, 'AI Coach', '/coach'),
  NavItem(Icons.timeline_outlined, 'Timeline', '/timeline'),
  NavItem(Icons.settings_outlined, 'Settings', '/settings'),
];

class HybridScaffold extends StatelessWidget {
  const HybridScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.route,
    required this.body,
    this.actions,
    this.fab,
  });

  final String title;
  final String? subtitle;
  final String route;
  final Widget body;
  final List<Widget>? actions;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1000;
        final navRail = NavigationRail(
          selectedIndex: _items.indexWhere((item) => item.route == route),
          labelType: isWide
              ? NavigationRailLabelType.all
              : NavigationRailLabelType.selected,
          onDestinationSelected: (index) {
            final target = _items[index].route;
            if (target != route) context.go(target);
          },
          destinations: _items
              .map(
                (item) => NavigationRailDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(
                    item.icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: Text(item.label),
                ),
              )
              .toList(),
        );

        final topBar = _TopGlassBar(
          title: title,
          subtitle: subtitle,
          actions: actions,
        );

        if (isWide) {
          return Scaffold(
            floatingActionButton: fab,
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navRail,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        topBar,
                        const SizedBox(height: 24),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: body,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
              ],
            ),
            actions: actions,
          ),
          floatingActionButton: fab,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _items.indexWhere((item) => item.route == route),
            onDestinationSelected: (index) {
              final target = _items[index].route;
              if (target != route) context.go(target);
            },
            destinations: _items
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(item.icon),
                    label: item.label,
                  ),
                )
                .toList(),
          ),
          body: SafeArea(child: body),
        );
      },
    );
  }
}

class _TopGlassBar extends StatelessWidget {
  const _TopGlassBar({required this.title, this.subtitle, this.actions});

  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withAlpha((0.85 * 255).round()),
                theme.colorScheme.secondary.withAlpha((0.75 * 255).round()),
              ],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          subtitle!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }
}
