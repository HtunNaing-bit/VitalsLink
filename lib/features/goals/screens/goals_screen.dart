import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../core/utils/motion_utils.dart';
import '../../../../widgets/animated_gradient_bg.dart';
import '../../../../src/ui/components/glass_card.dart';
import '../../../../widgets/motion_button.dart';
import '../../../../widgets/progress_ring.dart';
import '../../../../widgets/pro_bottom_nav.dart';

/// Goals & Plans screen with gamification
class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  final ConfettiController _confettiController = ConfettiController();
  final List<Goal> _goals = [
    Goal(
      id: '1',
      title: 'Sleep Better',
      description: 'Get 7-8 hours of sleep',
      progress: 0.75,
      target: 30,
      current: 22,
      unit: 'days',
      streak: 5,
      badge: 'Early Bird',
    ),
    Goal(
      id: '2',
      title: 'Run 5K',
      description: 'Run 5 kilometers',
      progress: 0.6,
      target: 10,
      current: 6,
      unit: 'runs',
      streak: 3,
      badge: 'Runner',
    ),
    Goal(
      id: '3',
      title: 'Lower Resting HR',
      description: 'Reduce resting heart rate',
      progress: 0.4,
      target: 60,
      current: 72,
      unit: 'bpm',
      streak: 0,
      badge: null,
    ),
  ];

  @override
  void initState() {
    super.initState();
    AnalyticsService().trackScreenView('goals');
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _celebrateGoal(Goal goal) {
    _confettiController.play();
    AnalyticsService().trackGoalComplete(goal.id, goal.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  // Header
                  _GoalsHeader(onAddGoal: () {
                    // TODO: Show add goal dialog
                  }),

                  // Content
                  Expanded(
                    child: _goals.isEmpty
                        ? _EmptyState()
                        : SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Active goals
                                Text(
                                  'Active Goals',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ).animate().fadeIn(
                                      duration: MotionUtils.getDuration(
                                        context,
                                        MotionTokens.medium,
                                      ),
                                    ),
                                const SizedBox(height: 16),
                                ..._goals.map((goal) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: _GoalCard(
                                      goal: goal,
                                      onComplete: () => _celebrateGoal(goal),
                                    ),
                                  );
                                }),

                                // Badges section
                                const SizedBox(height: 32),
                                Text(
                                  'Badges',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const SizedBox(height: 16),
                                const _BadgesGrid(badges: [
                                  'Early Bird',
                                  'Runner',
                                  'Consistent Sleeper',
                                  'Heart Hero',
                                ]),
                              ],
                            ),
                          ),
                  ),

                  // Bottom navigation
                  ProBottomNav(
                    currentIndex: 0,
                    onTap: (index) {
                      switch (index) {
                        case 0:
                          context.go('/dashboard');
                          break;
                        case 1:
                          context.go('/coach');
                          break;
                        case 2:
                          context.go('/insights');
                          break;
                        case 3:
                          context.go('/profile');
                          break;
                      }
                    },
                    items: const [
                      NavItem(
                          icon: Icons.dashboard,
                          label: 'Dashboard',
                          route: '/dashboard'),
                      NavItem(
                          icon: Icons.chat_bubble,
                          label: 'Coach',
                          route: '/coach'),
                      NavItem(
                          icon: Icons.insights,
                          label: 'Insights',
                          route: '/insights'),
                      NavItem(
                          icon: Icons.person,
                          label: 'Profile',
                          route: '/profile'),
                    ],
                  ),
                ],
              ),
            ),

            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: 3.14 / 2,
                maxBlastForce: 5,
                minBlastForce: 2,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalsHeader extends StatelessWidget {
  final VoidCallback onAddGoal;

  const _GoalsHeader({required this.onAddGoal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Goals',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddGoal,
            tooltip: 'Add goal',
          ),
        ],
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final Goal goal;
  final VoidCallback onComplete;

  const _GoalCard({
    required this.goal,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isComplete = goal.progress >= 1.0;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      goal.description,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              ProgressRing(
                progress: goal.progress,
                size: 60,
                showPercentage: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: goal.progress,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${goal.current} / ${goal.target} ${goal.unit}',
                style: theme.textTheme.bodySmall,
              ),
              if (goal.streak > 0)
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${goal.streak} day streak',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (goal.badge != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.emoji_events,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    goal.badge!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (isComplete) ...[
            const SizedBox(height: 16),
            MotionButton(
              onPressed: onComplete,
              child: const Text('Celebrate!'),
            ),
          ],
        ],
      ),
    );
  }
}

class _BadgesGrid extends StatelessWidget {
  final List<String> badges;

  const _BadgesGrid({required this.badges});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: badges.map((badge) {
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                Icons.emoji_events,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                badge,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flag_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No goals yet',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first goal to get started',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          MotionButton(
            onPressed: () {
              // TODO: Show add goal dialog
            },
            child: const Text('Create Goal'),
          ),
        ],
      ),
    );
  }
}

class Goal {
  final String id;
  final String title;
  final String description;
  final double progress;
  final int target;
  final int current;
  final String unit;
  final int streak;
  final String? badge;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.current,
    required this.unit,
    required this.streak,
    this.badge,
  });
}
