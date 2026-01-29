// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'होम';

  @override
  String get foldersTab => 'फोल्डर';

  @override
  String get settingsTab => 'सेटिंग्ज';

  @override
  String get scanPage => 'स्कॅन पेज';

  @override
  String get cameraPermissionRequired => 'कॅमेरा परवानगी आवश्यक';

  @override
  String get noCamerasAvailable => 'कॅमेरा उपलब्ध नाही';

  @override
  String errorScanning(Object error) {
    return 'स्कॅनिंग त्रुटी: $error';
  }

  @override
  String get save => 'सेव्ह करा';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get delete => 'हटवा';

  @override
  String get edit => 'संपादित करा';

  @override
  String get share => 'शेअर करा';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'भाषांतर';

  @override
  String get proFeature => 'प्रो फिचर';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsTheme => 'थीम';

  @override
  String get settingsStorage => 'स्टोरेज लोकेशन';

  @override
  String get settingsClearCache => 'कॅशे साफ करा';

  @override
  String get settingsAbout => 'बद्दल';

  @override
  String get settingsVersion => 'आवृत्ती';

  @override
  String get settingsLicenses => 'परवाने';

  @override
  String get searchHint => 'कागदपत्रे शोधा...';

  @override
  String get noDocuments => 'काहीही कागदपत्रे नाहीत';

  @override
  String get noDocumentsSubtitle => 'सुरु करण्यासाठी एखादे कागदपत्र स्कॅन करा';

  @override
  String get scanFab => 'स्कॅन';

  @override
  String get rename => 'नाव बदला';

  @override
  String get moveToFolder => 'फोल्डरमध्ये हलवा';

  @override
  String get moveToRoot => 'काहीही नाही (रूट)';

  @override
  String get deleteDocumentTitle => 'कागदपत्र हटवा';

  @override
  String deleteConfirmation(Object name) {
    return 'तुम्ही नक्की \"$name\" हटवू इच्छिता?';
  }

  @override
  String deleted(Object name) {
    return '$name हटवले';
  }

  @override
  String get movedToRoot => 'रूटमध्ये हलवले';

  @override
  String movedTo(Object folderName) {
    return '$folderName मध्ये हलवले';
  }

  @override
  String get documentNotFound => 'कागदपत्र सापडले नाही';

  @override
  String get editPage => 'पेज संपादित करा';

  @override
  String get addPage => 'पेज जोडा';

  @override
  String get sharePdf => 'PDF शेअर करा';

  @override
  String get tags => 'टॅग्ज';

  @override
  String pageCount(Object current, Object total) {
    return 'पेज $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count पेज यशस्वीरित्या जोडले';
  }

  @override
  String pageAddFailed(Object error) {
    return 'पेज जोडणे अपयशी: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'निर्यात अपयशी: $error';
  }

  @override
  String get noFolders => 'काहीही फोल्डर्स नाहीत';

  @override
  String get noFoldersAvailable =>
      'काहीही फोल्डर्स उपलब्ध नाहीत. आधी एक तयार करा.';

  @override
  String get newFolder => 'नवीन फोल्डर';

  @override
  String get folderName => 'फोल्डरचे नाव';

  @override
  String get create => 'तयार करा';

  @override
  String get editFolder => 'फोल्डर संपादित करा';

  @override
  String get deleteFolderTitle => 'फोल्डर हटवा';

  @override
  String get deleteFolderConfirmation =>
      'हे फोल्डर हटवायचे? आतील कागदपत्रे रूटमध्ये हलवली जातील.';

  @override
  String folderItems(Object count) {
    return '$count आयटम';
  }

  @override
  String get extractedText => 'काढलेला मजकूर';

  @override
  String ocrFailed(Object error) {
    return 'OCR अपयशी: $error';
  }

  @override
  String get textSaved => 'मजकूर कागदपत्रात सेव्ह केला';

  @override
  String saveFailed(Object error) {
    return 'सेव्ह करणे अपयशी: $error';
  }

  @override
  String get saveToDocument => 'कागदपत्रात सेव्ह करा';

  @override
  String get copiedToClipboard => 'क्लिपबोर्डवर कॉपी केले';

  @override
  String get copy => 'कॉपी';

  @override
  String get noTextExtracted => 'काहीही मजकूर काढला नाही...';

  @override
  String get sourceText => 'मूळ मजकूर';

  @override
  String get translation => 'भाषांतर';

  @override
  String get savingDocument => 'कागदपत्र सेव्ह होत आहे...';

  @override
  String get launchingScanner => 'स्कॅनर सुरु होत आहे...';

  @override
  String saveDocumentFailed(Object error) {
    return 'कागदपत्र सेव्ह करणे अपयशी: $error';
  }

  @override
  String get editTitle => 'संपादित करा';

  @override
  String get done => 'पूर्ण झाले';

  @override
  String errorLoadingImage(Object error) {
    return 'इमेज लोड करताना त्रुटी: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'फिल्टर लागू करताना त्रुटी: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'बदल सेव्ह करणे अपयशी: $error';
  }

  @override
  String get noImage => 'इमेज नाही';

  @override
  String get deleteTagTitle => 'टॅग हटवा';

  @override
  String deleteTagConfirmation(Object tagName) {
    return 'तुम्ही नक्की \"$tagName\" टॅग हटवू इच्छिता का?';
  }

  @override
  String get selectTags => 'टॅग निवडा';

  @override
  String get manageTags => 'टॅग व्यवस्थापित करा';

  @override
  String get noTags => 'अद्याप टॅग तयार केले नाहीत';

  @override
  String get newTagName => 'नवीन टॅग नाव';

  @override
  String errorGeneric(Object error) {
    return 'त्रुटी: $error';
  }

  @override
  String get renameFolder => 'फोल्डरचे नाव बदला';

  @override
  String get emptyFolder => 'रिकामे फोल्डर';

  @override
  String get exportPdfTitle => 'PDF निर्यात करा';

  @override
  String get includeOcrText => 'OCR मजकूर समाविष्ट करा';

  @override
  String get includeOcrTextSubtitle => 'काढलेल्या मजकूरासह वेगळे पेज जोडते';

  @override
  String get pagesHeader => 'पेजेस';

  @override
  String get deselectAll => 'सर्व निवड रद्द करा';

  @override
  String get selectAll => 'सर्व निवडा';

  @override
  String pageIndex(Object number) {
    return 'पेज $number';
  }

  @override
  String get exportAction => 'निर्यात';

  @override
  String get exportFormat => 'फॉरमॅट';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'प्रतिमा';

  @override
  String scannedImagesFrom(Object name) {
    return '$name मधून स्कॅन केलेल्या प्रतिमा';
  }

  @override
  String get settingsAppearance => 'दिसणे';

  @override
  String get themeSystem => 'सिस्टम डिफॉल्ट';

  @override
  String get themeLight => 'लाईट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get settingsStorageHeader => 'स्टोरेज';

  @override
  String get storageInternal => 'अंतर्गत स्टोरेज (डिफॉल्ट)';

  @override
  String get resetToDefault => 'डिफॉल्टवर रीसेट करा';

  @override
  String get freeUpSpace => 'जागा मोकळी करा';

  @override
  String get chooseTheme => 'थीम निवडा';

  @override
  String get clearCacheTitle => 'कॅशे साफ करा';

  @override
  String get clearCacheMessage =>
      'हे तात्पुरत्या फायली हटवेल. तुमची सेव्ह केलेली कागदपत्रे हटविली जाणार नाहीत. पुढे चालू ठेवायचे?';

  @override
  String get clear => 'साफ करा';

  @override
  String get cacheCleared => 'कॅशे यशस्वीरित्या साफ केली';

  @override
  String cacheClearFailed(Object error) {
    return 'कॅशे साफ करण्यात अयशस्वी: $error';
  }

  @override
  String get storageLocation => 'स्टोरेज लोकेशन';

  @override
  String get storageDefault => 'डिफॉल्ट (अंतर्गत)';

  @override
  String get storageCustom => 'कस्टम फोल्डर निवडा...';

  @override
  String storageWriteError(Object error) {
    return 'या फोल्डरमध्ये लिहू शकत नाही: $error';
  }

  @override
  String get chooseLanguage => 'भाषा निवडा';

  @override
  String get moreOptions => 'अधिक पर्याय';

  @override
  String get useSystemColor => 'सिस्टम कलर्स वापरा';
}
