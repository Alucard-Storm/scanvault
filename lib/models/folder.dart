import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';
part 'folder.g.dart';

/// Represents a folder for organizing documents
@freezed
class Folder with _$Folder {
  const factory Folder({
    required String id,
    required String name,
    String? iconName,
    @Default(0xFF00897B) int colorValue,
    required DateTime createdAt,
    @Default(0) int documentCount,
    @Default(false) bool isLocked,
  }) = _Folder;

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
}
