import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../domain/entities/health_data.dart';
import '../../domain/repositories/health_data_repository.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../datasources/platform/healthkit_datasource.dart';
import '../datasources/platform/google_fit_datasource.dart';

/// Health Data Repository Implementation
/// Implements the repository interface using platform-specific data sources
class HealthDataRepositoryImpl implements HealthDataRepository {
  final HealthKitDataSource? _healthKitDataSource;
  final GoogleFitDataSource? _googleFitDataSource;

  HealthDataRepositoryImpl({
    HealthKitDataSource? healthKitDataSource,
    GoogleFitDataSource? googleFitDataSource,
  })  : _healthKitDataSource = healthKitDataSource,
        _googleFitDataSource = googleFitDataSource;

  /// Get platform-specific data source
  dynamic get _platformDataSource {
    if (Platform.isIOS && _healthKitDataSource != null) {
      return _healthKitDataSource;
    } else if (Platform.isAndroid && _googleFitDataSource != null) {
      return _googleFitDataSource;
    } else {
      throw PlatformException('Health data source not available on this platform');
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermissions({
    required List<HealthMetricType> metrics,
  }) async {
    try {
      final dataSource = _platformDataSource;
      final granted = await dataSource.requestPermissions(metrics: metrics);
      return Right(granted);
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasPermissions({
    required List<HealthMetricType> metrics,
  }) async {
    try {
      final dataSource = _platformDataSource;
      final hasAccess = await dataSource.hasPermissions(metrics: metrics);
      return Right(hasAccess);
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HealthData>>> getSleepDuration({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final dataSource = _platformDataSource;
      final data = await dataSource.getSleepDuration(
        days: days,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(data);
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.message));
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get sleep duration: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HealthData>>> getStepCount({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final dataSource = _platformDataSource;
      final data = await dataSource.getStepCount(
        days: days,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(data);
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.message));
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get step count: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HealthData>>> getHeartRate({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final dataSource = _platformDataSource;
      final data = await dataSource.getHeartRate(
        days: days,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(data);
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.message));
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get heart rate: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HealthData>>> getMindfulnessMinutes({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final dataSource = _platformDataSource;
      final data = await dataSource.getMindfulnessMinutes(
        days: days,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(data);
    } on PlatformException catch (e) {
      return Left(PlatformFailure(e.message));
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure('Failed to get mindfulness minutes: $e'));
    }
  }

  @override
  Future<Either<Failure, HealthDataSummary>> getHealthDataSummary({
    required HealthMetricType type,
    required int days,
  }) async {
    try {
      // Get data based on type
      final Either<Failure, List<HealthData>> dataResult;
      
      switch (type) {
        case HealthMetricType.sleepDuration:
          dataResult = await getSleepDuration(days: days);
          break;
        case HealthMetricType.stepCount:
          dataResult = await getStepCount(days: days);
          break;
        case HealthMetricType.heartRate:
          dataResult = await getHeartRate(days: days);
          break;
        case HealthMetricType.mindfulnessMinutes:
          dataResult = await getMindfulnessMinutes(days: days);
          break;
      }

      return dataResult.fold(
        (failure) => Left(failure),
        (data) {
          if (data.isEmpty) {
            return Right(HealthDataSummary(
              type: type,
              count: 0,
              dataPoints: [],
            ));
          }

          // Calculate statistics
          final values = data.map((d) => d.value).toList();
          final average = values.reduce((a, b) => a + b) / values.length;
          final min = values.reduce((a, b) => a < b ? a : b);
          final max = values.reduce((a, b) => a > b ? a : b);
          
          final sortedData = List<HealthData>.from(data)
            ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
          
          final firstDate = sortedData.first.timestamp;
          final lastDate = sortedData.last.timestamp;

          // Convert to data points for charts
          final dataPoints = data.map((d) {
            return HealthDataPoint(
              date: d.timestamp,
              value: d.value,
              type: d.type,
            );
          }).toList();

          return Right(HealthDataSummary(
            type: type,
            average: average,
            min: min,
            max: max,
            count: data.length,
            firstDate: firstDate,
            lastDate: lastDate,
            dataPoints: dataPoints,
          ));
        },
      );
    } catch (e) {
      return Left(UnknownFailure('Failed to get health data summary: $e'));
    }
  }

  @override
  Future<Either<Failure, HealthData?>> getLatestHealthData({
    required HealthMetricType type,
  }) async {
    try {
      // Get last 7 days of data
      final Either<Failure, List<HealthData>> dataResult;
      
      switch (type) {
        case HealthMetricType.sleepDuration:
          dataResult = await getSleepDuration(days: 7);
          break;
        case HealthMetricType.stepCount:
          dataResult = await getStepCount(days: 7);
          break;
        case HealthMetricType.heartRate:
          dataResult = await getHeartRate(days: 7);
          break;
        case HealthMetricType.mindfulnessMinutes:
          dataResult = await getMindfulnessMinutes(days: 7);
          break;
      }

      return dataResult.fold(
        (failure) => Left(failure),
        (data) {
          if (data.isEmpty) {
            return Right(null);
          }

          // Get the most recent data point
          final sortedData = List<HealthData>.from(data)
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
          
          return Right(sortedData.first);
        },
      );
    } catch (e) {
      return Left(UnknownFailure('Failed to get latest health data: $e'));
    }
  }

  @override
  Stream<Either<Failure, HealthData>> watchHealthData({
    required HealthMetricType type,
  }) async* {
    // For real-time updates, we would need to implement platform-specific streams
    // This is a placeholder that polls every minute
    while (true) {
      await Future.delayed(const Duration(minutes: 1));
      
      final result = await getLatestHealthData(type: type);
      
      yield result.fold(
        (failure) => Left(failure),
        (data) {
          if (data == null) {
            return Left(UnknownFailure('No health data available'));
          }
          return Right(data);
        },
      );
    }
  }
}

