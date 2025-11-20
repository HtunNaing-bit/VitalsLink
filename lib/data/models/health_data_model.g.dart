// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthDataModel _$HealthDataModelFromJson(Map<String, dynamic> json) =>
    HealthDataModel(
      id: json['id'] as String,
      type: $enumDecode(_$HealthMetricTypeEnumMap, json['type']),
      value: (json['value'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      unit: json['unit'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$HealthDataModelToJson(HealthDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$HealthMetricTypeEnumMap[instance.type]!,
      'value': instance.value,
      'timestamp': instance.timestamp.toIso8601String(),
      'unit': instance.unit,
      'metadata': instance.metadata,
    };

const _$HealthMetricTypeEnumMap = {
  HealthMetricType.sleepDuration: 'sleepDuration',
  HealthMetricType.stepCount: 'stepCount',
  HealthMetricType.heartRate: 'heartRate',
  HealthMetricType.mindfulnessMinutes: 'mindfulnessMinutes',
};
