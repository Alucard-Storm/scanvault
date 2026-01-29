// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'Home';

  @override
  String get foldersTab => 'Folders';

  @override
  String get settingsTab => 'Settings';

  @override
  String get scanPage => 'Scan Page';

  @override
  String get cameraPermissionRequired => 'Camera permission is required';

  @override
  String get noCamerasAvailable => 'No cameras available';

  @override
  String errorScanning(Object error) {
    return 'Error scanning: $error';
  }

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get share => 'Share';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'Translate';

  @override
  String get proFeature => 'Pro Feature';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsStorage => 'Storage location';

  @override
  String get settingsClearCache => 'Clear cache';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicenses => 'Licenses';

  @override
  String get searchHint => 'Search documents...';

  @override
  String get noDocuments => 'No documents yet';

  @override
  String get noDocumentsSubtitle => 'Scan a document to get started';

  @override
  String get scanFab => 'Scan';

  @override
  String get rename => 'Rename';

  @override
  String get moveToFolder => 'Move to Folder';

  @override
  String get moveToRoot => 'None (Root)';

  @override
  String get deleteDocumentTitle => 'Delete Document';

  @override
  String deleteConfirmation(Object name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String deleted(Object name) {
    return '$name deleted';
  }

  @override
  String get movedToRoot => 'Moved to root';

  @override
  String movedTo(Object folderName) {
    return 'Moved to $folderName';
  }

  @override
  String get documentNotFound => 'Document not found';

  @override
  String get editPage => 'Edit Page';

  @override
  String get addPage => 'Add Page';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get tags => 'Tags';

  @override
  String pageCount(Object current, Object total) {
    return 'Page $current of $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count page(s) added successfully';
  }

  @override
  String pageAddFailed(Object error) {
    return 'Failed to add page: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'Export Failed: $error';
  }

  @override
  String get noFolders => 'No folders yet';

  @override
  String get noFoldersAvailable => 'No folders available. Create one first.';

  @override
  String get newFolder => 'New Folder';

  @override
  String get folderName => 'Folder Name';

  @override
  String get create => 'Create';

  @override
  String get editFolder => 'Edit Folder';

  @override
  String get deleteFolderTitle => 'Delete Folder';

  @override
  String get deleteFolderConfirmation =>
      'Delete this folder? Documents inside will be moved to root.';

  @override
  String folderItems(Object count) {
    return '$count items';
  }

  @override
  String get extractedText => 'Extracted Text';

  @override
  String ocrFailed(Object error) {
    return 'OCR Failed: $error';
  }

  @override
  String get textSaved => 'Text saved to document';

  @override
  String saveFailed(Object error) {
    return 'Failed to save: $error';
  }

  @override
  String get saveToDocument => 'Save to Document';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get copy => 'Copy';

  @override
  String get noTextExtracted => 'No text extracted...';

  @override
  String get sourceText => 'Source Text';

  @override
  String get translation => 'Translation';

  @override
  String get savingDocument => 'Saving Document...';

  @override
  String get launchingScanner => 'Launching Scanner...';

  @override
  String saveDocumentFailed(Object error) {
    return 'Failed to save document: $error';
  }

  @override
  String get editTitle => 'Edit';

  @override
  String get done => 'Done';

  @override
  String errorLoadingImage(Object error) {
    return 'Error loading image: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'Error applying filter: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'Failed to save changes: $error';
  }

  @override
  String get noImage => 'No image';

  @override
  String get deleteTagTitle => 'Delete Tag';

  @override
  String deleteTagConfirmation(Object tagName) {
    return 'Are you sure you want to delete \"$tagName\"?';
  }

  @override
  String get selectTags => 'Select Tags';

  @override
  String get manageTags => 'Manage Tags';

  @override
  String get noTags => 'No tags created yet';

  @override
  String get newTagName => 'New Tag Name';

  @override
  String errorGeneric(Object error) {
    return 'Error: $error';
  }

  @override
  String get renameFolder => 'Rename Folder';

  @override
  String get emptyFolder => 'Empty Folder';

  @override
  String get exportPdfTitle => 'Export PDF';

  @override
  String get includeOcrText => 'Include OCR Text';

  @override
  String get includeOcrTextSubtitle =>
      'Adds a separate page with extracted text';

  @override
  String get pagesHeader => 'Pages';

  @override
  String get deselectAll => 'Deselect All';

  @override
  String get selectAll => 'Select All';

  @override
  String pageIndex(Object number) {
    return 'Page $number';
  }

  @override
  String get exportAction => 'Export';

  @override
  String get exportFormat => 'Format';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'Images';

  @override
  String scannedImagesFrom(Object name) {
    return 'Scanned images from $name';
  }
}
