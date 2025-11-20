import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

/// Analytics service for tracking user events
/// Respects user privacy preferences and can be disabled
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final Logger _logger = Logger();
  bool _enabled = true;
  final List<AnalyticsEvent> _eventQueue = [];

  /// Initialize analytics service
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(AppConstants.storageKeyAnalyticsEnabled) ?? true;

    // Process queued events if any
    if (_eventQueue.isNotEmpty && _enabled) {
      await _processEventQueue();
    }
  }

  /// Check if analytics is enabled
  bool get isEnabled => _enabled;

  /// Enable or disable analytics
  Future<void> setEnabled(bool enabled) async {
    _enabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.storageKeyAnalyticsEnabled, enabled);

    if (enabled && _eventQueue.isNotEmpty) {
      await _processEventQueue();
    }
  }

  /// Track an event
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    final event = AnalyticsEvent(
      name: eventName,
      parameters: parameters ?? {},
      timestamp: DateTime.now(),
    );

    if (!_enabled) {
      if (kDebugMode) {
        _logger.d('Analytics disabled, event queued: $eventName');
      }
      _eventQueue.add(event);
      return;
    }

    await _sendEvent(event);
  }

  /// Track screen view
  Future<void> trackScreenView(String screenName) async {
    await trackEvent('screen_view', parameters: {'screen_name': screenName});
  }

  /// Track user action
  Future<void> trackAction(String action,
      {Map<String, dynamic>? parameters}) async {
    await trackEvent('user_action', parameters: {
      'action': action,
      ...?parameters,
    });
  }

  /// Track onboarding completion
  Future<void> trackOnboardingComplete() async {
    await trackEvent('onboarding_complete');
  }

  /// Track provider connection
  Future<void> trackProviderConnected(String providerName) async {
    await trackEvent('provider_connected', parameters: {
      'provider': providerName,
    });
  }

  /// Track goal completion
  Future<void> trackGoalComplete(String goalId, String goalType) async {
    await trackEvent('goal_complete', parameters: {
      'goal_id': goalId,
      'goal_type': goalType,
    });
  }

  /// Send event to analytics backend
  Future<void> _sendEvent(AnalyticsEvent event) async {
    try {
      if (kDebugMode) {
        _logger.d(
            'Analytics event: ${event.name} with params: ${event.parameters}');
      }

      // TODO: Implement actual analytics backend integration
      // Example: Firebase Analytics, Mixpanel, Amplitude, etc.
      // await _analyticsBackend.logEvent(event.name, event.parameters);

      // For now, just log to console in debug mode
      if (kDebugMode) {
        _logger.i('📊 Analytics: ${event.name}');
      }
    } catch (e) {
      _logger.e('Failed to send analytics event: $e');
      // Queue event for retry
      _eventQueue.add(event);
    }
  }

  /// Process queued events
  Future<void> _processEventQueue() async {
    final events = List<AnalyticsEvent>.from(_eventQueue);
    _eventQueue.clear();

    for (final event in events) {
      await _sendEvent(event);
    }
  }

  /// Get queued events count (for debug screen)
  int get queuedEventsCount => _eventQueue.length;
}

/// Analytics event model
class AnalyticsEvent {
  final String name;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;

  AnalyticsEvent({
    required this.name,
    required this.parameters,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'parameters': parameters,
        'timestamp': timestamp.toIso8601String(),
      };
}
