// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationsModel _$ApplicationsModelFromJson(Map<String, dynamic> json) =>
    ApplicationsModel(
      feed: FeedModel.fromJson(json['feed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplicationsModelToJson(ApplicationsModel instance) =>
    <String, dynamic>{
      'feed': instance.feed.toJson(),
    };
