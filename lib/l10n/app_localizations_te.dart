// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'హోమ్';

  @override
  String get foldersTab => 'ఫోల్డర్లు';

  @override
  String get settingsTab => 'సెట్టింగ్‌లు';

  @override
  String get scanPage => 'స్కాన్ పేజీ';

  @override
  String get cameraPermissionRequired => 'కెమెరా అనుమతి అవసరం';

  @override
  String get noCamerasAvailable => 'కెమెరాలు అందుబాటులో లేవు';

  @override
  String errorScanning(Object error) {
    return 'స్కానింగ్ లోపం: $error';
  }

  @override
  String get save => 'సేవ్ చేయండి';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get delete => 'తొలగించు';

  @override
  String get edit => 'సవరించు';

  @override
  String get share => 'షేర్ చేయండి';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'అనువదించు';

  @override
  String get proFeature => 'ప్రో ఫీచర్';

  @override
  String get settingsLanguage => 'భాష';

  @override
  String get settingsTheme => 'థీమ్';

  @override
  String get settingsStorage => 'నిల్వ స్థానం';

  @override
  String get settingsClearCache => 'కాష్ క్లియర్ చేయండి';

  @override
  String get settingsAbout => 'గురించి';

  @override
  String get settingsVersion => 'వెర్షన్';

  @override
  String get settingsLicenses => 'లైసెన్సులు';

  @override
  String get searchHint => 'పత్రాలను శోధించండి...';

  @override
  String get noDocuments => 'పత్రాలు లేవు';

  @override
  String get noDocumentsSubtitle => 'ప్రారంభించడానికి పత్రాన్ని స్కాన్ చేయండి';

  @override
  String get scanFab => 'స్కాన్ చేయండి';

  @override
  String get rename => 'పేరు మార్చండి';

  @override
  String get moveToFolder => 'ఫోల్డర్‌కు తరలించండి';

  @override
  String get moveToRoot => 'ఏదీ లేదు (రూట్)';

  @override
  String get deleteDocumentTitle => 'పత్రాన్ని తొలగించండి';

  @override
  String deleteConfirmation(Object name) {
    return 'మీరు \"$name\"ని తొలగించాలనుకుంటున్నారా?';
  }

  @override
  String deleted(Object name) {
    return '$name తొలగించబడింది';
  }

  @override
  String get movedToRoot => 'రూట్‌కు తరలించబడింది';

  @override
  String movedTo(Object folderName) {
    return '$folderNameకు తరలించబడింది';
  }

  @override
  String get documentNotFound => 'పత్రం కనుగొనబడలేదు';

  @override
  String get editPage => 'పేజీని సవరించండి';

  @override
  String get addPage => 'పేజీని జోడించండి';

  @override
  String get sharePdf => 'PDFను భాగస్వామ్యం చేయండి';

  @override
  String get tags => 'ట్యాగ్లు';

  @override
  String pageCount(Object current, Object total) {
    return 'పేజీ $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count పేజీలు విజయవంతంగా జోడించబడ్డాయి';
  }

  @override
  String pageAddFailed(Object error) {
    return 'పేజీని జోడించడం విఫలమైంది: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'ఎగుమతి విఫలమైంది: $error';
  }

  @override
  String get noFolders => 'ఫోల్డర్లు లేవు';

  @override
  String get noFoldersAvailable =>
      'ఫోల్డర్లు అందుబాటులో లేవు. ముందుగా ఒకదాన్ని సృష్టించండి.';

  @override
  String get newFolder => 'కొత్త ఫోల్డర్';

  @override
  String get folderName => 'ఫోల్డర్ పేరు';

  @override
  String get create => 'సృష్టించు';

  @override
  String get editFolder => 'ఫోల్డర్‌ను సవరించండి';

  @override
  String get deleteFolderTitle => 'ఫోల్డర్‌ను తొలగించండి';

  @override
  String get deleteFolderConfirmation =>
      'ఈ ఫోల్డర్‌ను తొలగించాలా? లోపల ఉన్న పత్రాలు రూట్‌కు తరలించబడతాయి.';

  @override
  String folderItems(Object count) {
    return '$count అంశాలు';
  }

  @override
  String get extractedText => 'సేకరించిన వచనం';

  @override
  String ocrFailed(Object error) {
    return 'OCR విఫలమైంది: $error';
  }

  @override
  String get textSaved => 'వచనం పత్రానికి సేవ్ చేయబడింది';

  @override
  String saveFailed(Object error) {
    return 'సేవ్ చేయడం విఫలమైంది: $error';
  }

  @override
  String get saveToDocument => 'పత్రానికి సేవ్ చేయండి';

  @override
  String get copiedToClipboard => 'క్లిప్‌బోర్డ్‌కు కాపీ చేయబడింది';

  @override
  String get copy => 'కాపీ చేయండి';

  @override
  String get noTextExtracted => 'ఏ వచనం సేకరించబడలేదు...';

  @override
  String get sourceText => 'మూల వచనం';

  @override
  String get translation => 'అనువాదం';

  @override
  String get savingDocument => 'పత్రం సేవ్ చేయబడుతోంది...';

  @override
  String get launchingScanner => 'స్కానర్ ప్రారంభించబడుతోంది...';

  @override
  String saveDocumentFailed(Object error) {
    return 'పత్రాన్ని సేవ్ చేయడం విఫలమైంది: $error';
  }

  @override
  String get editTitle => 'సవరించు';

  @override
  String get done => 'పూర్తయింది';

  @override
  String errorLoadingImage(Object error) {
    return 'ఇమేజ్ లోడ్ చేయడంలో లోపం: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'ఫిల్టర్ వర్తింపజేయడంలో లోపం: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'మార్పులను సేవ్ చేయడం విఫలమైంది: $error';
  }

  @override
  String get noImage => 'ఇమేజ్ లేదు';

  @override
  String get deleteTagTitle => 'ట్యాగ్ తొలగించు';

  @override
  String deleteTagConfirmation(Object tagName) {
    return 'మీరు ఖచ్చితంగా \"$tagName\" ట్యాగ్‌ని తొలగించాలనుకుంటున్నారా?';
  }

  @override
  String get selectTags => 'ట్యాగ్‌లను ఎంచుకోండి';

  @override
  String get manageTags => 'ట్యాగ్‌లను నిర్వహించండి';

  @override
  String get noTags => 'ఇంకా ట్యాగ్‌లు సృష్టించబడలేదు';

  @override
  String get newTagName => 'కొత్త ట్యాగ్ పేరు';

  @override
  String errorGeneric(Object error) {
    return 'లోపం: $error';
  }

  @override
  String get renameFolder => 'ఫోల్డర్ పేరు మార్చండి';

  @override
  String get emptyFolder => 'ఖాళీ ఫోల్డర్';

  @override
  String get exportPdfTitle => 'PDF ఎగుమతి';

  @override
  String get includeOcrText => 'OCR వచనాన్ని చేర్చండి';

  @override
  String get includeOcrTextSubtitle =>
      'సంగ్రహించిన వచనంతో ప్రత్యేక పేజీని జోడిస్తుంది';

  @override
  String get pagesHeader => 'పేజీలు';

  @override
  String get deselectAll => 'అన్నీ ఎంపిక తీసివేయి';

  @override
  String get selectAll => 'అన్నీ ఎంచుకోండి';

  @override
  String pageIndex(Object number) {
    return 'పేజీ $number';
  }

  @override
  String get exportAction => 'ఎగుమతి';

  @override
  String get exportFormat => 'ఫార్మాట్';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'చిత్రాలు';

  @override
  String scannedImagesFrom(Object name) {
    return '$name నుండి స్కాన్ చేసిన చిత్రాలు';
  }

  @override
  String get settingsAppearance => 'కనిపించు విధానం';

  @override
  String get themeSystem => 'సిస్టమ్ డిఫాల్ట్';

  @override
  String get themeLight => 'లైట్';

  @override
  String get themeDark => 'డార్క్';

  @override
  String get settingsStorageHeader => 'స్టోరేజ్';

  @override
  String get storageInternal => 'అంతర్గత స్టోరేజ్ (డిఫాల్ట్)';

  @override
  String get resetToDefault => 'డిఫాల్ట్‌కు రీసెట్ చేయి';

  @override
  String get freeUpSpace => 'స్థలాన్ని ఖాళీ చేయి';

  @override
  String get chooseTheme => 'థీమ్ ఎంచుకోండి';

  @override
  String get clearCacheTitle => 'కాచీని క్లియర్ చేయి';

  @override
  String get clearCacheMessage =>
      'ఇది తాత్కాలిక ఫైళ్లను తొలగిస్తుంది. మీ సేవ్ చేసిన పత్రాలు తొలగించబడవు. కొనసాగించాలా?';

  @override
  String get clear => 'క్లియర్';

  @override
  String get cacheCleared => 'కాచీ విజయవంతంగా క్లియర్ చేయబడింది';

  @override
  String cacheClearFailed(Object error) {
    return 'కాచీని క్లియర్ చేయడం విఫలమైంది: $error';
  }

  @override
  String get storageLocation => 'స్టోరేజ్ లొకేషన్';

  @override
  String get storageDefault => 'డిఫాల్ట్ (అంతర్గత)';

  @override
  String get storageCustom => 'కస్టమ్ ఫోల్డర్‌ని ఎంచుకోండి...';

  @override
  String storageWriteError(Object error) {
    return 'ఈ ఫోల్డర్‌లో రాయలేము: $error';
  }

  @override
  String get chooseLanguage => 'భాషను ఎంచుకోండి';

  @override
  String get moreOptions => 'మరిన్ని ఎంపికలు';

  @override
  String get useSystemColor => 'సిస్టమ్ రంగులను ఉపయోగించండి';
}
