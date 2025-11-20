// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIChatMessageModel _$AIChatMessageModelFromJson(Map<String, dynamic> json) =>
    AIChatMessageModel(
      id: json['id'] as String,
      role: json['role'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AIChatMessageModelToJson(AIChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
    };
