// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  colorValue: (json['colorValue'] as num?)?.toInt() ?? 0xFF7C4DFF,
);

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'colorValue': instance.colorValue,
};
