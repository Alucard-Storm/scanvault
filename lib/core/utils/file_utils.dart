import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// File utility functions for document storage
class FileUtils {
  FileUtils._();

  /// Get the app's document storage directory
  static Future<Directory> getDocumentsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final docsDir = Directory(p.join(appDir.path, 'scanned_documents'));
    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }
    return docsDir;
  }

  /// Get the thumbnails cache directory
  static Future<Directory> getThumbnailsDirectory() async {
    final cacheDir = await getTemporaryDirectory();
    final thumbDir = Directory(p.join(cacheDir.path, 'thumbnails'));
    if (!await thumbDir.exists()) {
      await thumbDir.create(recursive: true);
    }
    return thumbDir;
  }

  /// Generate a unique filename with timestamp
  static String generateFilename({String prefix = 'scan', String extension = 'jpg'}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${prefix}_$timestamp.$extension';
  }

  /// Copy file to app storage and return new path
  static Future<String> saveToAppStorage(File file, {String? customName}) async {
    final docsDir = await getDocumentsDirectory();
    final filename = customName ?? generateFilename();
    final newPath = p.join(docsDir.path, filename);
    await file.copy(newPath);
    return newPath;
  }

  /// Delete a file if it exists
  static Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Get file size in human readable format
  static String getReadableFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
