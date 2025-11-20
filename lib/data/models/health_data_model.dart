import '../../domain/entities/health_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'health_data_model.g.dart';

/// Data Model for Health Data
/// Extends domain entity with JSON serialization
@JsonSerializable()
class HealthDataModel extends HealthData {
  const HealthDataModel({
    required super.id,
    required super.type,
    required super.value,
    required super.timestamp,
    super.unit,
    super.metadata,
  });

  /// Create from domain entity
  factory HealthDataModel.fromEntity(HealthData entity) {
    return HealthDataModel(
      id: entity.id,
      type: entity.type,
      value: entity.value,
      timestamp: entity.timestamp,
      unit: entity.unit,
      metadata: entity.metadata,
    );
  }

  /// Convert to domain entity
  HealthData toEntity() {
    return HealthData(
      id: id,
      type: type,
      value: value,
      timestamp: timestamp,
      unit: unit,
      metadata: metadata,
    );
  }

  /// Create from JSON
  factory HealthDataModel.fromJson(Map<String, dynamic> json) =>
      _$HealthDataModelFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$HealthDataModelToJson(this);

  /// Create from platform-specific data (HealthKit/Google Fit)
  factory HealthDataModel.fromPlatformData({
    required HealthMetricType type,
    required double value,
    required DateTime timestamp,
    String? unit,
    Map<String, dynamic>? metadata,
  }) {
    return HealthDataModel(
      id: '${type.name}_${timestamp.millisecondsSinceEpoch}',
      type: type,
      value: value,
      timestamp: timestamp,
      unit: unit,
      metadata: metadata,
    );
  }
}

