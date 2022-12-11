import 'package:app_store/model/look_up/look_up_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'look_up.g.dart';

@JsonSerializable()
class LookUpModel {
  const LookUpModel({
    required this.resultCount,
    required this.results,
  });

  factory LookUpModel.fromJson(Map<String, dynamic> json) =>
      _$LookUpModelFromJson(json);

  final int resultCount;
  final List<LookUpResultModel> results;

  Map<String, dynamic> toJson() => _$LookUpModelToJson(this);
}
