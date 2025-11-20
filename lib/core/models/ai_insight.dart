import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_insight.freezed.dart';
part 'ai_insight.g.dart';

/// AI-Generated Health Insight Model
@freezed
class AIInsight with _$AIInsight {
  const factory AIInsight({
    required String id,
    required String title,
    required String description,
    String? recommendation,
    @Default(1.0) double confidence, // 0.0 to 1.0
    List<String>? dataPoints,
    required DateTime timestamp,
    Map<String, dynamic>? metadata,
  }) = _AIInsight;

  factory AIInsight.fromJson(Map<String, dynamic> json) =>
      _$AIInsightFromJson(json);
}
