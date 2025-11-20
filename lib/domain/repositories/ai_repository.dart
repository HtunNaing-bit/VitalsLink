import 'package:dartz/dartz.dart';
import '../entities/ai_chat_message.dart';
import '../entities/health_data.dart';
import '../entities/journal_entry.dart';
import '../../core/error/failures.dart';

/// Repository Interface for AI Services
abstract class AIRepository {
  /// Chat with AI (with conversation history)
  Future<Either<Failure, AIChatMessage>> chat({
    required String userId,
    required String message,
    List<AIChatMessage>? history,
    Map<String, dynamic>? context, // Health data, journal entries
  });

  /// Get chat history for a user
  Future<Either<Failure, List<AIChatConversation>>> getChatHistory({
    required String userId,
    int? limit,
  });

  /// Get a specific conversation
  Future<Either<Failure, AIChatConversation?>> getConversation({
    required String conversationId,
  });

  /// Generate AI insight correlating health data with journal entries
  Future<Either<Failure, AIInsight>> generateInsight({
    required String userId,
    required List<HealthData> healthData,
    required List<JournalEntry> journalEntries,
    DateTime? dateRange,
  });

  /// Delete a conversation
  Future<Either<Failure, void>> deleteConversation({
    required String conversationId,
  });
}

