import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';

/// Onboarding Welcome Screen (Page 1 of 3)
class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: StyleTokens.spacing6),
              // Hero Section - Slightly reduced from original
              Center(
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: themeManager.currentTheme.accentGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.health_and_safety,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: StyleTokens.spacing5),
              // Title
              Text(
                'Welcome to VitalsLink',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: StyleTokens.spacing2),
              // Description
              Text(
                'Your AI-powered personal health OS that unifies all your health data to optimize well-being and prevent illness.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Features List - Original size but tighter spacing
              _buildFeature(
                context,
                icon: Icons.auto_awesome,
                title: 'AI Co-Pilot',
                description: 'Personalized health coaching and insights',
              ),
              const SizedBox(height: StyleTokens.spacing3),
              _buildFeature(
                context,
                icon: Icons.link,
                title: 'Universal Data Hub',
                description: 'Connect wearables, EMRs, labs, and genetics',
              ),
              const SizedBox(height: StyleTokens.spacing3),
              _buildFeature(
                context,
                icon: Icons.medical_services,
                title: 'Preventive Care',
                description: 'Proactive health plans and chronic care support',
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // OAuth Buttons
              ElevatedButton.icon(
                onPressed: () => context.go('/onboarding/connect'),
                icon: const Icon(Icons.apple),
                label: const Text('Continue with Apple'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: StyleTokens.spacing4),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusMedium),
                  ),
                ),
              ),
              const SizedBox(height: StyleTokens.spacing3),
              OutlinedButton.icon(
                onPressed: () => context.go('/onboarding/connect'),
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Continue with Google'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: StyleTokens.spacing4),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusMedium),
                  ),
                ),
              ),
              const SizedBox(height: StyleTokens.spacing4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(StyleTokens.spacing3),
            decoration: BoxDecoration(
              color: themeManager.currentTheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: themeManager.currentTheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: StyleTokens.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            StyleTokens.getTextSecondaryStatic(isDark: isDark),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
