// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MetricImpl _$$MetricImplFromJson(Map<String, dynamic> json) => _$MetricImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: $enumDecode(_$MetricTypeEnumMap, json['type']),
      value: (json['value'] as num).toDouble(),
      sourceId: json['sourceId'] as String,
      unit: json['unit'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MetricImplToJson(_$MetricImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': _$MetricTypeEnumMap[instance.type]!,
      'value': instance.value,
      'sourceId': instance.sourceId,
      'unit': instance.unit,
      'metadata': instance.metadata,
    };

const _$MetricTypeEnumMap = {
  MetricType.heartRate: 'heartRate',
  MetricType.heartRateVariability: 'heartRateVariability',
  MetricType.steps: 'steps',
  MetricType.sleepDuration: 'sleepDuration',
  MetricType.sleepQuality: 'sleepQuality',
  MetricType.activity: 'activity',
  MetricType.calories: 'calories',
  MetricType.weight: 'weight',
  MetricType.bloodPressure: 'bloodPressure',
  MetricType.bloodGlucose: 'bloodGlucose',
  MetricType.oxygenSaturation: 'oxygenSaturation',
};

_$DataSourceImpl _$$DataSourceImplFromJson(Map<String, dynamic> json) =>
    _$DataSourceImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      provider: json['provider'] as String,
      status: $enumDecode(_$DataSourceStatusEnumMap, json['status']),
      lastSync: json['lastSync'] == null
          ? null
          : DateTime.parse(json['lastSync'] as String),
      config: json['config'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$DataSourceImplToJson(_$DataSourceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'provider': instance.provider,
      'status': _$DataSourceStatusEnumMap[instance.status]!,
      'lastSync': instance.lastSync?.toIso8601String(),
      'config': instance.config,
    };

const _$DataSourceStatusEnumMap = {
  DataSourceStatus.disconnected: 'disconnected',
  DataSourceStatus.connecting: 'connecting',
  DataSourceStatus.connected: 'connected',
  DataSourceStatus.error: 'error',
  DataSourceStatus.syncing: 'syncing',
};
