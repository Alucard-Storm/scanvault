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

  // Magic header prepended to every encrypted file (4 bytes: 0x45 0x4E 0x43 0x3A = "ENC:")
  static final _encryptedMagic = [0x45, 0x4E, 0x43, 0x3A];

  /// Encrypt a file
  static Future<void> encryptFile(String filePath, String folderId) async {
    try {
      final keyString = await getKeyForFolder(folderId);
      if (keyString == null) {
        throw Exception('Encryption key not found for folder');
      }

      // Skip if already encrypted
      if (await isFileEncrypted(filePath)) return;

      final key = Key.fromBase64(keyString);
      final iv = IV.fromSecureRandom(16);
      final encrypter = Encrypter(AES(key));

      // Read original file
      final file = File(filePath);
      final bytes = await file.readAsBytes();

      // Encrypt
      final encrypted = encrypter.encryptBytes(bytes, iv: iv);

      // Write: magic header (4) + IV (16) + encrypted data
      final encryptedBytes = Uint8List.fromList([
        ..._encryptedMagic,
        ...iv.bytes,
        ...encrypted.bytes,
      ]);
      
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

      // Skip if not actually encrypted
      if (!await isFileEncrypted(filePath)) return;

      final key = Key.fromBase64(keyString);
      final encrypter = Encrypter(AES(key));

      // Read encrypted file
      final file = File(filePath);
      final allBytes = await file.readAsBytes();

      // Skip magic header (4 bytes), extract IV (next 16 bytes)
      final iv = IV(Uint8List.fromList(allBytes.sublist(4, 20)));
      
      // Extract encrypted data (remaining bytes after header + IV)
      final encrypted = Encrypted(Uint8List.fromList(allBytes.sublist(20)));

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

  /// Check if a file is encrypted (checks for magic header "ENC:")
  static Future<bool> isFileEncrypted(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return false;
      
      // Read only the first 4 bytes to check for magic header
      final raf = await file.open();
      final header = await raf.read(4);
      await raf.close();

      if (header.length < 4) return false;
      return header[0] == _encryptedMagic[0] &&
             header[1] == _encryptedMagic[1] &&
             header[2] == _encryptedMagic[2] &&
             header[3] == _encryptedMagic[3];
    } catch (e) {
      return false;
    }
  }
}
