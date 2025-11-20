// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_insight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AIInsightImpl _$$AIInsightImplFromJson(Map<String, dynamic> json) =>
    _$AIInsightImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      recommendation: json['recommendation'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 1.0,
      dataPoints: (json['dataPoints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AIInsightImplToJson(_$AIInsightImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'recommendation': instance.recommendation,
      'confidence': instance.confidence,
      'dataPoints': instance.dataPoints,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
    };
