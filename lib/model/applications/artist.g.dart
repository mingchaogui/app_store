// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) => ArtistModel(
      label: json['label'] as String,
      attributes: ArtistAttributesModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ArtistModelToJson(ArtistModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'attributes': instance.attributes.toJson(),
    };

ArtistAttributesModel _$ArtistAttributesModelFromJson(
        Map<String, dynamic> json) =>
    ArtistAttributesModel(
      href: json['href'] as String,
    );

Map<String, dynamic> _$ArtistAttributesModelToJson(
        ArtistAttributesModel instance) =>
    <String, dynamic>{
      'href': instance.href,
    };
