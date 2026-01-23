import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../core/exceptions/app_exceptions.dart';

/// Service for OCR text extraction using Google ML Kit
class OcrService {
  static final TextRecognizer _textRecognizer = TextRecognizer();

  /// Extract text from an image file
  static Future<String> extractText(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      return recognizedText.text;
    } catch (e) {
      throw OcrException('Failed to extract text from image', e);
    }
  }

  /// Extract text with block information for structured output
  static Future<OcrResult> extractTextWithBlocks(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      final blocks = <TextBlockResult>[];
      for (final block in recognizedText.blocks) {
        final lines = <String>[];
        for (final line in block.lines) {
          lines.add(line.text);
        }
        blocks.add(TextBlockResult(
          text: block.text,
          lines: lines,
          language: block.recognizedLanguages.isNotEmpty
              ? block.recognizedLanguages.first
              : 'unknown',
        ));
      }

      return OcrResult(
        fullText: recognizedText.text,
        blocks: blocks,
      );
    } catch (e) {
      throw OcrException('Failed to extract text blocks from image', e);
    }
  }

  /// Extract text from multiple images and combine
  static Future<String> extractTextFromMultipleImages(
    List<String> imagePaths,
  ) async {
    final texts = <String>[];
    for (int i = 0; i < imagePaths.length; i++) {
      final text = await extractText(imagePaths[i]);
      if (text.isNotEmpty) {
        texts.add('--- Page ${i + 1} ---\n$text');
      }
    }
    return texts.join('\n\n');
  }

  /// Close the text recognizer when done
  static void dispose() {
    _textRecognizer.close();
  }
}

/// Result of OCR processing
class OcrResult {
  final String fullText;
  final List<TextBlockResult> blocks;

  OcrResult({
    required this.fullText,
    required this.blocks,
  });
}

/// A single text block result
class TextBlockResult {
  final String text;
  final List<String> lines;
  final String language;

  TextBlockResult({
    required this.text,
    required this.lines,
    required this.language,
  });
}
