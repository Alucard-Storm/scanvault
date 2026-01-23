// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FolderImpl _$$FolderImplFromJson(Map<String, dynamic> json) => _$FolderImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  iconName: json['iconName'] as String?,
  colorValue: (json['colorValue'] as num?)?.toInt() ?? 0xFF00897B,
  createdAt: DateTime.parse(json['createdAt'] as String),
  documentCount: (json['documentCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$FolderImplToJson(_$FolderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconName': instance.iconName,
      'colorValue': instance.colorValue,
      'createdAt': instance.createdAt.toIso8601String(),
      'documentCount': instance.documentCount,
    };
