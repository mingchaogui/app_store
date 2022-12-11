// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      attributes: CategoryAttributesModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'attributes': instance.attributes.toJson(),
    };

CategoryAttributesModel _$CategoryAttributesModelFromJson(
        Map<String, dynamic> json) =>
    CategoryAttributesModel(
      id: json['im:id'] as String,
      term: json['term'] as String,
      scheme: json['scheme'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$CategoryAttributesModelToJson(
        CategoryAttributesModel instance) =>
    <String, dynamic>{
      'im:id': instance.id,
      'term': instance.term,
      'scheme': instance.scheme,
      'label': instance.label,
    };
