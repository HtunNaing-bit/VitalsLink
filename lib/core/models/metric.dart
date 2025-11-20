import 'package:freezed_annotation/freezed_annotation.dart';

part 'metric.freezed.dart';
part 'metric.g.dart';

/// Health metric data point
@freezed
class Metric with _$Metric {
  const factory Metric({
    required String id,
    required String userId,
    required DateTime timestamp,
    required MetricType type,
    required double value,
    required String sourceId,
    String? unit,
    Map<String, dynamic>? metadata,
  }) = _Metric;

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);
}

/// Metric types supported by VitalsLink
enum MetricType {
  heartRate,
  heartRateVariability,
  steps,
  sleepDuration,
  sleepQuality,
  activity,
  calories,
  weight,
  bloodPressure,
  bloodGlucose,
  oxygenSaturation,
}

/// Data source/provider
@freezed
class DataSource with _$DataSource {
  const factory DataSource({
    required String id,
    required String userId,
    required String provider, // e.g., 'apple_health', 'fitbit', 'google_fit'
    required DataSourceStatus status,
    DateTime? lastSync,
    Map<String, dynamic>? config,
  }) = _DataSource;

  factory DataSource.fromJson(Map<String, dynamic> json) =>
      _$DataSourceFromJson(json);
}

/// Data source connection status
enum DataSourceStatus {
  disconnected,
  connecting,
  connected,
  error,
  syncing,
}
