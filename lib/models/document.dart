import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';
part 'document.g.dart';

/// Filter types for image enhancement
enum FilterType {
  original,
  grayscale,
  blackAndWhite,
  magicColor,
  document,
}

/// Represents a scanned document with multiple pages
@freezed
class Document with _$Document {
  const factory Document({
    required String id,
    required String name,
    required DateTime createdAt,
    required DateTime modifiedAt,
    String? folderId,
    @Default([]) List<String> tagIds,
    @Default([]) List<ScannedPage> pages,
    String? ocrText,
    String? thumbnailPath,
  }) = _Document;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
}

/// Represents a single scanned page within a document
@freezed
class ScannedPage with _$ScannedPage {
  const factory ScannedPage({
    required String id,
    required String imagePath,
    String? processedImagePath,
    required int pageNumber,
    @Default(FilterType.original) FilterType appliedFilter,
    String? ocrText,
  }) = _ScannedPage;

  factory ScannedPage.fromJson(Map<String, dynamic> json) =>
      _$ScannedPageFromJson(json);
}
