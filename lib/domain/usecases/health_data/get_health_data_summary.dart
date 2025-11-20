import 'package:dartz/dartz.dart';
import '../../entities/health_data.dart';
import '../../repositories/health_data_repository.dart';
import '../../../core/error/failures.dart';

/// Use Case: Get Health Data Summary
/// Returns aggregated statistics for a specific metric
class GetHealthDataSummary {
  final HealthDataRepository repository;

  GetHealthDataSummary(this.repository);

  Future<Either<Failure, HealthDataSummary>> call({
    required HealthMetricType type,
    required int days,
  }) async {
    return await repository.getHealthDataSummary(
      type: type,
      days: days,
    );
  }
}

