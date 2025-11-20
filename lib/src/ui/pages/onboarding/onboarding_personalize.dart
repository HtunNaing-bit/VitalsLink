import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';

/// Onboarding Personalize Screen (Page 3 of 3)
class OnboardingPersonalizeScreen extends StatefulWidget {
  const OnboardingPersonalizeScreen({super.key});

  @override
  State<OnboardingPersonalizeScreen> createState() =>
      _OnboardingPersonalizeScreenState();
}

class _OnboardingPersonalizeScreenState
    extends State<OnboardingPersonalizeScreen> {
  final Set<String> _selectedGoals = {};

  final List<GoalOption> _goals = [
    GoalOption(
      id: 'sleep',
      title: 'Improve Sleep',
      icon: Icons.bedtime,
    ),
    GoalOption(
      id: 'activity',
      title: 'Stay Active',
      icon: Icons.directions_walk,
    ),
    GoalOption(
      id: 'nutrition',
      title: 'Eat Better',
      icon: Icons.restaurant,
    ),
    GoalOption(
      id: 'stress',
      title: 'Reduce Stress',
      icon: Icons.self_improvement,
    ),
    GoalOption(
      id: 'weight',
      title: 'Weight Management',
      icon: Icons.monitor_weight,
    ),
    GoalOption(
      id: 'heart',
      title: 'Heart Health',
      icon: Icons.favorite,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/connect'),
        ),
        title: const Text('Personalize Your Experience'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: StyleTokens.spacing4),
              // Header
              Text(
                'Select your health goals to get personalized insights',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Goals Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: StyleTokens.spacing3,
                  mainAxisSpacing: StyleTokens.spacing3,
                  childAspectRatio: 1.1,
                ),
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goal = _goals[index];
                  final isSelected = _selectedGoals.contains(goal.id);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedGoals.remove(goal.id);
                        } else {
                          _selectedGoals.add(goal.id);
                        }
                      });
                    },
                    child: GlassCard(
                      padding: const EdgeInsets.all(StyleTokens.spacing4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(StyleTokens.spacing3),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? themeManager.currentTheme.primary
                                  : themeManager.currentTheme.primary
                                      .withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              goal.icon,
                              color: isSelected
                                  ? themeManager.currentTheme.accentContrast
                                  : themeManager.currentTheme.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: StyleTokens.spacing3),
                          Text(
                            goal.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? themeManager.currentTheme.primary
                                      : null,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: StyleTokens.spacing8),
              // Get Started Button
              ElevatedButton(
                onPressed: _selectedGoals.isEmpty
                    ? null
                    : () => context.go('/dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeManager.currentTheme.primary,
                  foregroundColor: themeManager.currentTheme.accentContrast,
                  padding: const EdgeInsets.symmetric(
                      vertical: StyleTokens.spacing4),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusMedium),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoalOption {
  final String id;
  final String title;
  final IconData icon;

  GoalOption({
    required this.id,
    required this.title,
    required this.icon,
  });
}
