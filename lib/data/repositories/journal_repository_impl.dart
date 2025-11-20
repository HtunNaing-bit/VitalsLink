import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/journal_entry.dart';
import '../../domain/repositories/journal_repository.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../datasources/remote/firestore_datasource.dart';
import '../datasources/remote/firebase_functions_datasource.dart';

/// Journal Repository Implementation
/// Uses Firestore for persistence and Firebase Functions for AI summaries
class JournalRepositoryImpl implements JournalRepository {
  final FirestoreDataSource _firestoreDataSource;
  final FirebaseFunctionsDataSource _functionsDataSource;
  final _uuid = const Uuid();

  JournalRepositoryImpl({
    required FirestoreDataSource firestoreDataSource,
    required FirebaseFunctionsDataSource functionsDataSource,
  })  : _firestoreDataSource = firestoreDataSource,
        _functionsDataSource = functionsDataSource;

  @override
  Future<Either<Failure, JournalEntry>> createEntry({
    required String userId,
    required String content,
    String? mood,
    double? moodScore,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final entryId = _uuid.v4();
      final now = DateTime.now();

      final entry = JournalEntry(
        id: entryId,
        userId: userId,
        content: content,
        timestamp: now,
        mood: mood,
        moodScore: moodScore,
        metadata: metadata,
      );

      // Save to Firestore
      await _firestoreDataSource.create(
        collection: 'journal_entries',
        id: entryId,
        data: {
          'id': entryId,
          'userId': userId,
          'content': content,
          'timestamp': now.toIso8601String(),
          'mood': mood,
          'moodScore': moodScore,
          'metadata': metadata ?? {},
        },
      );

      return Right(entry);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to create journal entry: $e'));
    }
  }

  @override
  Future<Either<Failure, List<JournalEntry>>> getEntries({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    try {
      final entries = await _firestoreDataSource.query(
        collection: 'journal_entries',
        queryBuilder: (query) {
          var q = query.where('userId', isEqualTo: userId);
          if (startDate != null) {
            q = q.where('timestamp', isGreaterThanOrEqualTo: startDate.toIso8601String());
          }
          if (endDate != null) {
            q = q.where('timestamp', isLessThanOrEqualTo: endDate.toIso8601String());
          }
          return q.orderBy('timestamp', descending: true);
        },
        limit: limit,
      );

      final result = entries.map((data) {
        return JournalEntry(
          id: data['id'] as String,
          userId: data['userId'] as String,
          content: data['content'] as String,
          timestamp: DateTime.parse(data['timestamp'] as String),
          mood: data['mood'] as String?,
          moodScore: (data['moodScore'] as num?)?.toDouble(),
          metadata: data['metadata'] as Map<String, dynamic>?,
          aiSummary: data['aiSummary'] as String?,
          aiSummaryGeneratedAt: data['aiSummaryGeneratedAt'] != null
              ? DateTime.parse(data['aiSummaryGeneratedAt'] as String)
              : null,
        );
      }).toList();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get journal entries: $e'));
    }
  }

  @override
  Future<Either<Failure, JournalEntry?>> getEntry({
    required String id,
  }) async {
    try {
      final data = await _firestoreDataSource.read(
        collection: 'journal_entries',
        id: id,
      );

      if (data == null) {
        return const Right(null);
      }

      final entry = JournalEntry(
        id: data['id'] as String,
        userId: data['userId'] as String,
        content: data['content'] as String,
        timestamp: DateTime.parse(data['timestamp'] as String),
        mood: data['mood'] as String?,
        moodScore: (data['moodScore'] as num?)?.toDouble(),
        metadata: data['metadata'] as Map<String, dynamic>?,
        aiSummary: data['aiSummary'] as String?,
        aiSummaryGeneratedAt: data['aiSummaryGeneratedAt'] != null
            ? DateTime.parse(data['aiSummaryGeneratedAt'] as String)
            : null,
      );

      return Right(entry);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get journal entry: $e'));
    }
  }

  @override
  Future<Either<Failure, JournalEntry>> updateEntry({
    required String id,
    String? content,
    String? mood,
    double? moodScore,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final updateData = <String, dynamic>{};
      if (content != null) updateData['content'] = content;
      if (mood != null) updateData['mood'] = mood;
      if (moodScore != null) updateData['moodScore'] = moodScore;
      if (metadata != null) updateData['metadata'] = metadata;

      await _firestoreDataSource.update(
        collection: 'journal_entries',
        id: id,
        data: updateData,
      );

      // Get updated entry
      final result = await getEntry(id: id);
      return result.fold(
        (failure) => Left(failure),
        (entry) {
          if (entry == null) {
            return Left(UnknownFailure('Entry not found after update'));
          }
          return Right(entry);
        },
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to update journal entry: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEntry({
    required String id,
  }) async {
    try {
      await _firestoreDataSource.delete(
        collection: 'journal_entries',
        id: id,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to delete journal entry: $e'));
    }
  }

  @override
  Future<Either<Failure, JournalStreak>> getStreak({
    required String userId,
  }) async {
    try {
      // Get all entries for the user
      final entriesResult = await getEntries(userId: userId);
      
      return entriesResult.fold(
        (failure) => Left(failure),
        (entries) {
          if (entries.isEmpty) {
            return Right(const JournalStreak(
              currentStreak: 0,
              longestStreak: 0,
              isActive: false,
            ));
          }

          // Sort by date (newest first)
          final sortedEntries = List<JournalEntry>.from(entries)
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

          // Calculate current streak
          int currentStreak = 0;
          int longestStreak = 0;
          int tempStreak = 0;
          DateTime? lastDate;
          bool isActive = false;

          final today = DateTime.now();
          final todayDate = DateTime(today.year, today.month, today.day);

          for (var entry in sortedEntries) {
            final entryDate = DateTime(
              entry.timestamp.year,
              entry.timestamp.month,
              entry.timestamp.day,
            );

            if (lastDate == null) {
              // First entry
              final daysDiff = todayDate.difference(entryDate).inDays;
              if (daysDiff == 0) {
                currentStreak = 1;
                isActive = true;
              } else if (daysDiff == 1) {
                currentStreak = 1;
                isActive = false;
              }
              tempStreak = 1;
              longestStreak = 1;
              lastDate = entryDate;
            } else {
              final daysDiff = lastDate.difference(entryDate).inDays;
              
              if (daysDiff == 1) {
                // Consecutive day
                tempStreak++;
                longestStreak = tempStreak > longestStreak ? tempStreak : longestStreak;
                
                if (currentStreak > 0 && !isActive) {
                  // Continue counting current streak
                  currentStreak++;
                } else if (currentStreak == 0 && entryDate == todayDate) {
                  // Start new streak from today
                  currentStreak = tempStreak;
                  isActive = true;
                }
              } else if (daysDiff > 1) {
                // Streak broken
                tempStreak = 1;
                if (entryDate == todayDate) {
                  currentStreak = 1;
                  isActive = true;
                } else {
                  currentStreak = 0;
                  isActive = false;
                }
              }
              
              lastDate = entryDate;
            }
          }

          return Right(JournalStreak(
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            lastEntryDate: sortedEntries.isNotEmpty ? sortedEntries.first.timestamp : null,
            isActive: isActive,
          ));
        },
      );
    } catch (e) {
      return Left(UnknownFailure('Failed to calculate journal streak: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> generateAISummary({
    required String entryId,
    Map<String, dynamic>? healthDataContext,
  }) async {
    try {
      // Get the journal entry
      final entryResult = await getEntry(id: entryId);
      
      return entryResult.fold(
        (failure) => Left(failure),
        (entry) async {
          if (entry == null) {
            return Left(UnknownFailure('Journal entry not found'));
          }

          // Call Firebase Function to generate AI summary
          final result = await _functionsDataSource.callFunction(
            functionName: 'generateJournalSummary',
            data: {
              'entryId': entryId,
              'content': entry.content,
              'mood': entry.mood,
              'moodScore': entry.moodScore,
              'healthDataContext': healthDataContext,
            },
          );

          final summary = result['summary'] as String? ?? '';

          // Update entry with AI summary
          await _firestoreDataSource.update(
            collection: 'journal_entries',
            id: entryId,
            data: {
              'aiSummary': summary,
              'aiSummaryGeneratedAt': DateTime.now().toIso8601String(),
            },
          );

          return Right(summary);
        },
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to generate AI summary: $e'));
    }
  }
}

