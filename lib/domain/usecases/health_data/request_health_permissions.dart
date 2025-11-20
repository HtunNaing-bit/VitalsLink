import 'package:dartz/dartz.dart';
import '../../entities/health_data.dart';
import '../../repositories/health_data_repository.dart';
import '../../../core/error/failures.dart';

/// Use Case: Request Health Data Permissions
class RequestHealthPermissions {
  final HealthDataRepository repository;

  RequestHealthPermissions(this.repository);

  Future<Either<Failure, bool>> call({
    required List<HealthMetricType> metrics,
  }) async {
    return await repository.requestPermissions(metrics: metrics);
  }
}

