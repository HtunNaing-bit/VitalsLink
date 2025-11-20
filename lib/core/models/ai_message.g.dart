// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AIMessageImpl _$$AIMessageImplFromJson(Map<String, dynamic> json) =>
    _$AIMessageImpl(
      id: json['id'] as String,
      role: $enumDecode(_$ChatRoleEnumMap, json['role']),
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      dataPoints: (json['dataPoints'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      confidence: (json['confidence'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AIMessageImplToJson(_$AIMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$ChatRoleEnumMap[instance.role]!,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
      'dataPoints': instance.dataPoints,
      'confidence': instance.confidence,
    };

const _$ChatRoleEnumMap = {
  ChatRole.user: 'user',
  ChatRole.assistant: 'assistant',
  ChatRole.system: 'system',
};

_$AIActionImpl _$$AIActionImplFromJson(Map<String, dynamic> json) =>
    _$AIActionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      command: json['command'] as String,
    );

Map<String, dynamic> _$$AIActionImplToJson(_$AIActionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'command': instance.command,
    };
