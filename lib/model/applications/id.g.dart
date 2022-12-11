// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdModel _$IdModelFromJson(Map<String, dynamic> json) => IdModel(
      label: json['label'] as String,
      attributes: IdAttributesModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IdModelToJson(IdModel instance) => <String, dynamic>{
      'label': instance.label,
      'attributes': instance.attributes.toJson(),
    };

IdAttributesModel _$IdAttributesModelFromJson(Map<String, dynamic> json) =>
    IdAttributesModel(
      id: const AnyIntJsonConverter().fromJson(json['im:id'] as Object),
      bundleId: json['im:bundleId'] as String,
    );

Map<String, dynamic> _$IdAttributesModelToJson(IdAttributesModel instance) =>
    <String, dynamic>{
      'im:id': const AnyIntJsonConverter().toJson(instance.id),
      'im:bundleId': instance.bundleId,
    };
