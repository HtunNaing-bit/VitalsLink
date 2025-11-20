import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_message.freezed.dart';
part 'ai_message.g.dart';

enum ChatRole { user, assistant, system }

@freezed
class AIMessage with _$AIMessage {
  const factory AIMessage({
    required String id,
    required ChatRole role,
    required String content,
    required DateTime timestamp,
    @Default([]) List<String> dataPoints, // Data points used in response
    double? confidence, // Confidence level (0.0 to 1.0)
  }) = _AIMessage;

  factory AIMessage.fromJson(Map<String, dynamic> json) =>
      _$AIMessageFromJson(json);
}

@freezed
class AIAction with _$AIAction {
  const factory AIAction({
    required String id,
    required String title,
    required String description,
    required String command,
  }) = _AIAction;

  factory AIAction.fromJson(Map<String, dynamic> json) =>
      _$AIActionFromJson(json);
}
