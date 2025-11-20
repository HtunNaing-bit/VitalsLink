import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../core/firebase/firebase_config.dart';
import '../../../core/error/exceptions.dart';

/// Firebase Cloud Messaging Data Source
/// Handles push notifications
class FCMDataSource {
  final FirebaseMessaging _messaging;

  FCMDataSource() : _messaging = FirebaseConfig.messaging;

  /// Get FCM token
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      throw ServerException('Failed to get FCM token: $e');
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
    } catch (e) {
      throw ServerException('Failed to subscribe to topic: $e');
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
    } catch (e) {
      throw ServerException('Failed to unsubscribe from topic: $e');
    }
  }

  /// Request notification permissions
  Future<NotificationSettings> requestPermissions() async {
    try {
      return await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } catch (e) {
      throw ServerException('Failed to request permissions: $e');
    }
  }

  /// Stream of foreground messages
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  /// Stream of background messages
  Stream<RemoteMessage> get onMessageOpenedApp => FirebaseMessaging.onMessageOpenedApp;
}

/// Background message handler
/// Must be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background message
  // This function must be registered in main.dart
}

