import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/ai_chat_message.dart';

part 'ai_chat_message_model.g.dart';

/// Data Model for AI Chat Message
@JsonSerializable()
class AIChatMessageModel {
  final String id;
  final String role;
  final String content;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  AIChatMessageModel({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.metadata,
  });

  /// Create from domain entity
  factory AIChatMessageModel.fromEntity(AIChatMessage entity) {
    return AIChatMessageModel(
      id: entity.id,
      role: entity.role,
      content: entity.content,
      timestamp: entity.timestamp,
      metadata: entity.metadata,
    );
  }

  /// Convert to domain entity
  AIChatMessage toEntity() {
    return AIChatMessage(
      id: id,
      role: role,
      content: content,
      timestamp: timestamp,
      metadata: metadata,
    );
  }

  /// Create from JSON
  factory AIChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$AIChatMessageModelFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$AIChatMessageModelToJson(this);
}

