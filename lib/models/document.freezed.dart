// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return _Document.fromJson(json);
}

/// @nodoc
mixin _$Document {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get modifiedAt => throw _privateConstructorUsedError;
  String? get folderId => throw _privateConstructorUsedError;
  List<String> get tagIds => throw _privateConstructorUsedError;
  List<ScannedPage> get pages => throw _privateConstructorUsedError;
  String? get ocrText => throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentCopyWith<Document> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<$Res> {
  factory $DocumentCopyWith(Document value, $Res Function(Document) then) =
      _$DocumentCopyWithImpl<$Res, Document>;
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    DateTime modifiedAt,
    String? folderId,
    List<String> tagIds,
    List<ScannedPage> pages,
    String? ocrText,
    String? thumbnailPath,
  });
}

/// @nodoc
class _$DocumentCopyWithImpl<$Res, $Val extends Document>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? modifiedAt = null,
    Object? folderId = freezed,
    Object? tagIds = null,
    Object? pages = null,
    Object? ocrText = freezed,
    Object? thumbnailPath = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            modifiedAt: null == modifiedAt
                ? _value.modifiedAt
                : modifiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            folderId: freezed == folderId
                ? _value.folderId
                : folderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tagIds: null == tagIds
                ? _value.tagIds
                : tagIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            pages: null == pages
                ? _value.pages
                : pages // ignore: cast_nullable_to_non_nullable
                      as List<ScannedPage>,
            ocrText: freezed == ocrText
                ? _value.ocrText
                : ocrText // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbnailPath: freezed == thumbnailPath
                ? _value.thumbnailPath
                : thumbnailPath // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DocumentImplCopyWith(
    _$DocumentImpl value,
    $Res Function(_$DocumentImpl) then,
  ) = __$$DocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    DateTime modifiedAt,
    String? folderId,
    List<String> tagIds,
    List<ScannedPage> pages,
    String? ocrText,
    String? thumbnailPath,
  });
}

/// @nodoc
class __$$DocumentImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DocumentImpl>
    implements _$$DocumentImplCopyWith<$Res> {
  __$$DocumentImplCopyWithImpl(
    _$DocumentImpl _value,
    $Res Function(_$DocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? modifiedAt = null,
    Object? folderId = freezed,
    Object? tagIds = null,
    Object? pages = null,
    Object? ocrText = freezed,
    Object? thumbnailPath = freezed,
  }) {
    return _then(
      _$DocumentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        modifiedAt: null == modifiedAt
            ? _value.modifiedAt
            : modifiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        folderId: freezed == folderId
            ? _value.folderId
            : folderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tagIds: null == tagIds
            ? _value._tagIds
            : tagIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        pages: null == pages
            ? _value._pages
            : pages // ignore: cast_nullable_to_non_nullable
                  as List<ScannedPage>,
        ocrText: freezed == ocrText
            ? _value.ocrText
            : ocrText // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbnailPath: freezed == thumbnailPath
            ? _value.thumbnailPath
            : thumbnailPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentImpl implements _Document {
  const _$DocumentImpl({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.modifiedAt,
    this.folderId,
    final List<String> tagIds = const [],
    final List<ScannedPage> pages = const [],
    this.ocrText,
    this.thumbnailPath,
  }) : _tagIds = tagIds,
       _pages = pages;

  factory _$DocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  final DateTime modifiedAt;
  @override
  final String? folderId;
  final List<String> _tagIds;
  @override
  @JsonKey()
  List<String> get tagIds {
    if (_tagIds is EqualUnmodifiableListView) return _tagIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagIds);
  }

  final List<ScannedPage> _pages;
  @override
  @JsonKey()
  List<ScannedPage> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  final String? ocrText;
  @override
  final String? thumbnailPath;

  @override
  String toString() {
    return 'Document(id: $id, name: $name, createdAt: $createdAt, modifiedAt: $modifiedAt, folderId: $folderId, tagIds: $tagIds, pages: $pages, ocrText: $ocrText, thumbnailPath: $thumbnailPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.folderId, folderId) ||
                other.folderId == folderId) &&
            const DeepCollectionEquality().equals(other._tagIds, _tagIds) &&
            const DeepCollectionEquality().equals(other._pages, _pages) &&
            (identical(other.ocrText, ocrText) || other.ocrText == ocrText) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    createdAt,
    modifiedAt,
    folderId,
    const DeepCollectionEquality().hash(_tagIds),
    const DeepCollectionEquality().hash(_pages),
    ocrText,
    thumbnailPath,
  );

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      __$$DocumentImplCopyWithImpl<_$DocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentImplToJson(this);
  }
}

abstract class _Document implements Document {
  const factory _Document({
    required final String id,
    required final String name,
    required final DateTime createdAt,
    required final DateTime modifiedAt,
    final String? folderId,
    final List<String> tagIds,
    final List<ScannedPage> pages,
    final String? ocrText,
    final String? thumbnailPath,
  }) = _$DocumentImpl;

  factory _Document.fromJson(Map<String, dynamic> json) =
      _$DocumentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  DateTime get modifiedAt;
  @override
  String? get folderId;
  @override
  List<String> get tagIds;
  @override
  List<ScannedPage> get pages;
  @override
  String? get ocrText;
  @override
  String? get thumbnailPath;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScannedPage _$ScannedPageFromJson(Map<String, dynamic> json) {
  return _ScannedPage.fromJson(json);
}

/// @nodoc
mixin _$ScannedPage {
  String get id => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  String? get processedImagePath => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  FilterType get appliedFilter => throw _privateConstructorUsedError;
  String? get ocrText => throw _privateConstructorUsedError;

  /// Serializes this ScannedPage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScannedPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScannedPageCopyWith<ScannedPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannedPageCopyWith<$Res> {
  factory $ScannedPageCopyWith(
    ScannedPage value,
    $Res Function(ScannedPage) then,
  ) = _$ScannedPageCopyWithImpl<$Res, ScannedPage>;
  @useResult
  $Res call({
    String id,
    String imagePath,
    String? processedImagePath,
    int pageNumber,
    FilterType appliedFilter,
    String? ocrText,
  });
}

/// @nodoc
class _$ScannedPageCopyWithImpl<$Res, $Val extends ScannedPage>
    implements $ScannedPageCopyWith<$Res> {
  _$ScannedPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScannedPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = null,
    Object? processedImagePath = freezed,
    Object? pageNumber = null,
    Object? appliedFilter = null,
    Object? ocrText = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            imagePath: null == imagePath
                ? _value.imagePath
                : imagePath // ignore: cast_nullable_to_non_nullable
                      as String,
            processedImagePath: freezed == processedImagePath
                ? _value.processedImagePath
                : processedImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            pageNumber: null == pageNumber
                ? _value.pageNumber
                : pageNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            appliedFilter: null == appliedFilter
                ? _value.appliedFilter
                : appliedFilter // ignore: cast_nullable_to_non_nullable
                      as FilterType,
            ocrText: freezed == ocrText
                ? _value.ocrText
                : ocrText // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScannedPageImplCopyWith<$Res>
    implements $ScannedPageCopyWith<$Res> {
  factory _$$ScannedPageImplCopyWith(
    _$ScannedPageImpl value,
    $Res Function(_$ScannedPageImpl) then,
  ) = __$$ScannedPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String imagePath,
    String? processedImagePath,
    int pageNumber,
    FilterType appliedFilter,
    String? ocrText,
  });
}

/// @nodoc
class __$$ScannedPageImplCopyWithImpl<$Res>
    extends _$ScannedPageCopyWithImpl<$Res, _$ScannedPageImpl>
    implements _$$ScannedPageImplCopyWith<$Res> {
  __$$ScannedPageImplCopyWithImpl(
    _$ScannedPageImpl _value,
    $Res Function(_$ScannedPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScannedPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = null,
    Object? processedImagePath = freezed,
    Object? pageNumber = null,
    Object? appliedFilter = null,
    Object? ocrText = freezed,
  }) {
    return _then(
      _$ScannedPageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        imagePath: null == imagePath
            ? _value.imagePath
            : imagePath // ignore: cast_nullable_to_non_nullable
                  as String,
        processedImagePath: freezed == processedImagePath
            ? _value.processedImagePath
            : processedImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        pageNumber: null == pageNumber
            ? _value.pageNumber
            : pageNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        appliedFilter: null == appliedFilter
            ? _value.appliedFilter
            : appliedFilter // ignore: cast_nullable_to_non_nullable
                  as FilterType,
        ocrText: freezed == ocrText
            ? _value.ocrText
            : ocrText // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScannedPageImpl implements _ScannedPage {
  const _$ScannedPageImpl({
    required this.id,
    required this.imagePath,
    this.processedImagePath,
    required this.pageNumber,
    this.appliedFilter = FilterType.original,
    this.ocrText,
  });

  factory _$ScannedPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScannedPageImplFromJson(json);

  @override
  final String id;
  @override
  final String imagePath;
  @override
  final String? processedImagePath;
  @override
  final int pageNumber;
  @override
  @JsonKey()
  final FilterType appliedFilter;
  @override
  final String? ocrText;

  @override
  String toString() {
    return 'ScannedPage(id: $id, imagePath: $imagePath, processedImagePath: $processedImagePath, pageNumber: $pageNumber, appliedFilter: $appliedFilter, ocrText: $ocrText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannedPageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.processedImagePath, processedImagePath) ||
                other.processedImagePath == processedImagePath) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.appliedFilter, appliedFilter) ||
                other.appliedFilter == appliedFilter) &&
            (identical(other.ocrText, ocrText) || other.ocrText == ocrText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    imagePath,
    processedImagePath,
    pageNumber,
    appliedFilter,
    ocrText,
  );

  /// Create a copy of ScannedPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannedPageImplCopyWith<_$ScannedPageImpl> get copyWith =>
      __$$ScannedPageImplCopyWithImpl<_$ScannedPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScannedPageImplToJson(this);
  }
}

abstract class _ScannedPage implements ScannedPage {
  const factory _ScannedPage({
    required final String id,
    required final String imagePath,
    final String? processedImagePath,
    required final int pageNumber,
    final FilterType appliedFilter,
    final String? ocrText,
  }) = _$ScannedPageImpl;

  factory _ScannedPage.fromJson(Map<String, dynamic> json) =
      _$ScannedPageImpl.fromJson;

  @override
  String get id;
  @override
  String get imagePath;
  @override
  String? get processedImagePath;
  @override
  int get pageNumber;
  @override
  FilterType get appliedFilter;
  @override
  String? get ocrText;

  /// Create a copy of ScannedPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScannedPageImplCopyWith<_$ScannedPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
