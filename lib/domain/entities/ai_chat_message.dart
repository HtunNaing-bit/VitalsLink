/// Domain Entity: AI Chat Message
/// Represents a single message in an AI conversation
class AIChatMessage {
  final String id;
  final String role; // 'user' or 'assistant'
  final String content;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  const AIChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.metadata,
  });

  bool get isUser => role == 'user';
  bool get isAssistant => role == 'assistant';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIChatMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          role == other.role &&
          timestamp == other.timestamp;

  @override
  int get hashCode => id.hashCode ^ role.hashCode ^ timestamp.hashCode;
}

/// AI Chat Conversation
class AIChatConversation {
  final String id;
  final String userId;
  final List<AIChatMessage> messages;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? context; // Health data, journal entries, etc.

  const AIChatConversation({
    required this.id,
    required this.userId,
    required this.messages,
    required this.createdAt,
    this.updatedAt,
    this.context,
  });

  AIChatConversation copyWith({
    String? id,
    String? userId,
    List<AIChatMessage>? messages,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? context,
  }) {
    return AIChatConversation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      messages: messages ?? this.messages,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      context: context ?? this.context,
    );
  }
}

/// AI Insight with Health Data Correlation
class AIInsight {
  final String id;
  final String title;
  final String description;
  final double confidence; // 0.0 to 1.0
  final List<String> correlatedHealthMetrics;
  final List<String> correlatedJournalEntries;
  final Map<String, dynamic>? recommendations;
  final DateTime generatedAt;

  const AIInsight({
    required this.id,
    required this.title,
    required this.description,
    required this.confidence,
    this.correlatedHealthMetrics = const [],
    this.correlatedJournalEntries = const [],
    this.recommendations,
    required this.generatedAt,
  });
}

