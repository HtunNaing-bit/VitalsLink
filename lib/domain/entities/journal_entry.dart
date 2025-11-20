/// Domain Entity: Journal Entry
/// Pure Dart class representing a journal entry in the domain layer
class JournalEntry {
  final String id;
  final String userId;
  final String content;
  final DateTime timestamp;
  final String? mood;
  final double? moodScore; // 0.0 to 1.0
  final Map<String, dynamic>? metadata;
  final String? aiSummary;
  final DateTime? aiSummaryGeneratedAt;

  const JournalEntry({
    required this.id,
    required this.userId,
    required this.content,
    required this.timestamp,
    this.mood,
    this.moodScore,
    this.metadata,
    this.aiSummary,
    this.aiSummaryGeneratedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalEntry &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          timestamp == other.timestamp;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ timestamp.hashCode;
}

/// Journal Streak Information
class JournalStreak {
  final int currentStreak; // Days in a row
  final int longestStreak; // Best streak ever
  final DateTime? lastEntryDate;
  final bool isActive; // Streak is still active today

  const JournalStreak({
    required this.currentStreak,
    required this.longestStreak,
    this.lastEntryDate,
    required this.isActive,
  });
}

