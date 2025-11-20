import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

/// AI Service with Mock Endpoints
/// Replace mocks with real API calls by setting useMocks = false
class AIService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  bool useMocks = true; // Toggle to use real API
  String? baseUrl; // Set to your API base URL

  /// Generate Daily Insights
  Future<List<AIInsight>> generateDailyInsights() async {
    if (useMocks) {
      // Load from mock JSON
      final jsonString = await rootBundle.loadString('mocks/ai/insights.json');
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final insights = (json['daily_insights'] as List)
          .map((item) => AIInsight.fromJson(item))
          .toList();
      return insights;
    } else {
      // Real API call
      final response = await http.get(
        Uri.parse('$baseUrl/api/ai/insights'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return (json['insights'] as List)
            .map((item) => AIInsight.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load insights');
    }
  }

  /// Chat with AI
  Future<AIChatResponse> chat(String message,
      {List<AIChatMessage>? history}) async {
    if (useMocks) {
      // Mock response based on query
      await Future.delayed(
          const Duration(milliseconds: 300)); // Simulate latency
      return AIChatResponse(
        message: _getMockResponse(message),
        confidence: 0.85,
        suggestedActions: [],
      );
    } else {
      // Real API call
      final response = await http.post(
        Uri.parse('$baseUrl/api/ai/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'history': history?.map((m) => m.toJson()).toList(),
        }),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return AIChatResponse.fromJson(json);
      }
      throw Exception('Failed to get chat response');
    }
  }

  String _getMockResponse(String query) {
    final lowerQuery = query.toLowerCase();
    if (lowerQuery.contains('workout') &&
        (lowerQuery.contains('sleep') || lowerQuery.contains('affect'))) {
      return 'Your workout at 8 PM seems to have delayed your REM sleep by 20 minutes, but your deep sleep was 15% longer. This suggests good physical recovery but potential for sleep cycle disruption. Consider working out earlier in the day (before 6 PM) to optimize both recovery and sleep quality.';
    } else if (lowerQuery.contains('sleep')) {
      return 'Based on your sleep data, I recommend maintaining a consistent sleep schedule. Your current average is 7.5 hours, which is good. Try going to bed 15 minutes earlier to reach 8 hours.';
    } else if (lowerQuery.contains('eat') || lowerQuery.contains('food')) {
      return 'Based on your activity level and goals, I recommend a balanced meal with lean protein, complex carbs, and vegetables. Aim for 30g protein per meal.';
    } else if (lowerQuery.contains('heart')) {
      return 'Your resting heart rate of 72 bpm is within the healthy range. Your HRV has been stable, indicating good recovery.';
    }
    return 'I\'m here to help with your health questions. Ask me about sleep, activity, nutrition, or any health concerns.';
  }
}

/// Insight Type Enum
enum InsightType {
  simple,
  correlative,
}

/// AI Insight Model
class AIInsight {
  final String id;
  final String title;
  final String snippet;
  final double confidence;
  final String category;
  final List<String> dataPoints;
  final Recommendation recommendation;
  final DateTime timestamp;
  final InsightType type;
  final List<String> sources;

  AIInsight({
    required this.id,
    required this.title,
    required this.snippet,
    required this.confidence,
    required this.category,
    required this.dataPoints,
    required this.recommendation,
    required this.timestamp,
    this.type = InsightType.simple,
    this.sources = const [],
  });

  factory AIInsight.fromJson(Map<String, dynamic> json) {
    final typeString = json['type'] as String? ?? 'simple';
    final insightType = typeString == 'correlative'
        ? InsightType.correlative
        : InsightType.simple;

    return AIInsight(
      id: json['id'] as String,
      title: json['title'] as String,
      snippet: json['snippet'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      category: json['category'] as String,
      dataPoints: (json['data_points'] as List).cast<String>(),
      recommendation: Recommendation.fromJson(
          json['recommendation'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: insightType,
      sources: (json['sources'] as List?)?.cast<String>() ?? [],
    );
  }
}

class Recommendation {
  final String why;
  final String nextSteps;

  Recommendation({required this.why, required this.nextSteps});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      why: json['why'] as String,
      nextSteps: json['next_steps'] as String,
    );
  }
}

/// AI Chat Models
class AIChatMessage {
  final String role; // 'user' or 'assistant'
  final String content;
  final DateTime timestamp;

  AIChatMessage({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
      };
}

class AIChatResponse {
  final String message;
  final double confidence;
  final List<AIAction> suggestedActions;

  AIChatResponse({
    required this.message,
    required this.confidence,
    required this.suggestedActions,
  });

  factory AIChatResponse.fromJson(Map<String, dynamic> json) {
    return AIChatResponse(
      message: json['response'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      suggestedActions: (json['suggested_actions'] as List?)
              ?.map((a) => AIAction.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class AIAction {
  final String type;
  final String label;
  final Map<String, dynamic> data;

  AIAction({
    required this.type,
    required this.label,
    required this.data,
  });

  factory AIAction.fromJson(Map<String, dynamic> json) {
    return AIAction(
      type: json['type'] as String,
      label: json['label'] as String,
      data: json['data'] as Map<String, dynamic>,
    );
  }
}
