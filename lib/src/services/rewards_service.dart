import '../models/reward_model.dart';

/// Rewards Service for Insurance Verification & Rewards
class RewardsService {
  static final RewardsService _instance = RewardsService._internal();
  factory RewardsService() => _instance;
  RewardsService._internal();

  /// Get available rewards (Mock)
  Future<List<Reward>> getAvailableRewards() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Reward(
        id: 'reward_1',
        title: 'Free Month Premium',
        description: 'Complete 3 health goals this month',
        value: '\$29.99',
        status: RewardStatus.available,
        goalId: 'goal_1',
      ),
      Reward(
        id: 'reward_2',
        title: 'HSA Contribution',
        description: 'Lower HbA1c to <5.6',
        value: '\$100',
        status: RewardStatus.pending,
        goalId: 'goal_2',
      ),
      Reward(
        id: 'reward_3',
        title: 'Wellness Gift Card',
        description: 'Maintain 8 hours sleep for 30 days',
        value: '\$50',
        status: RewardStatus.available,
        goalId: 'goal_3',
      ),
      Reward(
        id: 'reward_4',
        title: 'Insurance Premium Discount',
        description: 'Complete annual health checkup',
        value: '10% off',
        status: RewardStatus.available,
        goalId: 'goal_4',
      ),
    ];
  }

  /// Verify goal completion (Mock)
  Future<bool> verifyGoalCompletion(String goalId) async {
    // Simulate verification delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock verification - return true for goal_2 (HSA Contribution)
    return goalId == 'goal_2';
  }
}
