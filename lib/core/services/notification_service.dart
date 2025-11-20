import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

/// Notification service for managing in-app and push notifications
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Initialize notification service
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'vitalslink_goals',
        channelName: 'VitalsLink Goals',
        channelDescription: 'Goal reminders and AI nudges',
        importance: NotificationImportance.Max,
        defaultColor: const Color(0xFF3B82F6),
        ledColor: const Color(0xFF7C3AED),
      ),
      NotificationChannel(
        channelKey: 'vitalslink_reminders',
        channelName: 'VitalsLink Reminders',
        channelDescription: 'Health reminders and notifications',
        importance: NotificationImportance.High,
        defaultColor: const Color(0xFF10B981),
        ledColor: const Color(0xFF059669),
      ),
      NotificationChannel(
        channelKey: 'vitalslink_sync',
        channelName: 'VitalsLink Sync',
        channelDescription: 'Data sync status notifications',
        importance: NotificationImportance.Low,
        defaultColor: const Color(0xFF6B7280),
        ledColor: const Color(0xFF4B5563),
      ),
    ]);
  }

  /// Schedule a goal reminder
  static Future<void> scheduleGoalReminder(
    String title,
    String body, {
    DateTime? scheduledTime,
  }) async {
    final notificationId = DateTime.now().millisecondsSinceEpoch % 100000;

    if (scheduledTime != null) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'vitalslink_goals',
          title: title,
          body: body,
        ),
        schedule: NotificationCalendar.fromDate(date: scheduledTime),
      );
    } else {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'vitalslink_goals',
          title: title,
          body: body,
        ),
      );
    }
  }

  /// Schedule a reminder
  static Future<void> scheduleReminder(
    String title,
    String body,
    DateTime scheduledTime,
  ) async {
    final notificationId = DateTime.now().millisecondsSinceEpoch % 100000;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'vitalslink_reminders',
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar.fromDate(date: scheduledTime),
    );
  }

  /// Cancel a scheduled notification
  static Future<void> cancelNotification(int notificationId) async {
    await AwesomeNotifications().cancel(notificationId);
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  /// Handle action received
  static Future<void> onActionReceived(ReceivedAction action) async {
    // TODO: Handle deep links or quick actions
    // Example: Navigate to specific screen based on action payload
  }
}
