// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryModel _$EntryModelFromJson(Map<String, dynamic> json) => EntryModel(
      name: NameModel.fromJson(json['im:name'] as Map<String, dynamic>),
      image: (json['im:image'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: SummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
      contentType: ContentTypeModel.fromJson(
          json['im:contentType'] as Map<String, dynamic>),
      id: IdModel.fromJson(json['id'] as Map<String, dynamic>),
      artist: ArtistModel.fromJson(json['im:artist'] as Map<String, dynamic>),
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EntryModelToJson(EntryModel instance) =>
    <String, dynamic>{
      'im:name': instance.name.toJson(),
      'im:image': instance.image.map((e) => e.toJson()).toList(),
      'summary': instance.summary.toJson(),
      'im:contentType': instance.contentType.toJson(),
      'id': instance.id.toJson(),
      'im:artist': instance.artist.toJson(),
      'category': instance.category.toJson(),
    };
