import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'storage_service.dart';

/// Sync service for managing data synchronization
/// Handles online/offline states, conflict resolution, and background sync
class SyncService {
  static final SyncService _instance = SyncService._internal();
  factory SyncService() => _instance;
  SyncService._internal();

  final Logger _logger = Logger();
  final StorageService _storage = StorageService();
  Timer? _syncTimer;
  bool _isOnline = true;
  bool _isSyncing = false;
  DateTime? _lastSyncTime;

  /// Stream controller for sync status
  final _syncStatusController = StreamController<SyncStatus>.broadcast();
  Stream<SyncStatus> get syncStatusStream => _syncStatusController.stream;

  /// Initialize sync service
  Future<void> initialize() async {
    await _loadLastSyncTime();
    await _checkConnectivity();
    _startPeriodicSync();
  }

  /// Check if device is online
  bool get isOnline => _isOnline;

  /// Check if currently syncing
  bool get isSyncing => _isSyncing;

  /// Get last sync time
  DateTime? get lastSyncTime => _lastSyncTime;

  /// Manually trigger sync
  Future<SyncResult> syncNow({bool force = false}) async {
    if (_isSyncing && !force) {
      _logger.w('Sync already in progress');
      return SyncResult(
        success: false,
        message: 'Sync already in progress',
      );
    }

    if (!_isOnline) {
      _logger.w('Device is offline, cannot sync');
      return SyncResult(
        success: false,
        message: 'Device is offline',
        isOffline: true,
      );
    }

    _isSyncing = true;
    _syncStatusController.add(SyncStatus.syncing);

    try {
      // Get local changes
      final localChanges = await _storage.getPendingChanges();

      if (localChanges.isEmpty) {
        _logger.d('No local changes to sync');
        await _fetchRemoteChanges();
        _isSyncing = false;
        _syncStatusController.add(SyncStatus.idle);
        return SyncResult(success: true, message: 'Already up to date');
      }

      // Upload local changes
      await _uploadChanges(localChanges);

      // Fetch remote changes
      await _fetchRemoteChanges();

      // Resolve conflicts if any
      await _resolveConflicts();

      // Mark sync as complete
      _lastSyncTime = DateTime.now();
      await _saveLastSyncTime();
      await _storage.markChangesAsSynced(localChanges);

      _isSyncing = false;
      _syncStatusController.add(SyncStatus.idle);

      return SyncResult(
        success: true,
        message: 'Sync completed successfully',
        itemsSynced: localChanges.length,
      );
    } catch (e) {
      _logger.e('Sync failed: $e');
      _isSyncing = false;
      _syncStatusController.add(SyncStatus.error);

      return SyncResult(
        success: false,
        message: 'Sync failed: ${e.toString()}',
      );
    }
  }

  /// Upload local changes to server
  Future<void> _uploadChanges(List<Map<String, dynamic>> changes) async {
    // TODO: Implement actual API call to upload changes
    // Example:
    // final response = await dio.post(
    //   AppConstants.apiSyncEndpoint,
    //   data: {'changes': changes},
    // );

    if (kDebugMode) {
      _logger.d('Uploading ${changes.length} changes to server');
    }

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Fetch remote changes from server
  Future<void> _fetchRemoteChanges() async {
    // TODO: Implement actual API call to fetch changes
    // Example:
    // final response = await dio.get(
    //   AppConstants.apiSyncEndpoint,
    //   queryParameters: {'since': _lastSyncTime?.toIso8601String()},
    // );

    if (kDebugMode) {
      _logger.d(
          'Fetching remote changes since ${_lastSyncTime?.toIso8601String()}');
    }

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  /// Resolve conflicts between local and remote data
  Future<void> _resolveConflicts() async {
    // TODO: Implement conflict resolution logic
    // Strategy: prefer latest timestamp, or user choice
    if (kDebugMode) {
      _logger.d('Resolving conflicts');
    }
  }

  /// Start periodic sync
  void _startPeriodicSync() {
    _syncTimer?.cancel();

    final interval = _getSyncInterval();
    _syncTimer = Timer.periodic(
      Duration(seconds: interval),
      (_) => syncNow(),
    );
  }

  /// Get sync interval based on battery/network conditions
  int _getSyncInterval() {
    // TODO: Check battery level and adjust interval
    // For now, use normal interval
    return AppConstants.syncIntervalNormal;
  }

  /// Check connectivity
  Future<void> _checkConnectivity() async {
    // TODO: Implement actual connectivity check
    // Example: connectivity_plus package
    _isOnline = true; // Placeholder
  }

  /// Load last sync time from storage
  Future<void> _loadLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString('last_sync_time');
    if (timestamp != null) {
      _lastSyncTime = DateTime.parse(timestamp);
    }
  }

  /// Save last sync time to storage
  Future<void> _saveLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'last_sync_time',
      _lastSyncTime?.toIso8601String() ?? '',
    );
  }

  /// Dispose resources
  void dispose() {
    _syncTimer?.cancel();
    _syncStatusController.close();
  }
}

/// Sync status enum
enum SyncStatus {
  idle,
  syncing,
  error,
}

/// Sync result model
class SyncResult {
  final bool success;
  final String message;
  final bool isOffline;
  final int? itemsSynced;

  SyncResult({
    required this.success,
    required this.message,
    this.isOffline = false,
    this.itemsSynced,
  });
}
