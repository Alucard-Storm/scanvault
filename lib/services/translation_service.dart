import 'package:flutter/foundation.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../core/exceptions/app_exceptions.dart';

/// Service for text translation using Google ML Kit
class TranslationService {
  static final OnDeviceTranslatorModelManager _modelManager =
      OnDeviceTranslatorModelManager();

  static OnDeviceTranslator? _translator;
  static TranslateLanguage? _currentSourceLang;
  static TranslateLanguage? _currentTargetLang;

  /// Get list of available languages
  static List<LanguageInfo> getAvailableLanguages() {
    return TranslateLanguage.values.map((lang) {
      return LanguageInfo(
        code: lang.bcpCode,
        name: _getLanguageName(lang),
        language: lang,
      );
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  /// Check if a language model is downloaded
  static Future<bool> isModelDownloaded(TranslateLanguage language) async {
    return await _modelManager.isModelDownloaded(language.bcpCode);
  }

  /// Download a language model
  static Future<void> downloadModel(TranslateLanguage language) async {
    try {
      await _modelManager.downloadModel(language.bcpCode);
    } catch (e) {
      throw TranslationException('Failed to download language model', e);
    }
  }

  /// Delete a language model
  static Future<void> deleteModel(TranslateLanguage language) async {
    try {
      await _modelManager.deleteModel(language.bcpCode);
    } catch (e) {
      debugPrint('Failed to delete model: $e');
    }
  }

  /// Translate text between languages
  static Future<String> translate(
    String text,
    TranslateLanguage sourceLanguage,
    TranslateLanguage targetLanguage,
  ) async {
    if (text.isEmpty) return '';

    try {
      // Create new translator if languages changed
      if (_translator == null ||
          _currentSourceLang != sourceLanguage ||
          _currentTargetLang != targetLanguage) {
        _translator?.close();
        _translator = OnDeviceTranslator(
          sourceLanguage: sourceLanguage,
          targetLanguage: targetLanguage,
        );
        _currentSourceLang = sourceLanguage;
        _currentTargetLang = targetLanguage;
      }

      // Ensure models are downloaded
      if (!await isModelDownloaded(sourceLanguage)) {
        await downloadModel(sourceLanguage);
      }
      if (!await isModelDownloaded(targetLanguage)) {
        await downloadModel(targetLanguage);
      }

      return await _translator!.translateText(text);
    } catch (e) {
      throw TranslationException('Translation failed', e);
    }
  }

  /// Close translator when done
  static void dispose() {
    _translator?.close();
    _translator = null;
  }

  /// Get human-readable language name
  static String _getLanguageName(TranslateLanguage language) {
    return switch (language) {
      TranslateLanguage.afrikaans => 'Afrikaans',
      TranslateLanguage.albanian => 'Albanian',
      TranslateLanguage.arabic => 'Arabic',
      TranslateLanguage.belarusian => 'Belarusian',
      TranslateLanguage.bengali => 'Bengali',
      TranslateLanguage.bulgarian => 'Bulgarian',
      TranslateLanguage.catalan => 'Catalan',
      TranslateLanguage.chinese => 'Chinese',
      TranslateLanguage.croatian => 'Croatian',
      TranslateLanguage.czech => 'Czech',
      TranslateLanguage.danish => 'Danish',
      TranslateLanguage.dutch => 'Dutch',
      TranslateLanguage.english => 'English',
      TranslateLanguage.esperanto => 'Esperanto',
      TranslateLanguage.estonian => 'Estonian',
      TranslateLanguage.finnish => 'Finnish',
      TranslateLanguage.french => 'French',
      TranslateLanguage.galician => 'Galician',
      TranslateLanguage.georgian => 'Georgian',
      TranslateLanguage.german => 'German',
      TranslateLanguage.greek => 'Greek',
      TranslateLanguage.gujarati => 'Gujarati',
      TranslateLanguage.haitian => 'Haitian Creole',
      TranslateLanguage.hebrew => 'Hebrew',
      TranslateLanguage.hindi => 'Hindi',
      TranslateLanguage.hungarian => 'Hungarian',
      TranslateLanguage.icelandic => 'Icelandic',
      TranslateLanguage.indonesian => 'Indonesian',
      TranslateLanguage.irish => 'Irish',
      TranslateLanguage.italian => 'Italian',
      TranslateLanguage.japanese => 'Japanese',
      TranslateLanguage.kannada => 'Kannada',
      TranslateLanguage.korean => 'Korean',
      TranslateLanguage.latvian => 'Latvian',
      TranslateLanguage.lithuanian => 'Lithuanian',
      TranslateLanguage.macedonian => 'Macedonian',
      TranslateLanguage.malay => 'Malay',
      TranslateLanguage.maltese => 'Maltese',
      TranslateLanguage.marathi => 'Marathi',
      TranslateLanguage.norwegian => 'Norwegian',
      TranslateLanguage.persian => 'Persian',
      TranslateLanguage.polish => 'Polish',
      TranslateLanguage.portuguese => 'Portuguese',
      TranslateLanguage.romanian => 'Romanian',
      TranslateLanguage.russian => 'Russian',
      TranslateLanguage.slovak => 'Slovak',
      TranslateLanguage.slovenian => 'Slovenian',
      TranslateLanguage.spanish => 'Spanish',
      TranslateLanguage.swahili => 'Swahili',
      TranslateLanguage.swedish => 'Swedish',
      TranslateLanguage.tagalog => 'Tagalog',
      TranslateLanguage.tamil => 'Tamil',
      TranslateLanguage.telugu => 'Telugu',
      TranslateLanguage.thai => 'Thai',
      TranslateLanguage.turkish => 'Turkish',
      TranslateLanguage.ukrainian => 'Ukrainian',
      TranslateLanguage.urdu => 'Urdu',
      TranslateLanguage.vietnamese => 'Vietnamese',
      TranslateLanguage.welsh => 'Welsh',
    };
  }
}

/// Language information
class LanguageInfo {
  final String code;
  final String name;
  final TranslateLanguage language;

  LanguageInfo({
    required this.code,
    required this.name,
    required this.language,
  });
}
