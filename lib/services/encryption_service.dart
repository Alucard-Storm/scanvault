import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;

/// Service for encrypting and decrypting files in locked folders
class EncryptionService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  /// Generate and store encryption key for a folder
  static Future<String> generateKeyForFolder(String folderId) async {
    final key = Key.fromSecureRandom(32); // AES-256
    final keyString = key.base64;
    
    await _storage.write(
      key: 'folder_key_$folderId',
      value: keyString,
    );
    
    return keyString;
  }

  /// Retrieve encryption key for a folder
  static Future<String?> getKeyForFolder(String folderId) async {
    return await _storage.read(key: 'folder_key_$folderId');
  }

  /// Delete encryption key for a folder
  static Future<void> deleteKeyForFolder(String folderId) async {
    await _storage.delete(key: 'folder_key_$folderId');
  }

  /// Encrypt a file
  static Future<void> encryptFile(String filePath, String folderId) async {
    try {
      final keyString = await getKeyForFolder(folderId);
      if (keyString == null) {
        throw Exception('Encryption key not found for folder');
      }

      final key = Key.fromBase64(keyString);
      final iv = IV.fromSecureRandom(16);
      final encrypter = Encrypter(AES(key));

      // Read original file
      final file = File(filePath);
      final bytes = await file.readAsBytes();

      // Encrypt
      final encrypted = encrypter.encryptBytes(bytes, iv: iv);

      // Write encrypted file with IV prepended
      final encryptedBytes = Uint8List.fromList([...iv.bytes, ...encrypted.bytes]);
      
      // Create encrypted file path
      final dir = p.dirname(filePath);
      final basename = p.basenameWithoutExtension(filePath);
      final ext = p.extension(filePath);
      final encryptedPath = p.join(dir, '${basename}_encrypted$ext');
      
      await File(encryptedPath).writeAsBytes(encryptedBytes);
      
      // Delete original file
      await file.delete();
      
      // Rename encrypted file to original name
      await File(encryptedPath).rename(filePath);
    } catch (e) {
      print('Encryption error: $e');
      rethrow;
    }
  }

  /// Decrypt a file
  static Future<void> decryptFile(String filePath, String folderId) async {
    try {
      final keyString = await getKeyForFolder(folderId);
      if (keyString == null) {
        throw Exception('Encryption key not found for folder');
      }

      final key = Key.fromBase64(keyString);
      final encrypter = Encrypter(AES(key));

      // Read encrypted file
      final file = File(filePath);
      final encryptedBytes = await file.readAsBytes();

      // Extract IV (first 16 bytes)
      final iv = IV(Uint8List.fromList(encryptedBytes.sublist(0, 16)));
      
      // Extract encrypted data (remaining bytes)
      final encrypted = Encrypted(Uint8List.fromList(encryptedBytes.sublist(16)));

      // Decrypt
      final decrypted = encrypter.decryptBytes(encrypted, iv: iv);

      // Write decrypted file
      final dir = p.dirname(filePath);
      final basename = p.basenameWithoutExtension(filePath);
      final ext = p.extension(filePath);
      final decryptedPath = p.join(dir, '${basename}_decrypted$ext');
      
      await File(decryptedPath).writeAsBytes(decrypted);
      
      // Delete encrypted file
      await file.delete();
      
      // Rename decrypted file to original name
      await File(decryptedPath).rename(filePath);
    } catch (e) {
      print('Decryption error: $e');
      rethrow;
    }
  }

  /// Encrypt all files in a list
  static Future<void> encryptFiles(List<String> filePaths, String folderId) async {
    for (final filePath in filePaths) {
      await encryptFile(filePath, folderId);
    }
  }

  /// Decrypt all files in a list
  static Future<void> decryptFiles(List<String> filePaths, String folderId) async {
    for (final filePath in filePaths) {
      await decryptFile(filePath, folderId);
    }
  }

  /// Check if a file is encrypted (has IV prepended)
  static Future<bool> isFileEncrypted(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return false;
      
      final bytes = await file.readAsBytes();
      // Check if file is at least 16 bytes (IV size) + some data
      return bytes.length > 16;
    } catch (e) {
      return false;
    }
  }
}
