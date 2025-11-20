import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/health_data.dart';
import '../../domain/usecases/health_data/get_sleep_data.dart';
import '../../domain/usecases/health_data/get_step_count.dart';
import '../../domain/usecases/health_data/get_heart_rate.dart';
import '../../domain/usecases/health_data/get_mindfulness_minutes.dart';
import '../../domain/usecases/health_data/get_health_data_summary.dart';
import '../../domain/usecases/health_data/request_health_permissions.dart';
import '../../core/di/injection_container.dart';

/// Provider: Get Sleep Data Use Case
final getSleepDataProvider = Provider<GetSleepData>((ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return GetSleepData(repository);
});

/// Provider: Get Step Count Use Case
final getStepCountProvider = Provider<GetStepCount>((ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return GetStepCount(repository);
});

/// Provider: Get Heart Rate Use Case
final getHeartRateProvider = Provider<GetHeartRate>((ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return GetHeartRate(repository);
});

/// Provider: Get Mindfulness Minutes Use Case
final getMindfulnessMinutesProvider = Provider<GetMindfulnessMinutes>((ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return GetMindfulnessMinutes(repository);
});

/// Provider: Get Health Data Summary Use Case
final getHealthDataSummaryProvider = Provider<GetHealthDataSummary>((ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return GetHealthDataSummary(repository);
});

/// Provider: Request Health Permissions Use Case
final requestHealthPermissionsProvider = Provider<RequestHealthPermissions>((ref) {
  final repository = ref.watch(healthDataRepositoryProvider);
  return RequestHealthPermissions(repository);
});

/// State: Sleep Data (7 days)
final sleepDataProvider = FutureProvider.autoDispose<List<HealthData>>((ref) async {
  final getSleepData = ref.watch(getSleepDataProvider);
  final result = await getSleepData.call(days: 7);
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

/// State: Step Count (7 days)
final stepCountProvider = FutureProvider.autoDispose<List<HealthData>>((ref) async {
  final getStepCount = ref.watch(getStepCountProvider);
  final result = await getStepCount.call(days: 7);
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

/// State: Heart Rate (7 days)
final heartRateProvider = FutureProvider.autoDispose<List<HealthData>>((ref) async {
  final getHeartRate = ref.watch(getHeartRateProvider);
  final result = await getHeartRate.call(days: 7);
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

/// State: Mindfulness Minutes (7 days)
final mindfulnessMinutesProvider = FutureProvider.autoDispose<List<HealthData>>((ref) async {
  final getMindfulnessMinutes = ref.watch(getMindfulnessMinutesProvider);
  final result = await getMindfulnessMinutes.call(days: 7);
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (data) => data,
  );
});

/// State: Health Data Summary
final healthDataSummaryProvider = FutureProvider.family.autoDispose<HealthDataSummary, HealthMetricType>(
  (ref, type) async {
    final getSummary = ref.watch(getHealthDataSummaryProvider);
    final result = await getSummary.call(type: type, days: 7);
    
    return result.fold(
      (failure) => throw Exception(failure.message),
      (summary) => summary,
    );
  },
);

/// State: Latest Health Data
final latestHealthDataProvider = FutureProvider.family.autoDispose<HealthData?, HealthMetricType>(
  (ref, type) async {
    final repository = ref.watch(healthDataRepositoryProvider);
    final result = await repository.getLatestHealthData(type: type);
    
    return result.fold(
      (failure) => throw Exception(failure.message),
      (data) => data,
    );
  },
);

/// State: Permission Status
final healthPermissionsProvider = FutureProvider.family.autoDispose<bool, List<HealthMetricType>>(
  (ref, metrics) async {
    final repository = ref.watch(healthDataRepositoryProvider);
    final result = await repository.hasPermissions(metrics: metrics);
    
    return result.fold(
      (failure) => false,
      (hasPermissions) => hasPermissions,
    );
  },
);

