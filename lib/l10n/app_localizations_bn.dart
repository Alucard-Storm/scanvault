// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'হোম';

  @override
  String get foldersTab => 'ফোল্ডার';

  @override
  String get settingsTab => 'সেটিংস';

  @override
  String get scanPage => 'স্ক্যান পেজ';

  @override
  String get cameraPermissionRequired => 'ক্যামেরার অনুমতি প্রয়োজন';

  @override
  String get noCamerasAvailable => 'কোন ক্যামেরা পাওয়া যায়নি';

  @override
  String errorScanning(Object error) {
    return 'স্ক্যানিং ত্রুটি: $error';
  }

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get cancel => 'বাতিল';

  @override
  String get delete => 'মুছুন';

  @override
  String get edit => 'সম্পাদনা';

  @override
  String get share => 'শেয়ার';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'অনুবাদ';

  @override
  String get proFeature => 'প্রো ফিচার';

  @override
  String get settingsLanguage => 'ভাষা';

  @override
  String get settingsTheme => 'থিম';

  @override
  String get settingsStorage => 'স্টোরেজ লোকেশন';

  @override
  String get settingsClearCache => 'ক্যাশ পরিষ্কার করুন';

  @override
  String get settingsAbout => 'সম্পর্কে';

  @override
  String get settingsVersion => 'সংস্করণ';

  @override
  String get settingsLicenses => 'লাইসেন্স';

  @override
  String get searchHint => 'নথি অনুসন্ধান করুন...';

  @override
  String get noDocuments => 'কোন নথি নেই';

  @override
  String get noDocumentsSubtitle => 'শুরু করতে একটি নথি স্ক্যান করুন';

  @override
  String get scanFab => 'স্ক্যান';

  @override
  String get rename => 'নাম পরিবর্তন';

  @override
  String get moveToFolder => 'ফোল্ডারে সরান';

  @override
  String get moveToRoot => 'কিছুই না (রুট)';

  @override
  String get deleteDocumentTitle => 'নথি মুছুন';

  @override
  String deleteConfirmation(Object name) {
    return 'আপনি কি নিশ্চিত যে আপনি \"$name\" মুছতে চান?';
  }

  @override
  String deleted(Object name) {
    return '$name মুছে ফেলা হয়েছে';
  }

  @override
  String get movedToRoot => 'রুটে সরানো হয়েছে';

  @override
  String movedTo(Object folderName) {
    return '$folderName-এ সরানো হয়েছে';
  }

  @override
  String get documentNotFound => 'নথি পাওয়া যায়নি';

  @override
  String get editPage => 'পেজ সম্পাদনা';

  @override
  String get addPage => 'পেজ যোগ করুন';

  @override
  String get sharePdf => 'PDF শেয়ার করুন';

  @override
  String get tags => 'ট্যাগ';

  @override
  String pageCount(Object current, Object total) {
    return 'পেজ $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count টি পেজ সফলভাবে যোগ করা হয়েছে';
  }

  @override
  String pageAddFailed(Object error) {
    return 'পেজ যোগ করতে ব্যর্থ: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'রপ্তানি ব্যর্থ: $error';
  }

  @override
  String get noFolders => 'কোন ফোল্ডার নেই';

  @override
  String get noFoldersAvailable =>
      'কোন ফোল্ডার উপলব্ধ নেই। প্রথমে একটি তৈরি করুন।';

  @override
  String get newFolder => 'নতুন ফোল্ডার';

  @override
  String get folderName => 'ফোল্ডারের নাম';

  @override
  String get create => 'তৈরি করুন';

  @override
  String get editFolder => 'ফোল্ডার সম্পাদনা';

  @override
  String get deleteFolderTitle => 'ফোল্ডার মুছুন';

  @override
  String get deleteFolderConfirmation =>
      'এই ফোল্ডারটি কি মুছতে চান? ভিতরের নথিগুলি রুটে সরানো হবে।';

  @override
  String folderItems(Object count) {
    return '$count টি আইটেম';
  }

  @override
  String get extractedText => 'নিষ্কাশিত টেক্সট';

  @override
  String ocrFailed(Object error) {
    return 'OCR ব্যর্থ: $error';
  }

  @override
  String get textSaved => 'টেক্সট নথিতে সংরক্ষিত হয়েছে';

  @override
  String saveFailed(Object error) {
    return 'সংরক্ষণ করতে ব্যর্থ: $error';
  }

  @override
  String get saveToDocument => 'নথিতে সংরক্ষণ করুন';

  @override
  String get copiedToClipboard => 'ক্লিপবোর্ডে কপি করা হয়েছে';

  @override
  String get copy => 'কপি';

  @override
  String get noTextExtracted => 'কোন টেক্সট নিষ্কাশন করা হয়নি...';

  @override
  String get sourceText => 'মূল টেক্সট';

  @override
  String get translation => 'অনুবাদ';

  @override
  String get savingDocument => 'নথি সংরক্ষণ করা হচ্ছে...';

  @override
  String get launchingScanner => 'স্ক্যানার চালু হচ্ছে...';

  @override
  String saveDocumentFailed(Object error) {
    return 'নথি সংরক্ষণ করতে ব্যর্থ: $error';
  }

  @override
  String get editTitle => 'সম্পাদনা';

  @override
  String get done => 'সম্পন্ন';

  @override
  String errorLoadingImage(Object error) {
    return 'ইমেজ লোড করতে ত্রুটি: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'ফিল্টার প্রয়োগ করতে ত্রুটি: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'পরিবর্তন সংরক্ষণ করতে ব্যর্থ: $error';
  }

  @override
  String get noImage => 'কোন ইমেজ নেই';

  @override
  String get deleteTagTitle => 'ট্যাগ মুছুন';

  @override
  String deleteTagConfirmation(Object tagName) {
    return 'আপনি কি নিশ্চিত যে আপনি \"$tagName\" ট্যাগটি মুছতে চান?';
  }

  @override
  String get selectTags => 'ট্যাগ নির্বাচন করুন';

  @override
  String get manageTags => 'ট্যাগ পরিচালনা করুন';

  @override
  String get noTags => 'এখনো কোন ট্যাগ তৈরি হয়নি';

  @override
  String get newTagName => 'নতুন ট্যাগের নাম';

  @override
  String errorGeneric(Object error) {
    return 'ত্রুটি: $error';
  }

  @override
  String get renameFolder => 'ফোল্ডারের নাম পরিবর্তন';

  @override
  String get emptyFolder => 'খালি ফোল্ডার';

  @override
  String get exportPdfTitle => 'PDF রপ্তানি করুন';

  @override
  String get includeOcrText => 'OCR টেক্সট অন্তর্ভুক্ত করুন';

  @override
  String get includeOcrTextSubtitle =>
      'নিষ্কাশিত টেক্সট সহ একটি পৃথক পেজ যোগ করে';

  @override
  String get pagesHeader => 'পেজগুলো';

  @override
  String get deselectAll => 'সব অনির্বাচন করুন';

  @override
  String get selectAll => 'সব নির্বাচন করুন';

  @override
  String pageIndex(Object number) {
    return 'পেজ $number';
  }

  @override
  String get exportAction => 'রপ্তানি';

  @override
  String get exportFormat => 'বিন্যাস';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'ছবি';

  @override
  String scannedImagesFrom(Object name) {
    return '$name থেকে স্ক্যান করা ছবি';
  }

  @override
  String get settingsAppearance => 'চেহারা';

  @override
  String get themeSystem => 'সিস্টেম ডিফল্ট';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get settingsStorageHeader => 'স্টোরেজ';

  @override
  String get storageInternal => 'অভ্যন্তরীণ স্টোরেজ (ডিফল্ট)';

  @override
  String get resetToDefault => 'ডিফল্টে রিসেট করুন';

  @override
  String get freeUpSpace => 'জায়গা খালি করুন';

  @override
  String get chooseTheme => 'থিম চয়ন করুন';

  @override
  String get clearCacheTitle => 'ক্যাশ পরিষ্কার করুন';

  @override
  String get clearCacheMessage =>
      'এটি অস্থায়ী ফাইল মুছে ফেলবে। আপনার সংরক্ষিত নথি মুছে ফেলা হবে না। চালিয়ে যাবেন?';

  @override
  String get clear => 'পরিষ্কার';

  @override
  String get cacheCleared => 'ক্যাশ সফলভাবে পরিষ্কার করা হয়েছে';

  @override
  String cacheClearFailed(Object error) {
    return 'ক্যাশ পরিষ্কার করতে ব্যর্থ: $error';
  }

  @override
  String get storageLocation => 'স্টোরেজ লোকেশন';

  @override
  String get storageDefault => 'ডিফল্ট (অভ্যন্তরীণ)';

  @override
  String get storageCustom => 'কাস্টম ফোল্ডার নির্বাচন করুন...';

  @override
  String storageWriteError(Object error) {
    return 'এই ফোল্ডারে লেখা সম্ভব নয়: $error';
  }

  @override
  String get chooseLanguage => 'ভাষা চয়ন করুন';

  @override
  String get moreOptions => 'আরও বিকল্প';

  @override
  String get useSystemColor => 'სਿਸਟਮ কালার ব্যবহার করুন';
}
