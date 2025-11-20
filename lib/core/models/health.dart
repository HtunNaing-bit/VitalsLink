import 'package:freezed_annotation/freezed_annotation.dart';

part 'health.freezed.dart';
part 'health.g.dart';

@freezed
class HealthMetric with _$HealthMetric {
  const factory HealthMetric({
    required String id,
    required String label,
    required String value,
    String? delta,
    String? insight,
  }) = _HealthMetric;

  factory HealthMetric.fromJson(Map<String, dynamic> json) =>
      _$HealthMetricFromJson(json);
}

@freezed
class TrendPoint with _$TrendPoint {
  const factory TrendPoint({
    required DateTime timestamp,
    required double value,
  }) = _TrendPoint;

  factory TrendPoint.fromJson(Map<String, dynamic> json) =>
      _$TrendPointFromJson(json);
}

@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent({
    required String id,
    required String title,
    required String description,
    required DateTime timestamp,
    String? icon,
  }) = _TimelineEvent;

  factory TimelineEvent.fromJson(Map<String, dynamic> json) =>
      _$TimelineEventFromJson(json);
}

@freezed
class Connector with _$Connector {
  const factory Connector({
    required String id,
    required String provider,
    required String description,
    required bool connected,
  }) = _Connector;

  factory Connector.fromJson(Map<String, dynamic> json) =>
      _$ConnectorFromJson(json);
}

@freezed
class DashboardSnapshot with _$DashboardSnapshot {
  const factory DashboardSnapshot({
    required List<HealthMetric> metrics,
    required List<TrendPoint> trend,
    required List<TrendPoint> forecast,
    required List<TimelineEvent> timeline,
    required String insight,
  }) = _DashboardSnapshot;

  factory DashboardSnapshot.fromJson(Map<String, dynamic> json) =>
      _$DashboardSnapshotFromJson(json);
}
