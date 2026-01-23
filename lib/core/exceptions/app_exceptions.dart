/// Custom exceptions for ScanVault app
library;

/// Base exception for all app exceptions
class ScanVaultException implements Exception {
  final String message;
  final dynamic originalError;

  ScanVaultException(this.message, [this.originalError]);

  @override
  String toString() => 'ScanVaultException: $message';
}

/// Exception thrown when camera operations fail
class ScanCameraException extends ScanVaultException {
  ScanCameraException(super.message, [super.originalError]);

  @override
  String toString() => 'ScanCameraException: $message';
}

/// Exception thrown when image processing fails
class ImageProcessingException extends ScanVaultException {
  ImageProcessingException(super.message, [super.originalError]);

  @override
  String toString() => 'ImageProcessingException: $message';
}

/// Exception thrown when OCR operations fail
class OcrException extends ScanVaultException {
  OcrException(super.message, [super.originalError]);

  @override
  String toString() => 'OcrException: $message';
}

/// Exception thrown when translation operations fail
class TranslationException extends ScanVaultException {
  TranslationException(super.message, [super.originalError]);

  @override
  String toString() => 'TranslationException: $message';
}

/// Exception thrown when export operations fail
class ExportException extends ScanVaultException {
  ExportException(super.message, [super.originalError]);

  @override
  String toString() => 'ExportException: $message';
}

/// Exception thrown when database operations fail
class DatabaseException extends ScanVaultException {
  DatabaseException(super.message, [super.originalError]);

  @override
  String toString() => 'DatabaseException: $message';
}

/// Exception thrown when storage/file operations fail
class StorageException extends ScanVaultException {
  StorageException(super.message, [super.originalError]);

  @override
  String toString() => 'StorageException: $message';
}
