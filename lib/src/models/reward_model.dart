/// Reward Model for Insurance Verification & Rewards
class Reward {
  final String id;
  final String title;
  final String description;
  final String value;
  final RewardStatus status;
  final String goalId;

  Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.value,
    required this.status,
    required this.goalId,
  });
}

enum RewardStatus {
  available,
  pending,
  completed,
  expired,
}
