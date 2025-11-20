import 'package:dartz/dartz.dart';
import '../entities/health_data.dart';
import '../../core/error/failures.dart';

/// Repository Interface for Health Data
/// Abstract interface defining health data operations
abstract class HealthDataRepository {
  /// Request permissions for health data access
  /// Returns true if permissions granted, false otherwise
  Future<Either<Failure, bool>> requestPermissions({
    required List<HealthMetricType> metrics,
  });

  /// Check if permissions are granted for specific metrics
  Future<Either<Failure, bool>> hasPermissions({
    required List<HealthMetricType> metrics,
  });

  /// Get sleep duration data for the last N days
  /// Returns list of HealthData points (one per day)
  Future<Either<Failure, List<HealthData>>> getSleepDuration({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get step count data for the last N days
  /// Returns list of HealthData points (one per day)
  Future<Either<Failure, List<HealthData>>> getStepCount({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get heart rate data for the last N days
  /// Returns list of HealthData points (can be multiple per day)
  Future<Either<Failure, List<HealthData>>> getHeartRate({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get mindfulness minutes for the last N days
  /// Returns list of HealthData points (one per day)
  Future<Either<Failure, List<HealthData>>> getMindfulnessMinutes({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get health data summary for a specific metric type
  Future<Either<Failure, HealthDataSummary>> getHealthDataSummary({
    required HealthMetricType type,
    required int days,
  });

  /// Get latest health data point for a specific metric
  Future<Either<Failure, HealthData?>> getLatestHealthData({
    required HealthMetricType type,
  });

  /// Stream of health data updates (real-time)
  Stream<Either<Failure, HealthData>> watchHealthData({
    required HealthMetricType type,
  });
}

