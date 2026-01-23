import 'dart:typed_data';
import 'package:image/image.dart' as img;

import '../models/document.dart';

/// Service for applying image filters and enhancements
class FilterService {
  FilterService._();

  /// Apply filter to image bytes
  static Future<Uint8List> applyFilter(
    Uint8List imageBytes,
    FilterType filterType,
  ) async {
    final image = img.decodeImage(imageBytes);
    if (image == null) throw Exception('Failed to decode image');

    final processed = switch (filterType) {
      FilterType.original => image,
      FilterType.grayscale => _applyGrayscale(image),
      FilterType.blackAndWhite => _applyBlackAndWhite(image),
      FilterType.magicColor => _applyMagicColor(image),
      FilterType.document => _applyDocumentFilter(image),
    };

    return Uint8List.fromList(img.encodeJpg(processed, quality: 90));
  }

  /// Convert to grayscale
  static img.Image _applyGrayscale(img.Image image) {
    return img.grayscale(image);
  }

  /// Apply high contrast black and white
  static img.Image _applyBlackAndWhite(img.Image image) {
    // Convert to grayscale first
    var result = img.grayscale(image);
    // Increase contrast
    result = img.contrast(result, contrast: 150);
    // Apply threshold for pure B&W effect
    result = img.luminanceThreshold(result, threshold: 0.5);
    return result;
  }

  /// Apply magic color enhancement
  static img.Image _applyMagicColor(img.Image image) {
    var result = image;
    // Boost saturation
    result = img.adjustColor(result, saturation: 1.3);
    // Slight contrast boost
    result = img.contrast(result, contrast: 110);
    // Slight brightness adjustment
    result = img.adjustColor(result, brightness: 1.05);
    return result;
  }

  /// Apply document-optimized filter
  static img.Image _applyDocumentFilter(img.Image image) {
    var result = image;
    // Convert to grayscale
    result = img.grayscale(result);
    // High contrast for text clarity
    result = img.contrast(result, contrast: 130);
    // Normalize levels
    result = img.normalize(result, min: 10, max: 245);
    return result;
  }

  /// Generate filter preview thumbnails
  static Future<Map<FilterType, Uint8List>> generatePreviews(
    Uint8List imageBytes, {
    int thumbnailSize = 120,
  }) async {
    final image = img.decodeImage(imageBytes);
    if (image == null) throw Exception('Failed to decode image');

    // Create small thumbnail for faster preview
    final thumbnail = img.copyResizeCropSquare(image, size: thumbnailSize);

    final previews = <FilterType, Uint8List>{};
    for (final filter in FilterType.values) {
      final processed = switch (filter) {
        FilterType.original => thumbnail,
        FilterType.grayscale => _applyGrayscale(thumbnail),
        FilterType.blackAndWhite => _applyBlackAndWhite(thumbnail),
        FilterType.magicColor => _applyMagicColor(thumbnail),
        FilterType.document => _applyDocumentFilter(thumbnail),
      };
      previews[filter] = Uint8List.fromList(img.encodeJpg(processed, quality: 80));
    }

    return previews;
  }

  /// Get human-readable filter name
  static String getFilterName(FilterType filter) {
    return switch (filter) {
      FilterType.original => 'Original',
      FilterType.grayscale => 'Grayscale',
      FilterType.blackAndWhite => 'Black & White',
      FilterType.magicColor => 'Magic Color',
      FilterType.document => 'Document',
    };
  }
}
