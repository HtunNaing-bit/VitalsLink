import 'package:dartz/dartz.dart';
import '../entities/journal_entry.dart';
import '../../core/error/failures.dart';

/// Repository Interface for Journal Entries
abstract class JournalRepository {
  /// Create a new journal entry
  Future<Either<Failure, JournalEntry>> createEntry({
    required String userId,
    required String content,
    String? mood,
    double? moodScore,
    Map<String, dynamic>? metadata,
  });

  /// Get journal entries for a user
  Future<Either<Failure, List<JournalEntry>>> getEntries({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  });

  /// Get a specific journal entry
  Future<Either<Failure, JournalEntry?>> getEntry({
    required String id,
  });

  /// Update a journal entry
  Future<Either<Failure, JournalEntry>> updateEntry({
    required String id,
    String? content,
    String? mood,
    double? moodScore,
    Map<String, dynamic>? metadata,
  });

  /// Delete a journal entry
  Future<Either<Failure, void>> deleteEntry({
    required String id,
  });

  /// Get journal streak information
  Future<Either<Failure, JournalStreak>> getStreak({
    required String userId,
  });

  /// Generate AI summary for a journal entry
  Future<Either<Failure, String>> generateAISummary({
    required String entryId,
    Map<String, dynamic>? healthDataContext,
  });
}

