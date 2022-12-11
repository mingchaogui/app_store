import 'package:json_annotation/json_annotation.dart';

part 'name.g.dart';

@JsonSerializable()
class NameModel {
  const NameModel({
    required this.label,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);

  final String label;

  Map<String, dynamic> toJson() => _$NameModelToJson(this);
}
