/// Domain Entity: Health Data
/// Pure Dart class representing health metrics in the domain layer
class HealthData {
  final String id;
  final HealthMetricType type;
  final double value;
  final DateTime timestamp;
  final String? unit;
  final Map<String, dynamic>? metadata;

  const HealthData({
    required this.id,
    required this.type,
    required this.value,
    required this.timestamp,
    this.unit,
    this.metadata,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          value == other.value &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      value.hashCode ^
      timestamp.hashCode;
}

/// Health Metric Types
enum HealthMetricType {
  sleepDuration, // Hours
  stepCount, // Steps
  heartRate, // BPM
  mindfulnessMinutes, // Minutes
}

/// Health Data Point (for trends/charts)
class HealthDataPoint {
  final DateTime date;
  final double value;
  final HealthMetricType type;

  const HealthDataPoint({
    required this.date,
    required this.value,
    required this.type,
  });
}

/// Health Data Summary (aggregated data)
class HealthDataSummary {
  final HealthMetricType type;
  final double? average;
  final double? min;
  final double? max;
  final int count;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final List<HealthDataPoint> dataPoints;

  const HealthDataSummary({
    required this.type,
    this.average,
    this.min,
    this.max,
    required this.count,
    this.firstDate,
    this.lastDate,
    required this.dataPoints,
  });
}

