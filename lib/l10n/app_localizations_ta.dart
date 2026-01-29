// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'முகப்பு';

  @override
  String get foldersTab => 'கோப்புறைகள்';

  @override
  String get settingsTab => 'அமைப்புகள்';

  @override
  String get scanPage => 'ஸ்கேன் பக்கம்';

  @override
  String get cameraPermissionRequired => 'கேமரா அனுமதி தேவை';

  @override
  String get noCamerasAvailable => 'கேமராக்கள் இல்லை';

  @override
  String errorScanning(Object error) {
    return 'ஸ்கேனிங் பிழை: $error';
  }

  @override
  String get save => 'சேமி';

  @override
  String get cancel => 'ரத்து';

  @override
  String get delete => 'அழி';

  @override
  String get edit => 'திருத்து';

  @override
  String get share => 'பகிர்';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'மொழிபெயர்';

  @override
  String get proFeature => 'Pro வசதி';

  @override
  String get settingsLanguage => 'மொழி';

  @override
  String get settingsTheme => 'தீம்';

  @override
  String get settingsStorage => 'சேமிப்பு இடம்';

  @override
  String get settingsClearCache => 'தற்காலிக நினைவகத்தை அழி';

  @override
  String get settingsAbout => 'பற்றி';

  @override
  String get settingsVersion => 'பதிப்பு';

  @override
  String get settingsLicenses => 'உரிமங்கள்';

  @override
  String get searchHint => 'ஆவணங்களைத் தேடு...';

  @override
  String get noDocuments => 'ஆவணங்கள் இல்லை';

  @override
  String get noDocumentsSubtitle => 'தொடங்க ஒரு ஆவணத்தை ஸ்கேன் செய்யவும்';

  @override
  String get scanFab => 'ஸ்கேன்';

  @override
  String get rename => 'பெயர் மாற்றுக';

  @override
  String get moveToFolder => 'கோப்புறைக்கு நகர்த்தவும்';

  @override
  String get moveToRoot => 'ஒன்றுமில்லை (ரூட்)';

  @override
  String get deleteDocumentTitle => 'ஆவணத்தை நீக்கு';

  @override
  String deleteConfirmation(Object name) {
    return '\"$name\" ஐ நீக்க விரும்புகிறீர்களா?';
  }

  @override
  String deleted(Object name) {
    return '$name நீக்கப்பட்டது';
  }

  @override
  String get movedToRoot => 'ரூட்டிற்கு நகர்த்தப்பட்டது';

  @override
  String movedTo(Object folderName) {
    return '$folderName-க்கு நகர்த்தப்பட்டது';
  }

  @override
  String get documentNotFound => 'ஆவணம் கிடைக்கவில்லை';

  @override
  String get editPage => 'பக்கத்தைத் திருத்து';

  @override
  String get addPage => 'பக்கம் சேர்';

  @override
  String get sharePdf => 'PDF ஐப் பகிரவும்';

  @override
  String get tags => 'குறிச்சொற்கள்';

  @override
  String pageCount(Object current, Object total) {
    return 'பக்கம் $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count பக்கங்கள் வெற்றிகரமாக சேர்க்கப்பட்டன';
  }

  @override
  String pageAddFailed(Object error) {
    return 'பக்கம் சேர்க்க முடியவில்லை: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'ஏற்றுமதி தோல்வி: $error';
  }

  @override
  String get noFolders => 'கோப்புறைகள் இல்லை';

  @override
  String get noFoldersAvailable =>
      'கோப்புறைகள் இல்லை. முதலில் ஒன்றை உருவாக்கவும்.';

  @override
  String get newFolder => 'புதிய கோப்புறை';

  @override
  String get folderName => 'கோப்புறை பெயர்';

  @override
  String get create => 'உருவாக்கு';

  @override
  String get editFolder => 'கோப்புறையைத் திருத்து';

  @override
  String get deleteFolderTitle => 'கோப்புறையை நீக்கு';

  @override
  String get deleteFolderConfirmation =>
      'இந்தக் கோப்புறையை நீக்கலாமா? உள்ளே உள்ள ஆவணங்கள் ரூட்டிற்கு நகர்த்தப்படும்.';

  @override
  String folderItems(Object count) {
    return '$count உருப்படிகள்';
  }

  @override
  String get extractedText => 'பிரித்தெடுக்கப்பட்ட உரை';

  @override
  String ocrFailed(Object error) {
    return 'OCR தோல்வி: $error';
  }

  @override
  String get textSaved => 'உரை ஆவணத்தில் சேமிக்கப்பட்டது';

  @override
  String saveFailed(Object error) {
    return 'சேமிக்க முடியவில்லை: $error';
  }

  @override
  String get saveToDocument => 'ஆவணத்தில் சேமி';

  @override
  String get copiedToClipboard => 'கிளிப்போர்டில் நகலெடுக்கப்பட்டது';

  @override
  String get copy => 'நகலெடு';

  @override
  String get noTextExtracted => 'உரை எதுவும் பிரித்தெடுக்கப்படவில்லை...';

  @override
  String get sourceText => 'மூல உரை';

  @override
  String get translation => 'மொழிபெயர்ப்பு';

  @override
  String get savingDocument => 'ஆவணம் சேமிக்கப்படுகிறது...';

  @override
  String get launchingScanner => 'ஸ்கேனர் தொடங்கப்படுகிறது...';

  @override
  String saveDocumentFailed(Object error) {
    return 'ஆவணத்தைச் சேமிக்க முடியவில்லை: $error';
  }

  @override
  String get editTitle => 'திருத்து';

  @override
  String get done => 'முடிந்தது';

  @override
  String errorLoadingImage(Object error) {
    return 'படத்தை ஏற்றுவதில் பிழை: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'வடிகட்டியைப் பயன்படுத்துவதில் பிழை: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'மாற்றங்களைச் சேமிக்க முடியவில்லை: $error';
  }

  @override
  String get noImage => 'படம் இல்லை';

  @override
  String get deleteTagTitle => 'குறிச்சொல்லை நீக்கு';

  @override
  String deleteTagConfirmation(Object tagName) {
    return '\"$tagName\" குறிச்சொல்லை நிச்சயமாக நீக்க விரும்புகிறீர்களா?';
  }

  @override
  String get selectTags => 'குறிச்சொற்களைத் தேர்ந்தெடுக்கவும்';

  @override
  String get manageTags => 'குறிச்சொற்களை நிர்வகி';

  @override
  String get noTags => 'குறிச்சொற்கள் எதுவும் உருவாக்கப்படவில்லை';

  @override
  String get newTagName => 'புதிய குறிச்சொல் பெயர்';

  @override
  String errorGeneric(Object error) {
    return 'பிழை: $error';
  }

  @override
  String get renameFolder => 'கோப்புறை மறுபெயரிடு';

  @override
  String get emptyFolder => 'காலி கோப்புறை';

  @override
  String get exportPdfTitle => 'PDF ஏற்றுமதி';

  @override
  String get includeOcrText => 'OCR உரையைச் சேர்க்கவும்';

  @override
  String get includeOcrTextSubtitle =>
      'பிரித்தெடுக்கப்பட்ட உரையுடன் தனி பக்கத்தைச் சேர்க்கிறது';

  @override
  String get pagesHeader => 'பக்கங்கள்';

  @override
  String get deselectAll => 'அனைத்தையும் தேர்வுநீக்கு';

  @override
  String get selectAll => 'அனைத்தையும் தேர்வுசெய்';

  @override
  String pageIndex(Object number) {
    return 'பக்கம் $number';
  }

  @override
  String get exportAction => 'ஏற்றுமதி';

  @override
  String get exportFormat => 'வடிவம்';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'படங்கள்';

  @override
  String scannedImagesFrom(Object name) {
    return '$name-லிருந்து ஸ்கேன் செய்யப்பட்ட படங்கள்';
  }

  @override
  String get settingsAppearance => 'தோற்றம்';

  @override
  String get themeSystem => 'கணினி இயல்புநிலை';

  @override
  String get themeLight => 'லைட்';

  @override
  String get themeDark => 'டார்க்';

  @override
  String get settingsStorageHeader => 'சேமிப்பகம்';

  @override
  String get storageInternal => 'உள் சேமிப்பகம் (இயல்புநிலை)';

  @override
  String get resetToDefault => 'இயல்புநிலைக்கு மீட்டமை';

  @override
  String get freeUpSpace => 'இடத்தை விடுவி';

  @override
  String get chooseTheme => 'தீம் தேர்வு';

  @override
  String get clearCacheTitle => 'தேக்ககத்தை அழி';

  @override
  String get clearCacheMessage =>
      'இது தற்காலிக கோப்புகளை நீக்கும். உங்கள் சேமிக்கப்பட்ட ஆவணங்கள் நீக்கப்படாது. தொடரவா?';

  @override
  String get clear => 'அழி';

  @override
  String get cacheCleared => 'தேக்ககம் வெற்றிகரமாக அழிக்கப்பட்டது';

  @override
  String cacheClearFailed(Object error) {
    return 'தேக்ககத்தை அழிக்க முடியவில்லை: $error';
  }

  @override
  String get storageLocation => 'சேமிப்பிட இடம்';

  @override
  String get storageDefault => 'இயல்புநிலை (உள்)';

  @override
  String get storageCustom => 'தனிப்பயன் கோப்புறையைத் தேர்ந்தெடுக்கவும்...';

  @override
  String storageWriteError(Object error) {
    return 'இந்த கோப்புறையில் எழுத முடியாது: $error';
  }

  @override
  String get chooseLanguage => 'மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get moreOptions => 'மேலும் விருப்பங்கள்';
}
