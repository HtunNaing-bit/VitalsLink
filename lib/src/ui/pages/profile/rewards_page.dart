import 'package:flutter/material.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';
import '../../../services/rewards_service.dart';
import '../../../models/reward_model.dart';

/// Rewards Page for Insurance Verification & Rewards
class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  final RewardsService _rewardsService = RewardsService();
  List<Reward> _rewards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRewards();
  }

  Future<void> _loadRewards() async {
    try {
      final rewards = await _rewardsService.getAvailableRewards();
      setState(() {
        _rewards = rewards;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading rewards: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleRewardTap(Reward reward) async {
    if (reward.status == RewardStatus.pending) {
      // Navigate to goal completion confirmation
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => _GoalCompletionPage(reward: reward),
        ),
      );

      if (result == true) {
        // Reload rewards after completion
        _loadRewards();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Rewards & Insurance'),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _rewards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.card_giftcard_outlined,
                          size: 64,
                          color: StyleTokens.getTextSecondaryStatic(
                              isDark: isDark),
                        ),
                        const SizedBox(height: StyleTokens.spacing4),
                        Text(
                          'No rewards available',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: StyleTokens.getTextSecondaryStatic(
                                        isDark: isDark),
                                  ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(StyleTokens.spacing4),
                    itemCount: _rewards.length,
                    itemBuilder: (context, index) {
                      final reward = _rewards[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: StyleTokens.spacing3),
                        child: _RewardCard(
                          reward: reward,
                          themeManager: themeManager,
                          isDark: isDark,
                          onTap: () => _handleRewardTap(reward),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

/// Reward Card Widget
class _RewardCard extends StatelessWidget {
  final Reward reward;
  final ThemeManager themeManager;
  final bool isDark;
  final VoidCallback onTap;

  const _RewardCard({
    required this.reward,
    required this.themeManager,
    required this.isDark,
    required this.onTap,
  });

  Color _getStatusColor(RewardStatus status) {
    switch (status) {
      case RewardStatus.available:
        return Colors.green;
      case RewardStatus.pending:
        return Colors.orange;
      case RewardStatus.completed:
        return Colors.blue;
      case RewardStatus.expired:
        return Colors.grey;
    }
  }

  String _getStatusText(RewardStatus status) {
    switch (status) {
      case RewardStatus.available:
        return 'Available';
      case RewardStatus.pending:
        return 'Verify Goal';
      case RewardStatus.completed:
        return 'Completed';
      case RewardStatus.expired:
        return 'Expired';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(reward.status);
    final isClickable = reward.status == RewardStatus.pending;

    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      onTap: isClickable ? onTap : null,
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(StyleTokens.spacing3),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.card_giftcard,
              color: statusColor,
              size: 24,
            ),
          ),
          const SizedBox(width: StyleTokens.spacing3),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: StyleTokens.spacing1),
                Text(
                  reward.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            StyleTokens.getTextSecondaryStatic(isDark: isDark),
                      ),
                ),
              ],
            ),
          ),
          // Value and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                reward.value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeManager.currentTheme.primary,
                    ),
              ),
              const SizedBox(height: StyleTokens.spacing1),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: StyleTokens.spacing2,
                  vertical: StyleTokens.spacing1,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
                ),
                child: Text(
                  _getStatusText(reward.status),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Goal Completion Confirmation Page
class _GoalCompletionPage extends StatelessWidget {
  final Reward reward;

  const _GoalCompletionPage({required this.reward});

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Verification'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(StyleTokens.spacing5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Success Icon
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 60,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Goal Info
              GlassCard(
                padding: const EdgeInsets.all(StyleTokens.spacing5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Goal: ${reward.description}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: StyleTokens.spacing4),
                    Row(
                      children: [
                        const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: StyleTokens.spacing2),
                        Text(
                          'Status: Verification Complete',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: StyleTokens.spacing4),
                    const Divider(),
                    const SizedBox(height: StyleTokens.spacing4),
                    Text(
                      'Your ${reward.value} HSA contribution has been processed.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Close Button
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
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
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
