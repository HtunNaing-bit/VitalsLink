import 'package:dartz/dartz.dart';
import '../../entities/health_data.dart';
import '../../repositories/health_data_repository.dart';
import '../../../core/error/failures.dart';

/// Use Case: Get Sleep Duration Data
/// Encapsulates business logic for retrieving sleep data
class GetSleepData {
  final HealthDataRepository repository;

  GetSleepData(this.repository);

  /// Execute the use case
  /// Returns Either a Failure or a List of HealthData
  Future<Either<Failure, List<HealthData>>> call({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await repository.getSleepDuration(
      days: days,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

