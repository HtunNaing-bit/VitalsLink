import 'package:dartz/dartz.dart';
import '../../domain/entities/ai_chat_message.dart';
import '../../domain/entities/health_data.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/repositories/ai_repository.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../datasources/remote/firebase_functions_datasource.dart';
import '../datasources/remote/firestore_datasource.dart';
import '../models/ai_chat_message_model.dart';

/// AI Repository Implementation
/// Uses Firebase Functions for AI processing and Firestore for chat history
class AIRepositoryImpl implements AIRepository {
  final FirebaseFunctionsDataSource _functionsDataSource;
  final FirestoreDataSource _firestoreDataSource;

  AIRepositoryImpl({
    required FirebaseFunctionsDataSource functionsDataSource,
    required FirestoreDataSource firestoreDataSource,
  })  : _functionsDataSource = functionsDataSource,
        _firestoreDataSource = firestoreDataSource;

  @override
  Future<Either<Failure, AIChatMessage>> chat({
    required String userId,
    required String message,
    List<AIChatMessage>? history,
    Map<String, dynamic>? context,
  }) async {
    try {
      // Prepare chat history for API
      final historyData = history?.map((msg) => {
            'role': msg.role,
            'content': msg.content,
            'timestamp': msg.timestamp.toIso8601String(),
          }).toList() ?? [];

      // Call Firebase Function for AI chat
      final result = await _functionsDataSource.chatWithAI(
        message: message,
        history: historyData as List<Map<String, dynamic>>,
      );

      // Create assistant message from response
      final assistantMessage = AIChatMessage(
        id: result['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
        role: 'assistant',
        content: result['content'] as String? ?? result['message'] as String? ?? '',
        timestamp: DateTime.now(),
        metadata: {
          'confidence': result['confidence'],
          'context': context,
        },
      );

      // Save conversation to Firestore
      await _saveConversation(userId, message, assistantMessage, history);

      return Right(assistantMessage);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to chat with AI: $e'));
    }
  }

  @override
  Future<Either<Failure, List<AIChatConversation>>> getChatHistory({
    required String userId,
    int? limit,
  }) async {
    try {
      final conversations = await _firestoreDataSource.query(
        collection: 'conversations',
        queryBuilder: (query) => query
            .where('userId', isEqualTo: userId)
            .orderBy('updatedAt', descending: true),
        limit: limit,
      );

      final result = conversations.map((data) {
        final messages = (data['messages'] as List<dynamic>?)
                ?.map((msg) => AIChatMessageModel.fromJson(msg as Map<String, dynamic>).toEntity())
                .toList() ??
            [];

        return AIChatConversation(
          id: data['id'] as String,
          userId: data['userId'] as String,
          messages: messages,
          createdAt: DateTime.parse(data['createdAt'] as String),
          updatedAt: data['updatedAt'] != null
              ? DateTime.parse(data['updatedAt'] as String)
              : null,
          context: data['context'] as Map<String, dynamic>?,
        );
      }).toList();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get chat history: $e'));
    }
  }

  @override
  Future<Either<Failure, AIChatConversation?>> getConversation({
    required String conversationId,
  }) async {
    try {
      final data = await _firestoreDataSource.read(
        collection: 'conversations',
        id: conversationId,
      );

      if (data == null) {
        return Right(null);
      }

      final messages = (data['messages'] as List<dynamic>?)
              ?.map((msg) => AIChatMessageModel.fromJson(msg as Map<String, dynamic>).toEntity())
              .toList() ??
          [];

      final conversation = AIChatConversation(
        id: data['id'] as String,
        userId: data['userId'] as String,
        messages: messages,
        createdAt: DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] != null
            ? DateTime.parse(data['updatedAt'] as String)
            : null,
        context: data['context'] as Map<String, dynamic>?,
      );

      return Right(conversation);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get conversation: $e'));
    }
  }

  @override
  Future<Either<Failure, AIInsight>> generateInsight({
    required String userId,
    required List<HealthData> healthData,
    required List<JournalEntry> journalEntries,
    DateTime? dateRange,
  }) async {
    try {
      // Prepare health data for API
      final healthDataMap = {
        'sleep': healthData
            .where((d) => d.type == HealthMetricType.sleepDuration)
            .map((d) => {'date': d.timestamp.toIso8601String(), 'value': d.value})
            .toList(),
        'steps': healthData
            .where((d) => d.type == HealthMetricType.stepCount)
            .map((d) => {'date': d.timestamp.toIso8601String(), 'value': d.value})
            .toList(),
        'heartRate': healthData
            .where((d) => d.type == HealthMetricType.heartRate)
            .map((d) => {'date': d.timestamp.toIso8601String(), 'value': d.value})
            .toList(),
        'mindfulness': healthData
            .where((d) => d.type == HealthMetricType.mindfulnessMinutes)
            .map((d) => {'date': d.timestamp.toIso8601String(), 'value': d.value})
            .toList(),
      };

      // Prepare journal entries for API
      final journalDataList = journalEntries.map((entry) => {
        'id': entry.id,
        'content': entry.content,
        'mood': entry.mood,
        'moodScore': entry.moodScore,
        'timestamp': entry.timestamp.toIso8601String(),
      }).toList();

      // Convert to map format expected by the function
      final journalData = {'entries': journalDataList};

      // Call Firebase Function for insight generation
      final result = await _functionsDataSource.generateInsights(
        healthData: healthDataMap,
        journalData: journalData,
      );

      final insight = AIInsight(
        id: result['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: result['title'] as String? ?? 'Health Insight',
        description: result['description'] as String? ?? result['snippet'] as String? ?? '',
        confidence: (result['confidence'] as num?)?.toDouble() ?? 0.0,
        correlatedHealthMetrics: (result['correlatedHealthMetrics'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        correlatedJournalEntries: (result['correlatedJournalEntries'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        recommendations: result['recommendations'] as Map<String, dynamic>?,
        generatedAt: DateTime.now(),
      );

      return Right(insight);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to generate insight: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteConversation({
    required String conversationId,
  }) async {
    try {
      await _firestoreDataSource.delete(
        collection: 'conversations',
        id: conversationId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to delete conversation: $e'));
    }
  }

  /// Save conversation to Firestore
  Future<void> _saveConversation(
    String userId,
    String userMessage,
    AIChatMessage assistantMessage,
    List<AIChatMessage>? existingHistory,
  ) async {
    final conversationId = DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now().toIso8601String();

    final userMsg = AIChatMessage(
      id: '${conversationId}_user',
      role: 'user',
      content: userMessage,
      timestamp: DateTime.now(),
    );

    final allMessages = [
      ...(existingHistory ?? []),
      userMsg,
      assistantMessage,
    ];

    await _firestoreDataSource.create(
      collection: 'conversations',
      id: conversationId,
      data: {
        'id': conversationId,
        'userId': userId,
        'messages': allMessages.map((msg) => {
              'id': msg.id,
              'role': msg.role,
              'content': msg.content,
              'timestamp': msg.timestamp.toIso8601String(),
              'metadata': msg.metadata,
            }).toList(),
        'createdAt': now,
        'updatedAt': now,
      },
    );
  }
}

