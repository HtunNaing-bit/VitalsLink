import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

/// Storage service for local data persistence
/// Uses Hive for efficient local storage
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final Logger _logger = Logger();
  final Map<String, Box> _boxes = {};

  /// Initialize storage service
  Future<void> initialize() async {
    try {
      // Open all required boxes
      _boxes[AppConstants.boxNameProfile] =
          await Hive.openBox(AppConstants.boxNameProfile);
      _boxes[AppConstants.boxNameMetrics] =
          await Hive.openBox(AppConstants.boxNameMetrics);
      _boxes[AppConstants.boxNameGoals] =
          await Hive.openBox(AppConstants.boxNameGoals);
      _boxes[AppConstants.boxNameChatHistory] =
          await Hive.openBox(AppConstants.boxNameChatHistory);
      _boxes[AppConstants.boxNameNotifications] =
          await Hive.openBox(AppConstants.boxNameNotifications);
      _boxes[AppConstants.boxNameBackups] =
          await Hive.openBox(AppConstants.boxNameBackups);
    } catch (e) {
      _logger.e('Failed to initialize storage: $e');
      rethrow;
    }
  }

  /// Get a box by name
  Box _getBox(String boxName) {
    final box = _boxes[boxName];
    if (box == null) {
      throw Exception('Box $boxName not initialized');
    }
    return box;
  }

  /// Save data to a box
  Future<void> save(String boxName, String key, dynamic value) async {
    try {
      final box = _getBox(boxName);
      if (value is Map || value is List) {
        await box.put(key, jsonEncode(value));
      } else {
        await box.put(key, value);
      }
    } catch (e) {
      _logger.e('Failed to save $key to $boxName: $e');
      rethrow;
    }
  }

  /// Get data from a box
  T? get<T>(String boxName, String key) {
    try {
      final box = _getBox(boxName);
      final value = box.get(key);

      if (value == null) return null;

      if (T == Map || T == List) {
        return jsonDecode(value as String) as T;
      }

      return value as T;
    } catch (e) {
      _logger.e('Failed to get $key from $boxName: $e');
      return null;
    }
  }

  /// Delete data from a box
  Future<void> delete(String boxName, String key) async {
    try {
      final box = _getBox(boxName);
      await box.delete(key);
    } catch (e) {
      _logger.e('Failed to delete $key from $boxName: $e');
      rethrow;
    }
  }

  /// Clear all data from a box
  Future<void> clear(String boxName) async {
    try {
      final box = _getBox(boxName);
      await box.clear();
    } catch (e) {
      _logger.e('Failed to clear $boxName: $e');
      rethrow;
    }
  }

  /// Get all keys from a box
  List<String> getAllKeys(String boxName) {
    try {
      final box = _getBox(boxName);
      return box.keys.cast<String>().toList();
    } catch (e) {
      _logger.e('Failed to get keys from $boxName: $e');
      return [];
    }
  }

  /// Get pending changes (for sync)
  Future<List<Map<String, dynamic>>> getPendingChanges() async {
    // TODO: Implement logic to track pending changes
    // This would track items that have been modified locally but not synced
    return [];
  }

  /// Mark changes as synced
  Future<void> markChangesAsSynced(List<Map<String, dynamic>> changes) async {
    // TODO: Implement logic to mark changes as synced
    // This would update the sync status of items
  }

  /// Export all data (for backup)
  Future<Map<String, dynamic>> exportAllData() async {
    final export = <String, dynamic>{};

    for (final entry in _boxes.entries) {
      final boxName = entry.key;
      final box = entry.value;
      final boxData = <String, dynamic>{};

      for (final key in box.keys) {
        boxData[key.toString()] = box.get(key);
      }

      export[boxName] = boxData;
    }

    return export;
  }

  /// Import data (for restore)
  Future<void> importData(Map<String, dynamic> data) async {
    for (final entry in data.entries) {
      final boxName = entry.key;
      final boxData = entry.value as Map<String, dynamic>;

      if (_boxes.containsKey(boxName)) {
        final box = _getBox(boxName);
        await box.clear();

        for (final dataEntry in boxData.entries) {
          await box.put(dataEntry.key, dataEntry.value);
        }
      }
    }
  }

  /// Get storage size (for debug)
  int getStorageSize(String boxName) {
    try {
      final box = _getBox(boxName);
      return box.length;
    } catch (e) {
      return 0;
    }
  }
}
