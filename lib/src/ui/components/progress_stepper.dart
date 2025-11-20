import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/style_tokens.dart';

/// Progress Stepper Component (tappable, shows x/5)
class ProgressStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Function(int)? onStepTapped;

  const ProgressStepper({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final stepNumber = index + 1;
        final isActive = stepNumber <= currentStep;
        final isCurrent = stepNumber == currentStep;

        return GestureDetector(
          onTap: onStepTapped != null
              ? () {
                  HapticFeedback.selectionClick();
                  onStepTapped!(stepNumber);
                }
              : null,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isCurrent ? 32 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? themeManager.currentTheme.primary
                  : themeManager.currentTheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
