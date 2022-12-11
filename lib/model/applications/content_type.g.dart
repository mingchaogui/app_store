// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentTypeModel _$ContentTypeModelFromJson(Map<String, dynamic> json) =>
    ContentTypeModel(
      attributes: ContentTypeAttributesModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentTypeModelToJson(ContentTypeModel instance) =>
    <String, dynamic>{
      'attributes': instance.attributes.toJson(),
    };

ContentTypeAttributesModel _$ContentTypeAttributesModelFromJson(
        Map<String, dynamic> json) =>
    ContentTypeAttributesModel(
      term: json['term'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$ContentTypeAttributesModelToJson(
        ContentTypeAttributesModel instance) =>
    <String, dynamic>{
      'term': instance.term,
      'label': instance.label,
    };
