import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
// import 'package:health/health.dart';  // Temporarily disabled due to dependency conflict

import '../models/health.dart';

/// Health service with platform-aware behavior
/// - Mobile (iOS/Android): Uses health plugin
/// - Web: Falls back to demo/mock data
/// - Mock mode: Can be enabled in settings for testing
class HealthService {
  HealthService({
    bool mockMode = false,
  })  : _mockMode = mockMode || kIsWeb,
        _logger = Logger();

  final bool _mockMode;
  final Logger _logger;

  // Health? _health;  // Temporarily disabled

  /// Initialize health plugin (mobile only)
  Future<void> initialize() async {
    if (_mockMode || kIsWeb) {
      _logger.i('HealthService: Running in mock/demo mode');
      return;
    }

    try {
      // _health = Health();  // Temporarily disabled
      _logger
          .i('HealthService: Running in mock mode (health package disabled)');
    } catch (e, stack) {
      _logger.e('HealthService: Failed to initialize',
          error: e, stackTrace: stack);
      // Fallback to mock mode on error
    }
  }

  /// Request permissions (mobile only, web shows demo message)
  Future<bool> requestPermissions({
    required List<dynamic> types, // Changed from HealthDataType to dynamic
  }) async {
    if (_mockMode || kIsWeb) {
      _logger.i('HealthService: Permissions requested in mock mode');
      return false;
    }

    try {
      // Health package disabled - return false in mock mode
      _logger.i('HealthService: Permissions requested in mock mode');
      return false;
    } catch (e, stack) {
      _logger.e('HealthService: Permission request failed',
          error: e, stackTrace: stack);
      return false;
    }
  }

  /// Fetch health metrics with platform-aware behavior
  Future<List<HealthMetric>> fetchMetrics() async {
    if (_mockMode || kIsWeb) {
      return _getMockMetrics();
    }

    try {
      // Try to fetch real data
      return await _fetchRealMetrics();
    } catch (e, stack) {
      _logger.e('HealthService: Failed to fetch metrics, using mock data',
          error: e, stackTrace: stack);
      return _getMockMetrics();
    }
  }

  /// Fetch real metrics from health plugin
  Future<List<HealthMetric>> _fetchRealMetrics() async {
    // Health package disabled - return mock data
    return _getMockMetrics();
  }

  /// Get mock/demo metrics
  List<HealthMetric> _getMockMetrics() {
    return const [
      HealthMetric(
        id: 'sleep',
        label: 'Sleep Score',
        value: '92%',
        delta: '+4% WoW',
      ),
      HealthMetric(
        id: 'hrv',
        label: 'HRV',
        value: '78 ms',
        delta: '↓ 12% after late meals',
      ),
      HealthMetric(
        id: 'hr',
        label: 'Heart Rate',
        value: '64 bpm',
        delta: '-2 today',
      ),
      HealthMetric(
        id: 'activity',
        label: 'Activity',
        value: '11,230 steps',
        delta: '+1,240',
      ),
      HealthMetric(
        id: 'labs',
        label: 'Labs',
        value: 'Optimal',
        delta: 'Updated 2d ago',
      ),
    ];
  }

  /// Fetch trend data
  Future<List<TrendPoint>> fetchTrend() async {
    if (_mockMode || kIsWeb) {
      return _getMockTrend();
    }

    try {
      return await _fetchRealTrend();
    } catch (e, stack) {
      _logger.e('HealthService: Failed to fetch trend, using mock data',
          error: e, stackTrace: stack);
      return _getMockTrend();
    }
  }

  Future<List<TrendPoint>> _fetchRealTrend() async {
    // TODO: Implement real trend fetching from health plugin
    return _getMockTrend();
  }

  List<TrendPoint> _getMockTrend() {
    final now = DateTime.now();
    final random = Random();
    return List.generate(30, (index) {
      final date = now.subtract(Duration(days: 29 - index));
      final jitter = sin(index / 5) * 6 + random.nextDouble();
      final value = 60 + index * 0.5 + jitter;
      return TrendPoint(timestamp: date, value: value);
    });
  }

  /// Fetch forecast data
  Future<List<TrendPoint>> fetchForecast() async {
    if (_mockMode || kIsWeb) {
      return _getMockForecast();
    }

    try {
      return await _fetchRealForecast();
    } catch (e, stack) {
      _logger.e('HealthService: Failed to fetch forecast, using mock data',
          error: e, stackTrace: stack);
      return _getMockForecast();
    }
  }

  Future<List<TrendPoint>> _fetchRealForecast() async {
    // TODO: Implement real forecast (AI-based prediction)
    return _getMockForecast();
  }

  List<TrendPoint> _getMockForecast() {
    final now = DateTime.now();
    final random = Random();
    return List.generate(7, (index) {
      final date = now.add(Duration(days: index + 1));
      final baseValue = 75 + index * 0.3;
      final jitter = sin(index / 2) * 4 + random.nextDouble() * 2;
      final value = baseValue + jitter;
      return TrendPoint(timestamp: date, value: value);
    });
  }

  /// Fetch timeline events
  Future<List<TimelineEvent>> fetchTimeline() async {
    if (_mockMode || kIsWeb) {
      return _getMockTimeline();
    }

    try {
      return await _fetchRealTimeline();
    } catch (e, stack) {
      _logger.e('HealthService: Failed to fetch timeline, using mock data',
          error: e, stackTrace: stack);
      return _getMockTimeline();
    }
  }

  Future<List<TimelineEvent>> _fetchRealTimeline() async {
    // TODO: Fetch from Supabase
    return _getMockTimeline();
  }

  List<TimelineEvent> _getMockTimeline() {
    final now = DateTime.now();
    return [
      TimelineEvent(
        id: 'evt-1',
        title: 'AI Insight: Optimize Late Meals',
        description:
            'Suggested earlier dinner and chamomile tea to improve HRV trends.',
        timestamp: now.subtract(const Duration(hours: 1)),
        icon: '🤖',
      ),
      TimelineEvent(
        id: 'evt-2',
        title: 'Sleep Goal Achieved',
        description: 'Achieved 7-day streak of consistent sleep schedule.',
        timestamp: now.subtract(const Duration(hours: 10)),
        icon: '🌙',
      ),
      TimelineEvent(
        id: 'evt-3',
        title: 'Clinician Shared Report',
        description:
            'Family doctor reviewed lab results and added feedback to Privacy Vault.',
        timestamp: now.subtract(const Duration(days: 1, hours: 4)),
        icon: '👩‍⚕️',
      ),
    ];
  }

  /// Check if running in mock/demo mode
  bool get isMockMode => _mockMode || kIsWeb;

  /// Check if web platform
  bool get isWeb => kIsWeb;
}
