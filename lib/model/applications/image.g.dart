// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      label: json['label'] as String,
      attributes: ImageAttributesModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'attributes': instance.attributes.toJson(),
    };

ImageAttributesModel _$ImageAttributesModelFromJson(
        Map<String, dynamic> json) =>
    ImageAttributesModel(
      height: const AnyIntJsonConverter().fromJson(json['height'] as Object),
    );

Map<String, dynamic> _$ImageAttributesModelToJson(
        ImageAttributesModel instance) =>
    <String, dynamic>{
      'height': const AnyIntJsonConverter().toJson(instance.height),
    };
