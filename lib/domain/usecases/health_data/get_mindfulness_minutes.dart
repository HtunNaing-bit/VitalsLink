import 'package:dartz/dartz.dart';
import '../../entities/health_data.dart';
import '../../repositories/health_data_repository.dart';
import '../../../core/error/failures.dart';

/// Use Case: Get Mindfulness Minutes Data
class GetMindfulnessMinutes {
  final HealthDataRepository repository;

  GetMindfulnessMinutes(this.repository);

  Future<Either<Failure, List<HealthData>>> call({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await repository.getMindfulnessMinutes(
      days: days,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

