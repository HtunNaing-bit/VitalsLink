import 'package:dartz/dartz.dart';
import '../../entities/journal_entry.dart';
import '../../repositories/journal_repository.dart';
import '../../../core/error/failures.dart';

/// Use Case: Get Journal Streak
/// Calculates the current journaling streak
class GetJournalStreak {
  final JournalRepository repository;

  GetJournalStreak(this.repository);

  Future<Either<Failure, JournalStreak>> call({
    required String userId,
  }) async {
    return await repository.getStreak(userId: userId);
  }
}

