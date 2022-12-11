import 'package:app_store/util/json_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'id.g.dart';

@JsonSerializable()
class IdModel {
  const IdModel({
    required this.label,
    required this.attributes,
  });

  factory IdModel.fromJson(Map<String, dynamic> json) =>
      _$IdModelFromJson(json);

  final String label;
  final IdAttributesModel attributes;

  Map<String, dynamic> toJson() => _$IdModelToJson(this);
}

@JsonSerializable()
class IdAttributesModel {
  const IdAttributesModel({
    required this.id,
    required this.bundleId,
  });

  factory IdAttributesModel.fromJson(Map<String, dynamic> json) =>
      _$IdAttributesModelFromJson(json);

  // 在不同的API中apple返回了不同类型的id，有时候是String，有时候是int。为便利故，统一按int接收处理。
  @JsonKey(name: 'im:id')
  @AnyIntJsonConverter()
  final int id;
  @JsonKey(name: 'im:bundleId')
  final String bundleId;

  Map<String, dynamic> toJson() => _$IdAttributesModelToJson(this);
}
