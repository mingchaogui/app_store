import 'package:json_annotation/json_annotation.dart';

part 'summary.g.dart';

@JsonSerializable()
class SummaryModel {
  const SummaryModel({
    required this.label,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);

  final String label;

  Map<String, dynamic> toJson() => _$SummaryModelToJson(this);
}
