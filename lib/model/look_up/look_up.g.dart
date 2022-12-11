// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'look_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUpModel _$LookUpModelFromJson(Map<String, dynamic> json) => LookUpModel(
      resultCount: json['resultCount'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => LookUpResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookUpModelToJson(LookUpModel instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'results': instance.results.map((e) => e.toJson()).toList(),
    };
