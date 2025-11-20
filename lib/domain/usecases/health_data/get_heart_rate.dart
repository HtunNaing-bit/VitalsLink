import 'package:dartz/dartz.dart';
import '../../entities/health_data.dart';
import '../../repositories/health_data_repository.dart';
import '../../../core/error/failures.dart';

/// Use Case: Get Heart Rate Data
class GetHeartRate {
  final HealthDataRepository repository;

  GetHeartRate(this.repository);

  Future<Either<Failure, List<HealthData>>> call({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await repository.getHeartRate(
      days: days,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

