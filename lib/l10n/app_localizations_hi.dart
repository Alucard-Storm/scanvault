// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'होम';

  @override
  String get foldersTab => 'फोल्डर';

  @override
  String get settingsTab => 'सेटिंग्स';

  @override
  String get scanPage => 'पेज स्कैन करें';

  @override
  String get cameraPermissionRequired => 'कैमरा अनुमति आवश्यक है';

  @override
  String get noCamerasAvailable => 'कोई कैमरा उपलब्ध नहीं है';

  @override
  String errorScanning(Object error) {
    return 'स्कैनिंग में त्रुटि: $error';
  }

  @override
  String get save => 'सहेजें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get edit => 'संपादित करें';

  @override
  String get share => 'साझा करें';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'अनुवाद';

  @override
  String get proFeature => 'प्रो फीचर';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsTheme => 'थीम';

  @override
  String get settingsStorage => 'स्टोरेज लोकेशन';

  @override
  String get settingsClearCache => 'कैश साफ़ करें';

  @override
  String get settingsAbout => 'ऐप के बारे में';

  @override
  String get settingsVersion => 'वर्जन';

  @override
  String get settingsLicenses => 'लाइसेंस';

  @override
  String get searchHint => 'दस्तावेज़ खोजें...';

  @override
  String get noDocuments => 'कोई दस्तावेज़ नहीं';

  @override
  String get noDocumentsSubtitle => 'शुरू करने के लिए एक दस्तावेज़ स्कैन करें';

  @override
  String get scanFab => 'स्कैन';

  @override
  String get rename => 'नाम बदलें';

  @override
  String get moveToFolder => 'फ़ोल्डर में ले जाएं';

  @override
  String get moveToRoot => 'कोई नहीं (रूट)';

  @override
  String get deleteDocumentTitle => 'दस्तावेज़ हटाएं';

  @override
  String deleteConfirmation(Object name) {
    return 'क्या आप वाकई \"$name\" को हटाना चाहते हैं?';
  }

  @override
  String deleted(Object name) {
    return '$name हटा दिया गया';
  }

  @override
  String get movedToRoot => 'रूट में ले जाया गया';

  @override
  String movedTo(Object folderName) {
    return '$folderName में ले जाया गया';
  }

  @override
  String get documentNotFound => 'दस्तावेज़ नहीं मिला';

  @override
  String get editPage => 'पेज संपादित करें';

  @override
  String get addPage => 'पेज जोड़ें';

  @override
  String get sharePdf => 'PDF साझा करें';

  @override
  String get tags => 'टैग';

  @override
  String pageCount(Object current, Object total) {
    return 'पेज $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count पेज सफलतापूर्वक जोड़े गए';
  }

  @override
  String pageAddFailed(Object error) {
    return 'पेज जोड़ने में विफल: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'निर्यात विफल: $error';
  }

  @override
  String get noFolders => 'कोई फ़ोल्डर नहीं';

  @override
  String get noFoldersAvailable => 'कोई फ़ोल्डर उपलब्ध नहीं है। पहले एक बनाएं।';

  @override
  String get newFolder => 'नया फ़ोल्डर';

  @override
  String get folderName => 'फ़ोल्डर का नाम';

  @override
  String get create => 'बनाएं';

  @override
  String get editFolder => 'फ़ोल्डर संपादित करें';

  @override
  String get deleteFolderTitle => 'फ़ोल्डर हटाएं';

  @override
  String get deleteFolderConfirmation =>
      'क्या आप इस फ़ोल्डर को हटाना चाहते हैं? इसके अंदर के दस्तावेज़ रूट में ले जाए जाएंगे।';

  @override
  String folderItems(Object count) {
    return '$count आइटम';
  }

  @override
  String get extractedText => 'निकाला गया टेक्स्ट';

  @override
  String ocrFailed(Object error) {
    return 'OCR विफल: $error';
  }

  @override
  String get textSaved => 'टेक्स्ट दस्तावेज़ में सहेजा गया';

  @override
  String saveFailed(Object error) {
    return 'सहेजने में विफल: $error';
  }

  @override
  String get saveToDocument => 'दस्तावेज़ में सहेजें';

  @override
  String get copiedToClipboard => 'क्लिपबोर्ड पर कॉपी किया गया';

  @override
  String get copy => 'कॉपी';

  @override
  String get noTextExtracted => 'कोई टेक्स्ट नहीं निकाला गया...';

  @override
  String get sourceText => 'मूल टेक्स्ट';

  @override
  String get translation => 'अनुवाद';

  @override
  String get savingDocument => 'दस्तावेज़ सहेजा जा रहा है...';

  @override
  String get launchingScanner => 'स्कैनर शुरू हो रहा है...';

  @override
  String saveDocumentFailed(Object error) {
    return 'दस्तावेज़ सहेजने में विफल: $error';
  }

  @override
  String get editTitle => 'संपादित करें';

  @override
  String get done => 'हो गया';

  @override
  String errorLoadingImage(Object error) {
    return 'छवि लोड करने में त्रुटि: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'फिल्टर लागू करने में त्रुटि $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'परिवर्तन सहेजने में विफल: $error';
  }

  @override
  String get noImage => 'कोई छवि नहीं';

  @override
  String get deleteTagTitle => 'टैग हटाएं';

  @override
  String deleteTagConfirmation(Object tagName) {
    return 'क्या आप वाकई \"$tagName\" को हटाना चाहते हैं?';
  }

  @override
  String get selectTags => 'टैग चुनें';

  @override
  String get manageTags => 'टैग प्रबंधित करें';

  @override
  String get noTags => 'अभी तक कोई टैग नहीं बनाया गया';

  @override
  String get newTagName => 'नया टैग नाम';

  @override
  String errorGeneric(Object error) {
    return 'त्रुटि: $error';
  }

  @override
  String get renameFolder => 'फ़ोल्डर का नाम बदलें';

  @override
  String get emptyFolder => 'खाली फ़ोल्डर';

  @override
  String get exportPdfTitle => 'PDF निर्यात करें';

  @override
  String get includeOcrText => 'OCR टेक्स्ट शामिल करें';

  @override
  String get includeOcrTextSubtitle =>
      'निकाले गए टेक्स्ट के साथ एक अलग पेज जोड़ता है';

  @override
  String get pagesHeader => 'पेज';

  @override
  String get deselectAll => 'सभी को अचयनित करें';

  @override
  String get selectAll => 'सभी का चयन करें';

  @override
  String pageIndex(Object number) {
    return 'पेज $number';
  }

  @override
  String get exportAction => 'निर्यात';

  @override
  String get exportFormat => 'प्रारूप';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'छवियां';

  @override
  String scannedImagesFrom(Object name) {
    return '$name से स्कैन की गई छवियां';
  }
}
