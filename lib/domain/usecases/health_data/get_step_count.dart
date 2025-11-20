import 'package:dartz/dartz.dart';
import '../../entities/health_data.dart';
import '../../repositories/health_data_repository.dart';
import '../../../core/error/failures.dart';

/// Use Case: Get Step Count Data
class GetStepCount {
  final HealthDataRepository repository;

  GetStepCount(this.repository);

  Future<Either<Failure, List<HealthData>>> call({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await repository.getStepCount(
      days: days,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

