// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'ಮುಖಪುಟ';

  @override
  String get foldersTab => 'ಫೋಲ್ಡರ್‌ಗಳು';

  @override
  String get settingsTab => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get scanPage => 'ಸ್ಕ್ಯಾನ್ ಪುಟ';

  @override
  String get cameraPermissionRequired => 'ಕ್ಯಾಮೆರಾ ಅನುಮತಿ ಅಗತ್ಯವಿದೆ';

  @override
  String get noCamerasAvailable => 'ಕ್ಯಾಮೆರಾಗಳು ಲಭ್ಯವಿಲ್ಲ';

  @override
  String errorScanning(Object error) {
    return 'ಸ್ಕ್ಯಾನಿಂಗ್ ದೋಷ: $error';
  }

  @override
  String get save => 'ಉಳಿಸಿ';

  @override
  String get cancel => 'ರದ್ದುಮಾಡಿ';

  @override
  String get delete => 'ಅಳಿಸಿ';

  @override
  String get edit => 'ತಿದ್ದಿ';

  @override
  String get share => 'ಹಂಚಿಕೊಳ್ಳಿ';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'ಅನುವಾದ';

  @override
  String get proFeature => 'ಪ್ರೊ ವೈಶಿಷ್ಟ್ಯ';

  @override
  String get settingsLanguage => 'ಭಾಷೆ';

  @override
  String get settingsTheme => 'ಥೀಮ್';

  @override
  String get settingsStorage => 'ಶೇಖರಣಾ ಸ್ಥಳ';

  @override
  String get settingsClearCache => 'ಕ್ಯಾಶ್ ತೆರವುಗೊಳಿಸಿ';

  @override
  String get settingsAbout => 'ಕುರಿತು';

  @override
  String get settingsVersion => 'ಆವೃತ್ತಿ';

  @override
  String get settingsLicenses => 'ಪರವಾನಗಿಗಳು';

  @override
  String get searchHint => 'ದಾಖಲೆಗಳನ್ನು ಹುಡುಕಿ...';

  @override
  String get noDocuments => 'ಯಾವುದೇ ದಾಖಲೆಗಳಿಲ್ಲ';

  @override
  String get noDocumentsSubtitle => 'ಪ್ರಾರಂಭಿಸಲು ದಾಖಲೆಯನ್ನು ಸ್ಕ್ಯಾನ್ ಮಾಡಿ';

  @override
  String get scanFab => 'ಸ್ಕ್ಯಾನ್';

  @override
  String get rename => 'ಮರುಹೆಸರಿಸಿ';

  @override
  String get moveToFolder => 'ಫೋಲ್ಡರ್‌ಗೆ ಸರಿಸಿ';

  @override
  String get moveToRoot => 'ಯಾವುದೂ ಇಲ್ಲ (ರೂಟ್)';

  @override
  String get deleteDocumentTitle => 'ದಾಖಲೆಯನ್ನು ಅಳಿಸಿ';

  @override
  String deleteConfirmation(Object name) {
    return '\"$name\" ಅನ್ನು ಅಳಿಸಲು ನೀವು ಖಚಿತವಾಗಿದ್ದೀರಾ?';
  }

  @override
  String deleted(Object name) {
    return '$name ಅಳಿಸಲಾಗಿದೆ';
  }

  @override
  String get movedToRoot => 'ರೂಟ್‌ಗೆ ಸರಿಸಲಾಗಿದೆ';

  @override
  String movedTo(Object folderName) {
    return '$folderName ಗೆ ಸರಿಸಲಾಗಿದೆ';
  }

  @override
  String get documentNotFound => 'ದಾಖಲೆ ಕಂಡುಬಂದಿಲ್ಲ';

  @override
  String get editPage => 'ಪುಟವನ್ನು ಸಂಪಾದಿಸಿ';

  @override
  String get addPage => 'ಪುಟವನ್ನು ಸೇರಿಸಿ';

  @override
  String get sharePdf => 'PDF ಹಂಚಿಕೊಳ್ಳಿ';

  @override
  String get tags => 'ಟ್ಯಾಗ್‌ಗಳು';

  @override
  String pageCount(Object current, Object total) {
    return 'ಪುಟ $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count ಪುಟಗಳನ್ನು ಯಶಸ್ವಿಯಾಗಿ ಸೇರಿಸಲಾಗಿದೆ';
  }

  @override
  String pageAddFailed(Object error) {
    return 'ಪುಟ ಸೇರಿಸಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'ರಫ್ತು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get noFolders => 'ಯಾವುದೇ ಫೋಲ್ಡರ್‌ಗಳಿಲ್ಲ';

  @override
  String get noFoldersAvailable =>
      'ಯಾವುದೇ ಫೋಲ್ಡರ್‌ಗಳು ಲಭ್ಯವಿಲ್ಲ. ಮೊದಲು ಒಂದನ್ನು ರಚಿಸಿ.';

  @override
  String get newFolder => 'ಹೊಸ ಫೋಲ್ಡರ್';

  @override
  String get folderName => 'ಫೋಲ್ಡರ್ ಹೆಸರು';

  @override
  String get create => 'ರಚಿಸಿ';

  @override
  String get editFolder => 'ಫೋಲ್ಡರ್ ಸಂಪಾದಿಸಿ';

  @override
  String get deleteFolderTitle => 'ಫೋಲ್ಡರ್ ಅಳಿಸಿ';

  @override
  String get deleteFolderConfirmation =>
      'ಈ ಫೋಲ್ಡರ್ ಅಳಿಸುವುದೇ? ಒಳಗಿನ ದಾಖಲೆಗಳನ್ನು ರೂಟ್‌ಗೆ ಸರಿಸಲಾಗುವುದು.';

  @override
  String folderItems(Object count) {
    return '$count ಐಟಂಗಳು';
  }

  @override
  String get extractedText => 'ಹೊರತೆಗೆಯಲಾದ ಪಠ್ಯ';

  @override
  String ocrFailed(Object error) {
    return 'OCR ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get textSaved => 'ಪಠ್ಯವನ್ನು ದಾಖಲೆಗೆ ಉಳಿಸಲಾಗಿದೆ';

  @override
  String saveFailed(Object error) {
    return 'ಉಳಿಸಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get saveToDocument => 'ದಾಖಲೆಗೆ ಉಳಿಸಿ';

  @override
  String get copiedToClipboard => 'ಕ್ಲಿಪ್‌ಬೋರ್ಡ್‌ಗೆ ನಕಲಿಸಲಾಗಿದೆ';

  @override
  String get copy => 'ನಕಲಿಸಿ';

  @override
  String get noTextExtracted => 'ಯಾವುದೇ ಪಠ್ಯ ಹೊರತೆಗೆಯಲಾಗಿಲ್ಲ...';

  @override
  String get sourceText => 'ಮೂಲ ಪಠ್ಯ';

  @override
  String get translation => 'ಅನುವಾದ';

  @override
  String get savingDocument => 'ದಾಖಲೆಯನ್ನು ಉಳಿಸಲಾಗುತ್ತಿದೆ...';

  @override
  String get launchingScanner => 'ಸ್ಕ್ಯಾನರ್ ಪ್ರಾರಂಭಿಸಲಾಗುತ್ತಿದೆ...';

  @override
  String saveDocumentFailed(Object error) {
    return 'ದಾಖಲೆ ಉಳಿಸಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get editTitle => 'ತಿದ್ದಿ';

  @override
  String get done => 'ಮುಗಿದಿದೆ';

  @override
  String errorLoadingImage(Object error) {
    return 'ಚಿತ್ರ ಲೋಡ್ ಮಾಡುವಲ್ಲಿ ದೋಷ: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'ಫಿಲ್ಟರ್ ಅನ್ವಯಿಸುವಲ್ಲಿ ದೋಷ: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'ಬದಲಾವಣೆಗಳನ್ನು ಉಳಿಸಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get noImage => 'ಯಾವುದೇ ಚಿತ್ರವಿಲ್ಲ';

  @override
  String get deleteTagTitle => 'ಟ್ಯಾಗ್ ಅಳಿಸಿ';

  @override
  String deleteTagConfirmation(Object tagName) {
    return '\"$tagName\" ಟ್ಯಾಗ್ ಅನ್ನು ಅಳಿಸಲು ನೀವು ಖಚಿತವಾಗಿದ್ದೀರಾ?';
  }

  @override
  String get selectTags => 'ಟ್ಯಾಗ್‌ಗಳನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get manageTags => 'ಟ್ಯಾಗ್‌ಗಳನ್ನು ನಿರ್ವಹಿಸಿ';

  @override
  String get noTags => 'ಇನ್ನೂ ಯಾವುದೇ ಟ್ಯಾಗ್‌ಗಳನ್ನು ರಚಿಸಲಾಗಿಲ್ಲ';

  @override
  String get newTagName => 'ಹೊಸ ಟ್ಯಾಗ್ ಹೆಸರು';

  @override
  String errorGeneric(Object error) {
    return 'ದೋಷ: $error';
  }

  @override
  String get renameFolder => 'ಫೋಲ್ಡರ್ ಮರುಹೆಸರಿಸಿ';

  @override
  String get emptyFolder => 'ಖಾಲಿ ಫೋಲ್ಡರ್';

  @override
  String get exportPdfTitle => 'PDF ರಫ್ತು ಮಾಡಿ';

  @override
  String get includeOcrText => 'OCR ಪಠ್ಯವನ್ನು ಸೇರಿಸಿ';

  @override
  String get includeOcrTextSubtitle =>
      'ಹೊರತೆಗೆಯಲಾದ ಪಠ್ಯದೊಂದಿಗೆ ಪ್ರತ್ಯೇಕ ಪುಟವನ್ನು ಸೇರಿಸುತ್ತದೆ';

  @override
  String get pagesHeader => 'ಪುಟಗಳು';

  @override
  String get deselectAll => 'ಎಲ್ಲವನ್ನೂ ಆಯ್ಕೆ ರದ್ದುಮಾಡಿ';

  @override
  String get selectAll => 'ಎಲ್ಲವನ್ನೂ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String pageIndex(Object number) {
    return 'ಪುಟ $number';
  }

  @override
  String get exportAction => 'ರಫ್ತು';

  @override
  String get exportFormat => 'ಸ್ವರೂಪ';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'ಚಿತ್ರಗಳು';

  @override
  String scannedImagesFrom(Object name) {
    return '$name ನಿಂದ ಸ್ಕ್ಯಾನ್ ಮಾಡಿದ ಚಿತ್ರಗಳು';
  }

  @override
  String get settingsAppearance => 'ಗೋಚರತೆ';

  @override
  String get themeSystem => 'ಸಿಸ್ಟಮ್ ಡೀಫಾಲ್ಟ್';

  @override
  String get themeLight => 'ಲೈಟ್';

  @override
  String get themeDark => 'ಡಾರ್ಕ್';

  @override
  String get settingsStorageHeader => 'ಶೇಖರಣೆ';

  @override
  String get storageInternal => 'ಆಂತರಿಕ ಶೇಖರಣೆ (ಡೀಫಾಲ್ಟ್)';

  @override
  String get resetToDefault => 'ಡೀಫಾಲ್ಟ್‌ಗೆ ಮರುಹೊಂದಿಸಿ';

  @override
  String get freeUpSpace => 'ಸ್ಥಳಾವಕಾಶ ಮುಕ್ತಗೊಳಿಸಿ';

  @override
  String get chooseTheme => 'ಥೀಮ್ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get clearCacheTitle => 'ಕ್ಯಾಶ್ ತೆರವುಗೊಳಿಸಿ';

  @override
  String get clearCacheMessage =>
      'ಇದು ತಾತ್ಕಾಲಿಕ ಫೈಲ್‌ಗಳನ್ನು ಅಳಿಸುತ್ತದೆ. ನಿಮ್ಮ ಉಳಿಸಿದ ದಾಖಲೆಗಳನ್ನು ಅಳಿಸಲಾಗುವುದಿಲ್ಲ. ಮುಂದುವರಿಸುವುದೇ?';

  @override
  String get clear => 'ತೆರವುಗೊಳಿಸಿ';

  @override
  String get cacheCleared => 'ಕ್ಯಾಶ್ ಅನ್ನು ಯಶಸ್ವಿಯಾಗಿ ತೆರವುಗೊಳಿಸಲಾಗಿದೆ';

  @override
  String cacheClearFailed(Object error) {
    return 'ಕ್ಯಾಶ್ ತೆರವುಗೊಳಿಸಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get storageLocation => 'ಶೇಖರಣಾ ಸ್ಥಳ';

  @override
  String get storageDefault => 'ಡೀಫಾಲ್ಟ್ (ಆಂತರಿಕ)';

  @override
  String get storageCustom => 'ಕಸ್ಟಮ್ ಫೋಲ್ಡರ್ ಆಯ್ಕೆಮಾಡಿ...';

  @override
  String storageWriteError(Object error) {
    return 'ಈ ಫೋಲ್ಡರ್‌ಗೆ ಬರೆಯಲು ಸಾಧ್ಯವಿಲ್ಲ: $error';
  }

  @override
  String get chooseLanguage => 'ಭಾಷೆ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get moreOptions => 'ಹೆಚ್ಚಿನ ಆಯ್ಕೆಗಳು';

  @override
  String get useSystemColor => 'ಸಿಸ್ಟಮ್ ಬಣ್ಣಗಳನ್ನು ಬಳಸಿ';
}
