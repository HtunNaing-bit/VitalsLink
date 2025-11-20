// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthMetricImpl _$$HealthMetricImplFromJson(Map<String, dynamic> json) =>
    _$HealthMetricImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      value: json['value'] as String,
      delta: json['delta'] as String?,
      insight: json['insight'] as String?,
    );

Map<String, dynamic> _$$HealthMetricImplToJson(_$HealthMetricImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'value': instance.value,
      'delta': instance.delta,
      'insight': instance.insight,
    };

_$TrendPointImpl _$$TrendPointImplFromJson(Map<String, dynamic> json) =>
    _$TrendPointImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$$TrendPointImplToJson(_$TrendPointImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'value': instance.value,
    };

_$TimelineEventImpl _$$TimelineEventImplFromJson(Map<String, dynamic> json) =>
    _$TimelineEventImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$TimelineEventImplToJson(_$TimelineEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'icon': instance.icon,
    };

_$ConnectorImpl _$$ConnectorImplFromJson(Map<String, dynamic> json) =>
    _$ConnectorImpl(
      id: json['id'] as String,
      provider: json['provider'] as String,
      description: json['description'] as String,
      connected: json['connected'] as bool,
    );

Map<String, dynamic> _$$ConnectorImplToJson(_$ConnectorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provider': instance.provider,
      'description': instance.description,
      'connected': instance.connected,
    };

_$DashboardSnapshotImpl _$$DashboardSnapshotImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardSnapshotImpl(
      metrics: (json['metrics'] as List<dynamic>)
          .map((e) => HealthMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      trend: (json['trend'] as List<dynamic>)
          .map((e) => TrendPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      forecast: (json['forecast'] as List<dynamic>)
          .map((e) => TrendPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) => TimelineEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      insight: json['insight'] as String,
    );

Map<String, dynamic> _$$DashboardSnapshotImplToJson(
        _$DashboardSnapshotImpl instance) =>
    <String, dynamic>{
      'metrics': instance.metrics,
      'trend': instance.trend,
      'forecast': instance.forecast,
      'timeline': instance.timeline,
      'insight': instance.insight,
    };
