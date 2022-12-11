import 'package:json_annotation/json_annotation.dart';

part 'look_up_result.g.dart';

@JsonSerializable()
class LookUpResultModel {
  const LookUpResultModel({
    required this.averageUserRating,
    required this.userRatingCount,
    required this.trackId,
  });

  factory LookUpResultModel.fromJson(Map<String, dynamic> json) =>
      _$LookUpResultModelFromJson(json);

  factory LookUpResultModel.fromDbJson(Map<String, dynamic> json) =>
      LookUpResultModel.fromJson(json);

  final double averageUserRating;
  final int userRatingCount;
  final int trackId;

  Map<String, dynamic> toJson() => _$LookUpResultModelToJson(this);

  Map<String, dynamic> toDbJson() => toJson();
}
