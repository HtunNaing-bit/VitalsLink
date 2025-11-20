import 'dart:io';
import 'package:health/health.dart';
import '../../../../domain/entities/health_data.dart';
import '../../../../core/error/exceptions.dart';

/// iOS HealthKit Data Source
/// Handles all HealthKit-specific operations
class HealthKitDataSource {
  Health? _health;
  bool _isInitialized = false;

  /// Initialize HealthKit
  Future<void> initialize() async {
    if (!Platform.isIOS) {
      throw PlatformException('HealthKit is only available on iOS');
    }

    try {
      _health = const Health();
      _isInitialized = true;
    } catch (e) {
      throw PlatformException('Failed to initialize HealthKit: $e');
    }
  }

  /// Request permissions for specific health data types
  Future<bool> requestPermissions({
    required List<HealthMetricType> metrics,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final healthDataTypes = _mapMetricsToHealthTypes(metrics);
      final granted = await _health!.requestAuthorization(healthDataTypes);
      return granted;
    } catch (e) {
      throw PermissionException('Failed to request HealthKit permissions: $e');
    }
  }

  /// Check if permissions are granted
  Future<bool> hasPermissions({
    required List<HealthMetricType> metrics,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final healthDataTypes = _mapMetricsToHealthTypes(metrics);
      final hasAccess = await _health!.hasPermissions(
        healthDataTypes,
        permissions: [HealthDataAccess.READ],
      );
      return hasAccess ?? false;
    } catch (e) {
      throw PermissionException('Failed to check HealthKit permissions: $e');
    }
  }

  /// Get sleep duration data
  Future<List<HealthData>> getSleepDuration({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final now = DateTime.now();
      final start = startDate ?? now.subtract(Duration(days: days));
      final end = endDate ?? now;

      // HealthKit uses HealthDataType.SLEEP_IN_BED, SLEEP_ASLEEP, SLEEP_AWAKE
      // We'll aggregate these to get total sleep duration
      final sleepData = await _health!.getHealthDataFromTypes(
        startTime: start,
        endTime: end,
        types: [HealthDataType.SLEEP_IN_BED, HealthDataType.SLEEP_ASLEEP],
      );

      // Group by date and calculate total sleep per day
      final Map<DateTime, double> dailySleep = {};
      
      for (var data in sleepData) {
        final date = DateTime(
          data.dateFrom.year,
          data.dateFrom.month,
          data.dateFrom.day,
        );
        
        // Calculate duration in hours
        final duration = data.dateTo.difference(data.dateFrom).inMinutes / 60.0;
        dailySleep[date] = (dailySleep[date] ?? 0.0) + duration;
      }

      // Convert to HealthData entities
      return dailySleep.entries.map((entry) {
        return HealthData(
          id: 'sleep_${entry.key.millisecondsSinceEpoch}',
          type: HealthMetricType.sleepDuration,
          value: entry.value,
          timestamp: entry.key,
          unit: 'hours',
          metadata: {'source': 'healthkit'},
        );
      }).toList();
    } catch (e) {
      throw PlatformException('Failed to get sleep duration from HealthKit: $e');
    }
  }

  /// Get step count data
  Future<List<HealthData>> getStepCount({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final now = DateTime.now();
      final start = startDate ?? now.subtract(Duration(days: days));
      final end = endDate ?? now;

      final stepData = await _health!.getHealthDataFromTypes(
        startTime: start,
        endTime: end,
        types: [HealthDataType.STEPS],
      );

      // Group by date and sum steps per day
      final Map<DateTime, double> dailySteps = {};
      
      for (var data in stepData) {
        final date = DateTime(
          data.dateFrom.year,
          data.dateFrom.month,
          data.dateFrom.day,
        );
        dailySteps[date] = (dailySteps[date] ?? 0.0) + (data.value as num).toDouble();
      }

      return dailySteps.entries.map((entry) {
        return HealthData(
          id: 'steps_${entry.key.millisecondsSinceEpoch}',
          type: HealthMetricType.stepCount,
          value: entry.value,
          timestamp: entry.key,
          unit: 'steps',
          metadata: {'source': 'healthkit'},
        );
      }).toList();
    } catch (e) {
      throw PlatformException('Failed to get step count from HealthKit: $e');
    }
  }

  /// Get heart rate data
  Future<List<HealthData>> getHeartRate({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final now = DateTime.now();
      final start = startDate ?? now.subtract(Duration(days: days));
      final end = endDate ?? now;

      final heartRateData = await _health!.getHealthDataFromTypes(
        startTime: start,
        endTime: end,
        types: [HealthDataType.HEART_RATE],
      );

      return heartRateData.map((data) {
        return HealthData(
          id: 'heartrate_${data.dateFrom.millisecondsSinceEpoch}',
          type: HealthMetricType.heartRate,
          value: (data.value as num).toDouble(),
          timestamp: data.dateFrom,
          unit: 'bpm',
          metadata: {
            'source': 'healthkit',
            'dateTo': data.dateTo.toIso8601String(),
          },
        );
      }).toList();
    } catch (e) {
      throw PlatformException('Failed to get heart rate from HealthKit: $e');
    }
  }

  /// Get mindfulness minutes
  Future<List<HealthData>> getMindfulnessMinutes({
    required int days,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final now = DateTime.now();
      final start = startDate ?? now.subtract(Duration(days: days));
      final end = endDate ?? now;

      // HealthKit uses MINDFULNESS_SESSION
      final mindfulnessData = await _health!.getHealthDataFromTypes(
        startTime: start,
        endTime: end,
        types: [HealthDataType.MINDFULNESS],
      );

      // Group by date and sum minutes per day
      final Map<DateTime, double> dailyMindfulness = {};
      
      for (var data in mindfulnessData) {
        final date = DateTime(
          data.dateFrom.year,
          data.dateFrom.month,
          data.dateFrom.day,
        );
        final minutes = data.dateTo.difference(data.dateFrom).inMinutes.toDouble();
        dailyMindfulness[date] = (dailyMindfulness[date] ?? 0.0) + minutes;
      }

      return dailyMindfulness.entries.map((entry) {
        return HealthData(
          id: 'mindfulness_${entry.key.millisecondsSinceEpoch}',
          type: HealthMetricType.mindfulnessMinutes,
          value: entry.value,
          timestamp: entry.key,
          unit: 'minutes',
          metadata: {'source': 'healthkit'},
        );
      }).toList();
    } catch (e) {
      throw PlatformException('Failed to get mindfulness minutes from HealthKit: $e');
    }
  }

  /// Map HealthMetricType to HealthKit HealthDataType
  List<HealthDataType> _mapMetricsToHealthTypes(List<HealthMetricType> metrics) {
    final List<HealthDataType> healthTypes = [];

    for (var metric in metrics) {
      switch (metric) {
        case HealthMetricType.sleepDuration:
          healthTypes.addAll([
            HealthDataType.SLEEP_IN_BED,
            HealthDataType.SLEEP_ASLEEP,
          ]);
          break;
        case HealthMetricType.stepCount:
          healthTypes.add(HealthDataType.STEPS);
          break;
        case HealthMetricType.heartRate:
          healthTypes.add(HealthDataType.HEART_RATE);
          break;
        case HealthMetricType.mindfulnessMinutes:
          healthTypes.add(HealthDataType.MINDFULNESS);
          break;
      }
    }

    return healthTypes;
  }
}

