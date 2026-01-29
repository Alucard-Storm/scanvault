// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'ഹോം';

  @override
  String get foldersTab => 'ഫോൾഡറുകൾ';

  @override
  String get settingsTab => 'ക്രമീകരണങ്ങൾ';

  @override
  String get scanPage => 'പേജ് സ്കാൻ ചെയ്യുക';

  @override
  String get cameraPermissionRequired => 'ക്യാമറ അനുമതി ആവശ്യമാണ്';

  @override
  String get noCamerasAvailable => 'ക്യാമറകൾ ലഭ്യമല്ല';

  @override
  String errorScanning(Object error) {
    return 'സ്കാനിംഗ് പിശക്: $error';
  }

  @override
  String get save => 'സേവ് ചെയ്യുക';

  @override
  String get cancel => 'റദ്ദാക്കുക';

  @override
  String get delete => 'നീക്കം ചെയ്യുക';

  @override
  String get edit => 'എഡിറ്റ്';

  @override
  String get share => 'പങ്കിടുക';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'വിവർത്തനം';

  @override
  String get proFeature => 'പ്രോ ഫീച്ചർ';

  @override
  String get settingsLanguage => 'ഭാഷ';

  @override
  String get settingsTheme => 'തീം';

  @override
  String get settingsStorage => 'സ്റ്റോറേജ് സ്ഥാനം';

  @override
  String get settingsClearCache => 'കാഷ് ക്ലിയർ ചെയ്യുക';

  @override
  String get settingsAbout => 'കുറിച്ച്';

  @override
  String get settingsVersion => 'പതിപ്പ്';

  @override
  String get settingsLicenses => 'ലൈസൻസുകൾ';

  @override
  String get searchHint => 'രേഖകൾ തിരയുക...';

  @override
  String get noDocuments => 'രേഖകളൊന്നുമില്ല';

  @override
  String get noDocumentsSubtitle => 'ആരംഭിക്കാൻ ഒരു രേഖ സ്കാൻ ചെയ്യുക';

  @override
  String get scanFab => 'സ്കാൻ';

  @override
  String get rename => 'പേരുമാറ്റുക';

  @override
  String get moveToFolder => 'ഫോൾഡറിലേക്ക് നീക്കുക';

  @override
  String get moveToRoot => 'ഒന്നുമില്ല (റൂട്ട്)';

  @override
  String get deleteDocumentTitle => 'രേഖ ഇല്ലാതാക്കുക';

  @override
  String deleteConfirmation(Object name) {
    return '\"$name\" ഇല്ലാതാക്കണമെന്ന് നിങ്ങൾക്ക് ഉറപ്പാണോ?';
  }

  @override
  String deleted(Object name) {
    return '$name ഇല്ലാതാക്കി';
  }

  @override
  String get movedToRoot => 'റൂട്ടിലേക്ക് നീക്കി';

  @override
  String movedTo(Object folderName) {
    return '$folderName-ലേക്ക് നീക്കി';
  }

  @override
  String get documentNotFound => 'രേഖ കണ്ടെത്തിയില്ല';

  @override
  String get editPage => 'പേജ് എഡിറ്റുചെയ്യുക';

  @override
  String get addPage => 'പേജ് ചേർക്കുക';

  @override
  String get sharePdf => 'PDF പങ്കിടുക';

  @override
  String get tags => 'ടാഗുകൾ';

  @override
  String pageCount(Object current, Object total) {
    return 'പേജ് $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count പേജുകൾ വിജയകരമായി ചേർത്തു';
  }

  @override
  String pageAddFailed(Object error) {
    return 'പേജ് ചേർക്കുന്നതിൽ പരാജയപ്പെട്ടു: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'എക്‌സ്‌പോർട്ട് പരാജയപ്പെട്ടു: $error';
  }

  @override
  String get noFolders => 'ഫോൾഡറുകളൊന്നുമില്ല';

  @override
  String get noFoldersAvailable =>
      'ഫോൾഡറുകളൊന്നും ലഭ്യമല്ല. ആദ്യം ഒരെണ്ണം സൃഷ്ടിക്കുക.';

  @override
  String get newFolder => 'പുതിയ ഫോൾഡർ';

  @override
  String get folderName => 'ഫോൾഡർ പേര്';

  @override
  String get create => 'സൃഷ്ടിക്കുക';

  @override
  String get editFolder => 'ഫോൾഡർ എഡിറ്റുചെയ്യുക';

  @override
  String get deleteFolderTitle => 'ഫോൾഡർ ഇല്ലാതാക്കുക';

  @override
  String get deleteFolderConfirmation =>
      'ഈ ഫോൾഡർ ഇല്ലാതാക്കണോ? ഉള്ളിലുള്ള രേഖകൾ റൂട്ടിലേക്ക് നീക്കും.';

  @override
  String folderItems(Object count) {
    return '$count ഇനങ്ങൾ';
  }

  @override
  String get extractedText => 'എക്‌സ്‌ട്രാക്റ്റുചെയ്‌ത ടെക്‌സ്‌റ്റ്';

  @override
  String ocrFailed(Object error) {
    return 'OCR പരാജയപ്പെട്ടു: $error';
  }

  @override
  String get textSaved => 'രേഖയിൽ ടെക്‌സ്‌റ്റ് സേവ് ചെയ്തു';

  @override
  String saveFailed(Object error) {
    return 'സേവ് ചെയ്യുന്നതിൽ പരാജയപ്പെട്ടു: $error';
  }

  @override
  String get saveToDocument => 'രേഖയിലേക്ക് സേവ് ചെയ്യുക';

  @override
  String get copiedToClipboard => 'ക്ലിപ്പ്‌ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get copy => 'പകർപ്പ്';

  @override
  String get noTextExtracted =>
      'ടെക്‌സ്‌റ്റൊന്നും എക്‌സ്‌ട്രാക്റ്റുചെയ്‌തില്ല...';

  @override
  String get sourceText => 'ഉറവിട ടെക്‌സ്‌റ്റ്';

  @override
  String get translation => 'വിവർത്തനം';

  @override
  String get savingDocument => 'രേഖ സേവ് ചെയ്യുന്നു...';

  @override
  String get launchingScanner => 'സ്കാനർ സമാരംഭിക്കുന്നു...';

  @override
  String saveDocumentFailed(Object error) {
    return 'രേഖ സേവ് ചെയ്യുന്നതിൽ പരാജയപ്പെട്ടു: $error';
  }

  @override
  String get editTitle => 'എഡിറ്റ്';

  @override
  String get done => 'പൂർത്തിയായി';

  @override
  String errorLoadingImage(Object error) {
    return 'ഇമേജ് ലോഡ് ചെയ്യുന്നതിൽ പിശക്: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'ഫിൽട്ടർ ബാധകമാക്കുന്നതിൽ പിശക്: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'മാറ്റങ്ങൾ സേവ് ചെയ്യുന്നതിൽ പരാജയപ്പെട്ടു: $error';
  }

  @override
  String get noImage => 'ഇമേജ് ഇല്ല';

  @override
  String get deleteTagTitle => 'ടാഗ് ഇല്ലാതാക്കുക';

  @override
  String deleteTagConfirmation(Object tagName) {
    return '\"$tagName\" ടാഗ് ഇല്ലാതാക്കണമെന്ന് നിങ്ങൾക്ക് ഉറപ്പാണോ?';
  }

  @override
  String get selectTags => 'ടാഗുകൾ തിരഞ്ഞെടുക്കുക';

  @override
  String get manageTags => 'ടാഗുകൾ കൈകാര്യം ചെയ്യുക';

  @override
  String get noTags => 'ഇതുവരെ ടാഗുകളൊന്നും സൃഷ്ടിച്ചിട്ടില്ല';

  @override
  String get newTagName => 'പുതിയ ടാഗ് പേര്';

  @override
  String errorGeneric(Object error) {
    return 'പിശക്: $error';
  }

  @override
  String get renameFolder => 'ഫോൾഡർ പേരുമാറ്റുക';

  @override
  String get emptyFolder => 'ശൂന്യമായ ഫോൾഡർ';

  @override
  String get exportPdfTitle => 'PDF എക്‌സ്‌പോർട്ട്';

  @override
  String get includeOcrText => 'OCR ടെക്‌സ്‌റ്റ് ഉൾപ്പെടുത്തുക';

  @override
  String get includeOcrTextSubtitle =>
      'എക്‌സ്‌ട്രാക്റ്റുചെയ്‌ത ടെക്‌സ്‌റ്റ് ഉള്ള ഒരു പ്രത്യേക പേജ് ചേർക്കുന്നു';

  @override
  String get pagesHeader => 'പേജുകൾ';

  @override
  String get deselectAll => 'എല്ലാം അളക്കുക';

  @override
  String get selectAll => 'എല്ലാം തിരഞ്ഞെടുക്കുക';

  @override
  String pageIndex(Object number) {
    return 'പേജ് $number';
  }

  @override
  String get exportAction => 'എക്‌സ്‌പോർട്ട്';

  @override
  String get exportFormat => 'ഫോർമാറ്റ്';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'ചിത്രങ്ങൾ';

  @override
  String scannedImagesFrom(Object name) {
    return '$name-ൽ നിന്ന് സ്കാൻ ചെയ്ത ചിത്രങ്ങൾ';
  }
}
