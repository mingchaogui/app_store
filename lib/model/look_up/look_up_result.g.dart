// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'look_up_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUpResultModel _$LookUpResultModelFromJson(Map<String, dynamic> json) =>
    LookUpResultModel(
      averageUserRating: (json['averageUserRating'] as num).toDouble(),
      userRatingCount: json['userRatingCount'] as int,
      trackId: json['trackId'] as int,
    );

Map<String, dynamic> _$LookUpResultModelToJson(LookUpResultModel instance) =>
    <String, dynamic>{
      'averageUserRating': instance.averageUserRating,
      'userRatingCount': instance.userRatingCount,
      'trackId': instance.trackId,
    };
