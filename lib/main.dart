import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:vitalslink_flutter/core/services/notification_service.dart';
import 'package:vitalslink_flutter/core/services/analytics_service.dart';
import 'package:vitalslink_flutter/core/services/storage_service.dart';
import 'package:vitalslink_flutter/core/services/sync_service.dart';
import 'package:vitalslink_flutter/core/constants.dart';
import 'package:vitalslink_flutter/vitalslink_app.dart';
import 'package:vitalslink_flutter/providers/user_provider.dart';
import 'package:vitalslink_flutter/src/services/review_service.dart';
import 'package:vitalslink_flutter/src/services/telehealth_service.dart';
import 'package:vitalslink_flutter/src/utils/style_tokens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await NotificationService.initialize();
  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationService.onActionReceived,
  );

  await Hive.initFlutter();
  final profileBox = await Hive.openBox(AppConstants.boxNameProfile);

  // Initialize storage service
  final storageService = StorageService();
  await storageService.initialize();

  // Initialize analytics
  await AnalyticsService().initialize();

  // Initialize sync service
  final syncService = SyncService();
  await syncService.initialize();

  // Initialize new services
  await ReviewService().initialize();
  await TelehealthService().initialize();
  await ThemeManager().initialize();

  runApp(
    ProviderScope(
      overrides: [userBoxProvider.overrideWithValue(profileBox)],
      child: const VitalsLinkApp(),
    ),
  );
}
