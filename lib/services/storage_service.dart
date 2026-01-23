import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('Initialize StorageService first');
});

class StorageService {
  static const String _keyStoragePath = 'storage_path';
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  /// Get the current storage directory path
  /// Returns null if using default internal storage
  String? getCustomStoragePath() {
    return _prefs.getString(_keyStoragePath);
  }

  /// Set a custom storage path
  Future<void> setCustomStoragePath(String path) async {
    await _prefs.setString(_keyStoragePath, path);
  }

  /// Reset to default storage
  Future<void> resetToDefault() async {
    await _prefs.remove(_keyStoragePath);
  }

  /// Get the actual directory to save files to
  Future<Directory> getStorageDirectory() async {
    final customPath = getCustomStoragePath();
    if (customPath != null) {
      final dir = Directory(customPath);
      if (await dir.exists()) {
        return dir;
      }
    }
    
    // Default
    final appDir = await getApplicationDocumentsDirectory();
    return Directory(p.join(appDir.path, 'ScanVault'));
  }

  /// Helper to get full path for a new file
  Future<String> getFilePath(String filename) async {
    final dir = await getStorageDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return p.join(dir.path, filename);
  }
}
