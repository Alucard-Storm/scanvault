// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentImpl _$$DocumentImplFromJson(Map<String, dynamic> json) =>
    _$DocumentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      modifiedAt: DateTime.parse(json['modifiedAt'] as String),
      folderId: json['folderId'] as String?,
      tagIds:
          (json['tagIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      pages:
          (json['pages'] as List<dynamic>?)
              ?.map((e) => ScannedPage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ocrText: json['ocrText'] as String?,
      thumbnailPath: json['thumbnailPath'] as String?,
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'modifiedAt': instance.modifiedAt.toIso8601String(),
      'folderId': instance.folderId,
      'tagIds': instance.tagIds,
      'pages': instance.pages,
      'ocrText': instance.ocrText,
      'thumbnailPath': instance.thumbnailPath,
    };

_$ScannedPageImpl _$$ScannedPageImplFromJson(Map<String, dynamic> json) =>
    _$ScannedPageImpl(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      processedImagePath: json['processedImagePath'] as String?,
      pageNumber: (json['pageNumber'] as num).toInt(),
      appliedFilter:
          $enumDecodeNullable(_$FilterTypeEnumMap, json['appliedFilter']) ??
          FilterType.original,
      ocrText: json['ocrText'] as String?,
    );

Map<String, dynamic> _$$ScannedPageImplToJson(_$ScannedPageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'processedImagePath': instance.processedImagePath,
      'pageNumber': instance.pageNumber,
      'appliedFilter': _$FilterTypeEnumMap[instance.appliedFilter]!,
      'ocrText': instance.ocrText,
    };

const _$FilterTypeEnumMap = {
  FilterType.original: 'original',
  FilterType.grayscale: 'grayscale',
  FilterType.blackAndWhite: 'blackAndWhite',
  FilterType.magicColor: 'magicColor',
  FilterType.document: 'document',
};
