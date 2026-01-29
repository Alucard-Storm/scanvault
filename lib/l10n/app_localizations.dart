import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
    Locale('kn'),
    Locale('ml'),
    Locale('mr'),
    Locale('pa'),
    Locale('ta'),
    Locale('te'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'ScanVault'**
  String get appTitle;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @foldersTab.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get foldersTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @scanPage.
  ///
  /// In en, this message translates to:
  /// **'Scan Page'**
  String get scanPage;

  /// No description provided for @cameraPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required'**
  String get cameraPermissionRequired;

  /// No description provided for @noCamerasAvailable.
  ///
  /// In en, this message translates to:
  /// **'No cameras available'**
  String get noCamerasAvailable;

  /// No description provided for @errorScanning.
  ///
  /// In en, this message translates to:
  /// **'Error scanning: {error}'**
  String errorScanning(Object error);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @ocr.
  ///
  /// In en, this message translates to:
  /// **'OCR'**
  String get ocr;

  /// No description provided for @translate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translate;

  /// No description provided for @proFeature.
  ///
  /// In en, this message translates to:
  /// **'Pro Feature'**
  String get proFeature;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage location'**
  String get settingsStorage;

  /// No description provided for @settingsClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get settingsClearCache;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsLicenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get settingsLicenses;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search documents...'**
  String get searchHint;

  /// No description provided for @noDocuments.
  ///
  /// In en, this message translates to:
  /// **'No documents yet'**
  String get noDocuments;

  /// No description provided for @noDocumentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan a document to get started'**
  String get noDocumentsSubtitle;

  /// No description provided for @scanFab.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanFab;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @moveToFolder.
  ///
  /// In en, this message translates to:
  /// **'Move to Folder'**
  String get moveToFolder;

  /// No description provided for @moveToRoot.
  ///
  /// In en, this message translates to:
  /// **'None (Root)'**
  String get moveToRoot;

  /// No description provided for @deleteDocumentTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Document'**
  String get deleteDocumentTitle;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteConfirmation(Object name);

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted'**
  String deleted(Object name);

  /// No description provided for @movedToRoot.
  ///
  /// In en, this message translates to:
  /// **'Moved to root'**
  String get movedToRoot;

  /// No description provided for @movedTo.
  ///
  /// In en, this message translates to:
  /// **'Moved to {folderName}'**
  String movedTo(Object folderName);

  /// No description provided for @documentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Document not found'**
  String get documentNotFound;

  /// No description provided for @editPage.
  ///
  /// In en, this message translates to:
  /// **'Edit Page'**
  String get editPage;

  /// No description provided for @addPage.
  ///
  /// In en, this message translates to:
  /// **'Add Page'**
  String get addPage;

  /// No description provided for @sharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePdf;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @pageCount.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageCount(Object current, Object total);

  /// No description provided for @pagesAdded.
  ///
  /// In en, this message translates to:
  /// **'{count} page(s) added successfully'**
  String pagesAdded(Object count);

  /// No description provided for @pageAddFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add page: {error}'**
  String pageAddFailed(Object error);

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export Failed: {error}'**
  String exportFailed(Object error);

  /// No description provided for @noFolders.
  ///
  /// In en, this message translates to:
  /// **'No folders yet'**
  String get noFolders;

  /// No description provided for @noFoldersAvailable.
  ///
  /// In en, this message translates to:
  /// **'No folders available. Create one first.'**
  String get noFoldersAvailable;

  /// No description provided for @newFolder.
  ///
  /// In en, this message translates to:
  /// **'New Folder'**
  String get newFolder;

  /// No description provided for @folderName.
  ///
  /// In en, this message translates to:
  /// **'Folder Name'**
  String get folderName;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @editFolder.
  ///
  /// In en, this message translates to:
  /// **'Edit Folder'**
  String get editFolder;

  /// No description provided for @deleteFolderTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Folder'**
  String get deleteFolderTitle;

  /// No description provided for @deleteFolderConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete this folder? Documents inside will be moved to root.'**
  String get deleteFolderConfirmation;

  /// No description provided for @folderItems.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String folderItems(Object count);

  /// No description provided for @extractedText.
  ///
  /// In en, this message translates to:
  /// **'Extracted Text'**
  String get extractedText;

  /// No description provided for @ocrFailed.
  ///
  /// In en, this message translates to:
  /// **'OCR Failed: {error}'**
  String ocrFailed(Object error);

  /// No description provided for @textSaved.
  ///
  /// In en, this message translates to:
  /// **'Text saved to document'**
  String get textSaved;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {error}'**
  String saveFailed(Object error);

  /// No description provided for @saveToDocument.
  ///
  /// In en, this message translates to:
  /// **'Save to Document'**
  String get saveToDocument;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @noTextExtracted.
  ///
  /// In en, this message translates to:
  /// **'No text extracted...'**
  String get noTextExtracted;

  /// No description provided for @sourceText.
  ///
  /// In en, this message translates to:
  /// **'Source Text'**
  String get sourceText;

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation;

  /// No description provided for @savingDocument.
  ///
  /// In en, this message translates to:
  /// **'Saving Document...'**
  String get savingDocument;

  /// No description provided for @launchingScanner.
  ///
  /// In en, this message translates to:
  /// **'Launching Scanner...'**
  String get launchingScanner;

  /// No description provided for @saveDocumentFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save document: {error}'**
  String saveDocumentFailed(Object error);

  /// No description provided for @editTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editTitle;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @errorLoadingImage.
  ///
  /// In en, this message translates to:
  /// **'Error loading image: {error}'**
  String errorLoadingImage(Object error);

  /// No description provided for @errorApplyingFilter.
  ///
  /// In en, this message translates to:
  /// **'Error applying filter: {error}'**
  String errorApplyingFilter(Object error);

  /// No description provided for @saveChangesFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save changes: {error}'**
  String saveChangesFailed(Object error);

  /// No description provided for @noImage.
  ///
  /// In en, this message translates to:
  /// **'No image'**
  String get noImage;

  /// No description provided for @deleteTagTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Tag'**
  String get deleteTagTitle;

  /// No description provided for @deleteTagConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{tagName}\"?'**
  String deleteTagConfirmation(Object tagName);

  /// No description provided for @selectTags.
  ///
  /// In en, this message translates to:
  /// **'Select Tags'**
  String get selectTags;

  /// No description provided for @manageTags.
  ///
  /// In en, this message translates to:
  /// **'Manage Tags'**
  String get manageTags;

  /// No description provided for @noTags.
  ///
  /// In en, this message translates to:
  /// **'No tags created yet'**
  String get noTags;

  /// No description provided for @newTagName.
  ///
  /// In en, this message translates to:
  /// **'New Tag Name'**
  String get newTagName;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorGeneric(Object error);

  /// No description provided for @renameFolder.
  ///
  /// In en, this message translates to:
  /// **'Rename Folder'**
  String get renameFolder;

  /// No description provided for @emptyFolder.
  ///
  /// In en, this message translates to:
  /// **'Empty Folder'**
  String get emptyFolder;

  /// No description provided for @exportPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdfTitle;

  /// No description provided for @includeOcrText.
  ///
  /// In en, this message translates to:
  /// **'Include OCR Text'**
  String get includeOcrText;

  /// No description provided for @includeOcrTextSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Adds a separate page with extracted text'**
  String get includeOcrTextSubtitle;

  /// No description provided for @pagesHeader.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pagesHeader;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get deselectAll;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @pageIndex.
  ///
  /// In en, this message translates to:
  /// **'Page {number}'**
  String pageIndex(Object number);

  /// No description provided for @exportAction.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportAction;

  /// No description provided for @exportFormat.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get exportFormat;

  /// No description provided for @pdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get pdf;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @scannedImagesFrom.
  ///
  /// In en, this message translates to:
  /// **'Scanned images from {name}'**
  String scannedImagesFrom(Object name);

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @settingsStorageHeader.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get settingsStorageHeader;

  /// No description provided for @storageInternal.
  ///
  /// In en, this message translates to:
  /// **'Internal storage (Default)'**
  String get storageInternal;

  /// No description provided for @resetToDefault.
  ///
  /// In en, this message translates to:
  /// **'Reset to default'**
  String get resetToDefault;

  /// No description provided for @freeUpSpace.
  ///
  /// In en, this message translates to:
  /// **'Free up space'**
  String get freeUpSpace;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get chooseTheme;

  /// No description provided for @clearCacheTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get clearCacheTitle;

  /// No description provided for @clearCacheMessage.
  ///
  /// In en, this message translates to:
  /// **'This will delete temporary files. Your saved documents will NOT be deleted. Continue?'**
  String get clearCacheMessage;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @cacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared successfully'**
  String get cacheCleared;

  /// No description provided for @cacheClearFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to clear cache: {error}'**
  String cacheClearFailed(Object error);

  /// No description provided for @storageLocation.
  ///
  /// In en, this message translates to:
  /// **'Storage Location'**
  String get storageLocation;

  /// No description provided for @storageDefault.
  ///
  /// In en, this message translates to:
  /// **'Default (Internal)'**
  String get storageDefault;

  /// No description provided for @storageCustom.
  ///
  /// In en, this message translates to:
  /// **'Select Custom Folder...'**
  String get storageCustom;

  /// No description provided for @storageWriteError.
  ///
  /// In en, this message translates to:
  /// **'Cannot write to this folder: {error}'**
  String storageWriteError(Object error);

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @moreOptions.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get moreOptions;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bn',
    'en',
    'gu',
    'hi',
    'kn',
    'ml',
    'mr',
    'pa',
    'ta',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'pa':
      return AppLocalizationsPa();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
