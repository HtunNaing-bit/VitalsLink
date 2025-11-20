import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/error/exceptions.dart';

/// Secure Storage Data Source
/// Handles secure token storage
class SecureStorageDataSource {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// Write a value
  Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw CacheException('Failed to write to secure storage: $e');
    }
  }

  /// Read a value
  Future<String?> read({required String key}) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw CacheException('Failed to read from secure storage: $e');
    }
  }

  /// Delete a value
  Future<void> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw CacheException('Failed to delete from secure storage: $e');
    }
  }

  /// Delete all values
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw CacheException('Failed to delete all from secure storage: $e');
    }
  }

  /// Check if a key exists
  Future<bool> containsKey({required String key}) async {
    try {
      final value = await _storage.read(key: key);
      return value != null;
    } catch (e) {
      return false;
    }
  }
}

