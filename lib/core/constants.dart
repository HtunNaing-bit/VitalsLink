/// Core constants for VitalsLink application
class AppConstants {
  // App information
  static const String appName = 'VitalsLink';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'AI Personal Health OS';

  // Storage keys
  static const String storageKeyOnboardingComplete = 'onboarding_complete';
  static const String storageKeyAuthToken = 'auth_token';
  static const String storageKeyRefreshToken = 'refresh_token';
  static const String storageKeyUserId = 'user_id';
  static const String storageKeyThemeMode = 'theme_mode';
  static const String storageKeyLocale = 'locale';
  static const String storageKeyReducedMotion = 'reduced_motion';
  static const String storageKeyAnalyticsEnabled = 'analytics_enabled';

  // Hive box names
  static const String boxNameProfile = 'profile';
  static const String boxNameMetrics = 'metrics';
  static const String boxNameGoals = 'goals';
  static const String boxNameChatHistory = 'chat_history';
  static const String boxNameNotifications = 'notifications';
  static const String boxNameBackups = 'backups';

  // Sync intervals (in seconds)
  static const int syncIntervalNormal = 300; // 5 minutes
  static const int syncIntervalBatterySaver = 900; // 15 minutes
  static const int syncIntervalOffline = 0; // No sync when offline

  // API endpoints (placeholders - replace with actual endpoints)
  static const String apiBaseUrl = 'https://api.vitalslink.health';
  static const String apiAuthEndpoint = '/auth';
  static const String apiSyncEndpoint = '/sync';
  static const String apiAnalyticsEndpoint = '/analytics';

  // Deep link schemes
  static const String deepLinkScheme = 'vitalslink';
  static const String deepLinkHost = 'vitalslink.health';

  // Animation thresholds
  static const double minScrollVelocity = 50.0;
  static const double maxScrollVelocity = 2000.0;

  // Health data types
  static const List<String> supportedHealthDataTypes = [
    'steps',
    'heart_rate',
    'sleep',
    'activity',
    'stress',
    'hrv',
    'weight',
    'nutrition',
  ];

  // Supported locales
  static const List<String> supportedLocales = ['en', 'my_MM'];
  static const String defaultLocale = 'en';
}

/// Error messages for user-facing errors
class ErrorMessages {
  static const String networkError =
      'Connection failed. Please check your internet.';
  static const String authError = 'Invalid credentials. Please try again.';
  static const String permissionDenied =
      'Permission denied. Please enable in settings.';
  static const String syncError = 'Sync failed. Your data is saved locally.';
  static const String genericError = 'Something went wrong. Please try again.';
}

/// Success messages
class SuccessMessages {
  static const String syncComplete = 'All data synced successfully.';
  static const String backupComplete = 'Backup created successfully.';
  static const String goalComplete = 'Goal achieved! Great work!';
}
