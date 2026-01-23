/// App string constants
class AppStrings {
  AppStrings._();

  // App info
  static const String appName = 'ScanVault';
  static const String appTagline = 'Scan. Enhance. Share.';

  // Navigation
  static const String home = 'Home';
  static const String folders = 'Folders';
  static const String settings = 'Settings';

  // Actions
  static const String scan = 'Scan';
  static const String import = 'Import';
  static const String export = 'Export';
  static const String share = 'Share';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String save = 'Save';
  static const String cancel = 'Cancel';

  // Document operations
  static const String extractText = 'Extract Text';
  static const String translate = 'Translate';
  static const String exportPdf = 'Export as PDF';
  static const String exportDocx = 'Export as DOCX';

  // Filters
  static const String original = 'Original';
  static const String grayscale = 'Grayscale';
  static const String blackAndWhite = 'Black & White';
  static const String magicColor = 'Magic Color';
  static const String document = 'Document';

  // Empty states
  static const String noDocuments = 'No documents yet';
  static const String noDocumentsSubtitle = 'Tap + to scan your first document';
  static const String noFolders = 'No folders yet';

  // Errors
  static const String cameraError = 'Unable to access camera';
  static const String ocrError = 'Failed to extract text';
  static const String translationError = 'Translation failed';
  static const String exportError = 'Export failed';
  static const String storageError = 'Storage access denied';
}
