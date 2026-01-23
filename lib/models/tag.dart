import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

/// Represents a tag for categorizing documents
@freezed
class Tag with _$Tag {
  const factory Tag({
    required String id,
    required String name,
    @Default(0xFF7C4DFF) int colorValue,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
