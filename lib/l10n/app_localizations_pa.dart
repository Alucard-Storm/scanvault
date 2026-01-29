// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'ਹੋਮ';

  @override
  String get foldersTab => 'ਫੋਲਡਰ';

  @override
  String get settingsTab => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get scanPage => 'ਪੇਜ ਸਕੈਨ ਕਰੋ';

  @override
  String get cameraPermissionRequired => 'ਕੈਮਰਾ ਇਜਾਜ਼ਤ ਲੋੜੀਂਦੀ ਹੈ';

  @override
  String get noCamerasAvailable => 'ਕੋਈ ਕੈਮਰਾ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String errorScanning(Object error) {
    return 'ਸਕੈਨਿੰਗ ਗਲਤੀ: $error';
  }

  @override
  String get save => 'ਸੇਵ ਕਰੋ';

  @override
  String get cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get delete => 'ਹਟਾਓ';

  @override
  String get edit => 'ਸੋਧੋ';

  @override
  String get share => 'ਸਾਂਝਾ ਕਰੋ';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'ਅਨੁਵਾਦ';

  @override
  String get proFeature => 'ਪ੍ਰੋ ਫੀਚਰ';

  @override
  String get settingsLanguage => 'ਭਾਸ਼ਾ';

  @override
  String get settingsTheme => 'ਥੀਮ';

  @override
  String get settingsStorage => 'ਸਟੋਰੇਜ ਸਥਾਨ';

  @override
  String get settingsClearCache => 'ਕੈਸ਼ ਸਾਫ਼ ਕਰੋ';

  @override
  String get settingsAbout => 'ਬਾਰੇ';

  @override
  String get settingsVersion => 'ਵਰਜਨ';

  @override
  String get settingsLicenses => 'ਲਾਇਸੈਂਸ';

  @override
  String get searchHint => 'ਦਸਤਾਵੇਜ਼ ਖੋਜੋ...';

  @override
  String get noDocuments => 'ਕੋਈ ਦਸਤਾਵੇਜ਼ ਨਹੀਂ';

  @override
  String get noDocumentsSubtitle => 'ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਇੱਕ ਦਸਤਾਵੇਜ਼ ਸਕੈਨ ਕਰੋ';

  @override
  String get scanFab => 'ਸਕੈਨ';

  @override
  String get rename => 'ਨਾਮ ਬਦਲੋ';

  @override
  String get moveToFolder => 'ਫੋਲਡਰ ਵਿੱਚ ਭੇਜੋ';

  @override
  String get moveToRoot => 'ਕੋਈ ਨਹੀਂ (ਰੂਟ)';

  @override
  String get deleteDocumentTitle => 'ਦਸਤਾਵੇਜ਼ ਮਿਟਾਓ';

  @override
  String deleteConfirmation(Object name) {
    return 'ਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਤੌਰ \'ਤੇ \"$name\" ਨੂੰ ਮਿਟਾਉਣਾ ਚਾਹੁੰਦੇ ਹੋ?';
  }

  @override
  String deleted(Object name) {
    return '$name ਮਿਟਾਇਆ ਗਿਆ';
  }

  @override
  String get movedToRoot => 'ਰੂਟ ਵਿੱਚ ਭੇਜਿਆ ਗਿਆ';

  @override
  String movedTo(Object folderName) {
    return '$folderName ਵਿੱਚ ਭੇਜਿਆ ਗਿਆ';
  }

  @override
  String get documentNotFound => 'ਦਸਤਾਵੇਜ਼ ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get editPage => 'ਪੰਨਾ ਸੰਪਾਦਿਤ ਕਰੋ';

  @override
  String get addPage => 'ਪੰਨਾ ਜੋੜੋ';

  @override
  String get sharePdf => 'PDF ਸਾਂਝਾ ਕਰੋ';

  @override
  String get tags => 'ਟੈਗ';

  @override
  String pageCount(Object current, Object total) {
    return 'ਪੰਨਾ $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count ਪੰਨੇ ਸਫਲਤਾਪੂਰਵਕ ਜੋੜੇ ਗਏ';
  }

  @override
  String pageAddFailed(Object error) {
    return 'ਪੰਨਾ ਜੋੜਨ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'ਨਿਰਯਾਤ ਅਸਫਲ: $error';
  }

  @override
  String get noFolders => 'ਕੋਈ ਫੋਲਡਰ ਨਹੀਂ';

  @override
  String get noFoldersAvailable => 'ਕੋਈ ਫੋਲਡਰ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਪਹਿਲਾਂ ਇੱਕ ਬਣਾਓ।';

  @override
  String get newFolder => 'ਨਵਾਂ ਫੋਲਡਰ';

  @override
  String get folderName => 'ਫੋਲਡਰ ਦਾ ਨਾਮ';

  @override
  String get create => 'ਬਣਾਓ';

  @override
  String get editFolder => 'ਫੋਲਡਰ ਸੰਪਾਦਿਤ ਕਰੋ';

  @override
  String get deleteFolderTitle => 'ਫੋਲਡਰ ਮਿਟਾਓ';

  @override
  String get deleteFolderConfirmation =>
      'ਕੀ ਇਹ ਫੋਲਡਰ ਮਿਟਾਉਣਾ ਹੈ? ਅੰਦਰਲੇ ਦਸਤਾਵੇਜ਼ ਰੂਟ ਵਿੱਚ ਭੇਜੇ ਜਾਣਗੇ।';

  @override
  String folderItems(Object count) {
    return '$count ਆਈਟਮਾਂ';
  }

  @override
  String get extractedText => 'ਕੱਢਿਆ ਗਿਆ ਟੈਕਸਟ';

  @override
  String ocrFailed(Object error) {
    return 'OCR ਅਸਫਲ: $error';
  }

  @override
  String get textSaved => 'ਟੈਕਸਟ ਦਸਤਾਵੇਜ਼ ਵਿੱਚ ਰੱਖਿਅਤ ਕੀਤਾ ਗਿਆ';

  @override
  String saveFailed(Object error) {
    return 'ਰੱਖਿਅਤ ਕਰਨ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String get saveToDocument => 'ਦਸਤਾਵੇਜ਼ ਵਿੱਚ ਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get copiedToClipboard => 'ਕਲਿੱਪਬੋਰਡ \'ਤੇ ਕਾਪੀ ਕੀਤਾ ਗਿਆ';

  @override
  String get copy => 'ਕਾਪੀ';

  @override
  String get noTextExtracted => 'ਕੋਈ ਟੈਕਸਟ ਨਹੀਂ ਕੱਢਿਆ ਗਿਆ...';

  @override
  String get sourceText => 'ਸਰੋਤ ਟੈਕਸਟ';

  @override
  String get translation => 'ਅਨੁਵਾਦ';

  @override
  String get savingDocument => 'ਦਸਤਾਵੇਜ਼ ਰੱਖਿਅਤ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ...';

  @override
  String get launchingScanner => 'ਸਕੈਨਰ ਲਾਂਚ ਹੋ ਰਿਹਾ ਹੈ...';

  @override
  String saveDocumentFailed(Object error) {
    return 'ਦਸਤਾਵੇਜ਼ ਰੱਖਿਅਤ ਕਰਨ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String get editTitle => 'ਸੰਪਾਦਿਤ ਕਰੋ';

  @override
  String get done => 'ਹੋ ਗਿਆ';

  @override
  String errorLoadingImage(Object error) {
    return 'ਚਿੱਤਰ ਲੋਡ ਕਰਨ ਵਿੱਚ ਗਲਤੀ: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'ਫਿਲਟਰ ਲਾਗੂ ਕਰਨ ਵਿੱਚ ਗਲਤੀ: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'ਬਦਲਾਅ ਰੱਖਿਅਤ ਕਰਨ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String get noImage => 'ਕੋਈ ਚਿੱਤਰ ਨਹੀਂ';

  @override
  String get deleteTagTitle => 'ਟੈਗ ਮਿਟਾਓ';

  @override
  String deleteTagConfirmation(Object tagName) {
    return 'ਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਤੌਰ \'ਤੇ \"$tagName\" ਟੈਗ ਨੂੰ ਮਿਟਾਉਣਾ ਚਾਹੁੰਦੇ ਹੋ?';
  }

  @override
  String get selectTags => 'ਟੈਗ ਚੁਣੋ';

  @override
  String get manageTags => 'ਟੈਗ ਪ੍ਰਬੰਧਿਤ ਕਰੋ';

  @override
  String get noTags => 'ਅਜੇ ਤੱਕ ਕੋਈ ਟੈਗ ਨਹੀਂ ਬਣਾਇਆ ਗਿਆ';

  @override
  String get newTagName => 'ਨਵਾਂ ਟੈਗ ਨਾਮ';

  @override
  String errorGeneric(Object error) {
    return 'ਗਲਤੀ: $error';
  }

  @override
  String get renameFolder => 'ਫੋਲਡਰ ਦਾ ਨਾਮ ਬਦਲੋ';

  @override
  String get emptyFolder => 'ਖਾਲੀ ਫੋਲਡਰ';

  @override
  String get exportPdfTitle => 'PDF ਨਿਰਯਾਤ ਕਰੋ';

  @override
  String get includeOcrText => 'OCR ਟੈਕਸਟ ਸ਼ਾਮਲ ਕਰੋ';

  @override
  String get includeOcrTextSubtitle =>
      'ਕੱਢੇ ਗਏ ਟੈਕਸਟ ਨਾਲ ਇੱਕ ਵੱਖਰਾ ਪੰਨਾ ਜੋੜਦਾ ਹੈ';

  @override
  String get pagesHeader => 'ਪੰਨੇ';

  @override
  String get deselectAll => 'ਸਾਰੇ ਅਣਚੁਣੇ ਕਰੋ';

  @override
  String get selectAll => 'ਸਾਰੇ ਚੁਣੋ';

  @override
  String pageIndex(Object number) {
    return 'ਪੰਨਾ $number';
  }

  @override
  String get exportAction => 'ਨਿਰਯਾਤ';

  @override
  String get exportFormat => 'ਫਾਰਮੈਟ';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'ਤਸਵੀਰਾਂ';

  @override
  String scannedImagesFrom(Object name) {
    return '$name ਤੋਂ ਸਕੈਨ ਕੀਤੀਆਂ ਤਸਵੀਰਾਂ';
  }

  @override
  String get settingsAppearance => 'ਦਿੱਖ';

  @override
  String get themeSystem => 'ਸਿਸਟਮ ਡਿਫੌਲਟ';

  @override
  String get themeLight => 'ਲਾਈਟ';

  @override
  String get themeDark => 'ਡਾਰਕ';

  @override
  String get settingsStorageHeader => 'ਸਟੋਰੇਜ';

  @override
  String get storageInternal => 'ਅੰਦਰੂਨੀ ਸਟੋਰੇਜ (ਡਿਫੌਲਟ)';

  @override
  String get resetToDefault => 'ਡਿਫੌਲਟ ਤੇ ਰੀਸੈਟ ਕਰੋ';

  @override
  String get freeUpSpace => 'ਜਗ੍ਹਾ ਖਾਲੀ ਕਰੋ';

  @override
  String get chooseTheme => 'ਥੀਮ ਚੁਣੋ';

  @override
  String get clearCacheTitle => 'ਕੈਸ਼ੇ ਸਾਫ਼ ਕਰੋ';

  @override
  String get clearCacheMessage =>
      'ਇਹ ਅਸਥਾਈ ਫਾਈਲਾਂ ਨੂੰ ਮਿਟਾ ਦੇਵੇਗਾ। ਤੁਹਾਡੇ ਸੁਰੱਖਿਅਤ ਕੀਤੇ ਦਸਤਾਵੇਜ਼ ਨਹੀਂ ਮਿਟਾਏ ਜਾਣਗੇ। ਜਾਰੀ ਰੱਖਣਾ ਹੈ?';

  @override
  String get clear => 'ਸਾਫ਼ ਕਰੋ';

  @override
  String get cacheCleared => 'ਕੈਸ਼ੇ ਸਫਲਤਾਪੂਰਵਕ ਸਾਫ਼ ਕੀਤੀ ਗਈ';

  @override
  String cacheClearFailed(Object error) {
    return 'ਕੈਸ਼ੇ ਸਾਫ਼ ਕਰਨ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String get storageLocation => 'ਸਟੋਰੇਜ ਟਿਕਾਣਾ';

  @override
  String get storageDefault => 'ਡਿਫੌਲਟ (ਅੰਦਰੂਨੀ)';

  @override
  String get storageCustom => 'ਕਸਟਮ ਫੋਲਡਰ ਚੁਣੋ...';

  @override
  String storageWriteError(Object error) {
    return 'ਇਸ ਫੋਲਡਰ ਵਿੱਚ ਲਿਖਿਆ ਨਹੀਂ ਜਾ ਸਕਦਾ: $error';
  }

  @override
  String get chooseLanguage => 'ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get moreOptions => 'ਹੋਰ ਵਿਕਲਪ';
}
