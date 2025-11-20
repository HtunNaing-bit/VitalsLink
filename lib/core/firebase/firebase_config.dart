import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';

/// Firebase Configuration
/// Initializes and configures Firebase services
class FirebaseConfig {
  static FirebaseApp? _app;
  static FirebaseAuth? _auth;
  static FirebaseFirestore? _firestore;
  static FirebaseMessaging? _messaging;
  static FirebaseFunctions? _functions;

  /// Initialize Firebase
  static Future<void> initialize() async {
    try {
      _app = await Firebase.initializeApp();
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      _messaging = FirebaseMessaging.instance;
      _functions = FirebaseFunctions.instanceFor();

      // Configure Firestore settings
      _firestore?.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );

      // Request notification permissions
      await _requestNotificationPermissions();
    } catch (e) {
      throw Exception('Failed to initialize Firebase: $e');
    }
  }

  /// Request notification permissions
  static Future<void> _requestNotificationPermissions() async {
    final messaging = _messaging;
    if (messaging == null) return;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get FCM token
      final token = await messaging.getToken();
      if (token != null) {
        // TODO: Save token to backend for push notifications
      }
    }
  }

  /// Get Firebase Auth instance
  static FirebaseAuth get auth {
    if (_auth == null) {
      throw Exception('Firebase not initialized. Call initialize() first.');
    }
    return _auth!;
  }

  /// Get Firestore instance
  static FirebaseFirestore get firestore {
    if (_firestore == null) {
      throw Exception('Firebase not initialized. Call initialize() first.');
    }
    return _firestore!;
  }

  /// Get Firebase Messaging instance
  static FirebaseMessaging get messaging {
    if (_messaging == null) {
      throw Exception('Firebase not initialized. Call initialize() first.');
    }
    return _messaging!;
  }

  /// Get Firebase Functions instance
  static FirebaseFunctions get functions {
    if (_functions == null) {
      throw Exception('Firebase not initialized. Call initialize() first.');
    }
    return _functions!;
  }

  /// Check if Firebase is initialized
  static bool get isInitialized => _app != null;
}

