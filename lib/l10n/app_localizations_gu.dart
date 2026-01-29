// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'ScanVault';

  @override
  String get homeTab => 'હોમ';

  @override
  String get foldersTab => 'ફોલ્ડર';

  @override
  String get settingsTab => 'સેટિંગ્સ';

  @override
  String get scanPage => 'પેજ સ્કેન કરો';

  @override
  String get cameraPermissionRequired => 'કેમેરા પરવાનગી જરૂરી છે';

  @override
  String get noCamerasAvailable => 'કોઈ કેમેરા ઉપલબ્ધ નથી';

  @override
  String errorScanning(Object error) {
    return 'સ્કેનિંગ ભૂલ: $error';
  }

  @override
  String get save => 'સાચવો';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get delete => 'કાઢી નાખો';

  @override
  String get edit => 'ફેરફાર કરો';

  @override
  String get share => 'શેર કરો';

  @override
  String get ocr => 'OCR';

  @override
  String get translate => 'અનુવાદ';

  @override
  String get proFeature => 'પ્રો ફીચર';

  @override
  String get settingsLanguage => 'ભાષા';

  @override
  String get settingsTheme => 'થીમ';

  @override
  String get settingsStorage => 'સ્ટોરેજ લોકેશન';

  @override
  String get settingsClearCache => 'કેશ સાફ કરો';

  @override
  String get settingsAbout => 'વિશે';

  @override
  String get settingsVersion => 'આવૃત્તિ';

  @override
  String get settingsLicenses => 'લાયસન્સ';

  @override
  String get searchHint => 'દસ્તાવેજો શોધો...';

  @override
  String get noDocuments => 'કોઈ દસ્તાવેજો નથી';

  @override
  String get noDocumentsSubtitle => 'શરૂ કરવા માટે દસ્તાવેજ સ્કેન કરો';

  @override
  String get scanFab => 'સ્કેન';

  @override
  String get rename => 'નામ બદલો';

  @override
  String get moveToFolder => 'ફોલ્ડરમાં ખસેડો';

  @override
  String get moveToRoot => 'કંઈ નથી (રુટ)';

  @override
  String get deleteDocumentTitle => 'દસ્તાવેજ કાઢી નાખો';

  @override
  String deleteConfirmation(Object name) {
    return 'શું તમે ખાતરી કરો છો કે તમે \"$name\" કાઢી નાખવા માંગો છો?';
  }

  @override
  String deleted(Object name) {
    return '$name કાઢી નાખ્યું';
  }

  @override
  String get movedToRoot => 'રુટમાં ખસેડ્યું';

  @override
  String movedTo(Object folderName) {
    return '$folderName માં ખસેડ્યું';
  }

  @override
  String get documentNotFound => 'દસ્તાવેજ મળ્યો નથી';

  @override
  String get editPage => 'પેજમાં ફેરફાર કરો';

  @override
  String get addPage => 'પેજ ઉમેરો';

  @override
  String get sharePdf => 'PDF શેર કરો';

  @override
  String get tags => 'ટૅગ્સ';

  @override
  String pageCount(Object current, Object total) {
    return 'પેજ $current / $total';
  }

  @override
  String pagesAdded(Object count) {
    return '$count પેજ સફળતાપૂર્વક ઉમેર્યા';
  }

  @override
  String pageAddFailed(Object error) {
    return 'પેજ ઉમેરવામાં નિષ્ફળ: $error';
  }

  @override
  String exportFailed(Object error) {
    return 'નિકાસ નિષ્ફળ: $error';
  }

  @override
  String get noFolders => 'કોઈ ફોલ્ડર્સ નથી';

  @override
  String get noFoldersAvailable => 'કોઈ ફોલ્ડર્સ ઉપલબ્ધ નથી. પહેલા એક બનાવો.';

  @override
  String get newFolder => 'નવું ફોલ્ડર';

  @override
  String get folderName => 'ફોલ્ડર નામ';

  @override
  String get create => 'બનાવો';

  @override
  String get editFolder => 'ફોલ્ડરમાં ફેરફાર કરો';

  @override
  String get deleteFolderTitle => 'ફોલ્ડર કાઢી નાખો';

  @override
  String get deleteFolderConfirmation =>
      'આ ફોલ્ડર કાઢી નાખવું છે? અંદરના દસ્તાવેજો રુટમાં ખસેડવામાં આવશે.';

  @override
  String folderItems(Object count) {
    return '$count આઈટમ્સ';
  }

  @override
  String get extractedText => 'એક્સટ્રેક્ટ કરેલો ટેક્સ્ટ';

  @override
  String ocrFailed(Object error) {
    return 'OCR નિષ્ફળ: $error';
  }

  @override
  String get textSaved => 'ટેક્સ્ટ દસ્તાવેજમાં સાચવ્યો';

  @override
  String saveFailed(Object error) {
    return 'સાચવવામાં નિષ્ફળ: $error';
  }

  @override
  String get saveToDocument => 'દસ્તાવેજમાં સાચવો';

  @override
  String get copiedToClipboard => 'ક્લિપબોર્ડ પર કૉપિ કર્યું';

  @override
  String get copy => 'કૉપિ';

  @override
  String get noTextExtracted => 'કોઈ ટેક્સ્ટ એક્સટ્રેક્ટ કર્યો નથી...';

  @override
  String get sourceText => 'મૂળ ટેક્સ્ટ';

  @override
  String get translation => 'અનુવાદ';

  @override
  String get savingDocument => 'દસ્તાવેજ સાચવી રહ્યું છે...';

  @override
  String get launchingScanner => 'સ્કેનર શરૂ થઈ રહ્યું છે...';

  @override
  String saveDocumentFailed(Object error) {
    return 'દસ્તાવેજ સાચવવામાં નિષ્ફળ: $error';
  }

  @override
  String get editTitle => 'ફેરફાર કરો';

  @override
  String get done => 'થઈ ગયું';

  @override
  String errorLoadingImage(Object error) {
    return 'ઈમેજ લોડ કરવામાં ભૂલ: $error';
  }

  @override
  String errorApplyingFilter(Object error) {
    return 'ફિલ્ટર લાગુ કરવામાં ભૂલ: $error';
  }

  @override
  String saveChangesFailed(Object error) {
    return 'ફેરફારો સાચવવામાં નિષ્ફળ: $error';
  }

  @override
  String get noImage => 'કોઈ ઈમેજ નથી';

  @override
  String get deleteTagTitle => 'ટૅગ કાઢી નાખો';

  @override
  String deleteTagConfirmation(Object tagName) {
    return 'શું તમે ખાતરી કરો છો કે તમે \"$tagName\" ટૅગ કાઢી નાખવા માંગો છો?';
  }

  @override
  String get selectTags => 'ટૅગ્સ પસંદ કરો';

  @override
  String get manageTags => 'ટૅગ્સ મેનેજ કરો';

  @override
  String get noTags => 'હજુ સુધી કોઈ ટૅગ્સ બનાવેલ નથી';

  @override
  String get newTagName => 'નવું ટૅગ નામ';

  @override
  String errorGeneric(Object error) {
    return 'ભૂલ: $error';
  }

  @override
  String get renameFolder => 'ફોલ્ડર નવું નામ આપો';

  @override
  String get emptyFolder => 'ખાલી ફોલ્ડર';

  @override
  String get exportPdfTitle => 'PDF નિકાસ કરો';

  @override
  String get includeOcrText => 'OCR ટેક્સ્ટ શામેલ કરો';

  @override
  String get includeOcrTextSubtitle =>
      'એક્સટ્રેક્ટ કરેલા ટેક્સ્ટ સાથે એક અલગ પેજ ઉમેરે છે';

  @override
  String get pagesHeader => 'પેજ';

  @override
  String get deselectAll => 'બધું નાપસંદ કરો';

  @override
  String get selectAll => 'બધું પસંદ કરો';

  @override
  String pageIndex(Object number) {
    return 'પેજ $number';
  }

  @override
  String get exportAction => 'નિકાસ કરો';

  @override
  String get exportFormat => 'ફોર્મેટ';

  @override
  String get pdf => 'PDF';

  @override
  String get images => 'છબીઓ';

  @override
  String scannedImagesFrom(Object name) {
    return '$name માંથી સ્કેન કરેલી છબીઓ';
  }
}
