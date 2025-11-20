import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/apple_glass_card.dart';
import '../../../core/theme/vitalslink_apple_theme.dart';

/// Subscription Management Screen
/// View plans, upgrade, manage subscription
class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  String _selectedPlan = 'monthly'; // monthly, yearly

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? VitalsLinkAppleTheme.backgroundDark
          : VitalsLinkAppleTheme.backgroundGray,
      appBar: AppBar(
        title: const Text('Subscription'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Plan
              AppleGlassCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Plan',
                      style: VitalsLinkAppleTheme.title3.copyWith(
                        color: VitalsLinkAppleTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Free',
                      style: VitalsLinkAppleTheme.displayMedium.copyWith(
                        color: isDark
                            ? VitalsLinkAppleTheme.textPrimaryDark
                            : VitalsLinkAppleTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Basic health tracking and limited AI insights',
                      style: VitalsLinkAppleTheme.bodySmall.copyWith(
                        color: VitalsLinkAppleTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Plan Selection
              Text(
                'Upgrade to Premium',
                style: VitalsLinkAppleTheme.title1.copyWith(
                  color: isDark
                      ? VitalsLinkAppleTheme.textPrimaryDark
                      : VitalsLinkAppleTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Monthly vs Yearly
              Row(
                children: [
                  Expanded(
                    child: _PlanToggle(
                      label: 'Monthly',
                      isSelected: _selectedPlan == 'monthly',
                      onTap: () => setState(() => _selectedPlan = 'monthly'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _PlanToggle(
                      label: 'Yearly',
                      isSelected: _selectedPlan == 'yearly',
                      onTap: () => setState(() => _selectedPlan = 'yearly'),
                      badge: 'Save 17%',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Premium Features
              _PremiumFeatures(),
              const SizedBox(height: 24),

              // Pricing
              AppleGlassCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedPlan == 'monthly'
                              ? '\$9.99/month'
                              : '\$99/year',
                          style: VitalsLinkAppleTheme.displayMedium.copyWith(
                            color: VitalsLinkAppleTheme.primaryBlue,
                          ),
                        ),
                        if (_selectedPlan == 'yearly')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: VitalsLinkAppleTheme.success.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Save \$20/year',
                              style: VitalsLinkAppleTheme.caption1.copyWith(
                                color: VitalsLinkAppleTheme.success,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Process payment
                          _showPaymentSheet();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: VitalsLinkAppleTheme.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Start 7-Day Free Trial'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cancel anytime. No commitment.',
                      style: VitalsLinkAppleTheme.caption1.copyWith(
                        color: VitalsLinkAppleTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PaymentSheet(),
    );
  }
}

class _PlanToggle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  const _PlanToggle({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return AppleGlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      backgroundColor:
          isSelected ? VitalsLinkAppleTheme.primaryBlue.withOpacity(0.2) : null,
      child: Column(
        children: [
          Text(
            label,
            style: VitalsLinkAppleTheme.title3.copyWith(
              color: isSelected
                  ? VitalsLinkAppleTheme.primaryBlue
                  : (Theme.of(context).brightness == Brightness.dark
                      ? VitalsLinkAppleTheme.textPrimaryDark
                      : VitalsLinkAppleTheme.textPrimary),
            ),
          ),
          if (badge != null) ...[
            const SizedBox(height: 4),
            Text(
              badge!,
              style: VitalsLinkAppleTheme.caption1.copyWith(
                color: VitalsLinkAppleTheme.success,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PremiumFeatures extends StatelessWidget {
  final List<Map<String, String>> features = [
    {
      'icon': '🤖',
      'title': 'Unlimited AI Insights',
      'desc': 'Daily personalized health recommendations'
    },
    {
      'icon': '💬',
      'title': 'Ask VitalsLink Chat',
      'desc': '24/7 AI health coaching'
    },
    {
      'icon': '📊',
      'title': 'Advanced Analytics',
      'desc': 'Detailed health trends and patterns'
    },
    {
      'icon': '🎯',
      'title': 'Goal Tracking',
      'desc': 'Unlimited goals with progress tracking'
    },
    {
      'icon': '📱',
      'title': 'Priority Support',
      'desc': 'Faster response times'
    },
    {
      'icon': '🔒',
      'title': 'Enhanced Privacy',
      'desc': 'Advanced encryption and controls'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppleGlassCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  feature['icon']!,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title']!,
                        style: VitalsLinkAppleTheme.title3.copyWith(
                          color: isDark
                              ? VitalsLinkAppleTheme.textPrimaryDark
                              : VitalsLinkAppleTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        feature['desc']!,
                        style: VitalsLinkAppleTheme.bodySmall.copyWith(
                          color: VitalsLinkAppleTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PaymentSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? VitalsLinkAppleTheme.backgroundDarkSecondary
            : VitalsLinkAppleTheme.backgroundWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Payment',
            style: VitalsLinkAppleTheme.title1,
          ),
          const SizedBox(height: 24),
          Text(
            'TODO: Integrate Stripe or in-app purchase',
            style: VitalsLinkAppleTheme.body.copyWith(
              color: VitalsLinkAppleTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: VitalsLinkAppleTheme.primaryBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
