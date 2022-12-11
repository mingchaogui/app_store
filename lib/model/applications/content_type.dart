import 'package:json_annotation/json_annotation.dart';

part 'content_type.g.dart';

@JsonSerializable()
class ContentTypeModel {
  const ContentTypeModel({
    required this.attributes,
  });

  factory ContentTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ContentTypeModelFromJson(json);

  final ContentTypeAttributesModel attributes;

  Map<String, dynamic> toJson() => _$ContentTypeModelToJson(this);
}

@JsonSerializable()
class ContentTypeAttributesModel {
  const ContentTypeAttributesModel({
    required this.term,
    required this.label,
  });

  factory ContentTypeAttributesModel.fromJson(Map<String, dynamic> json) =>
      _$ContentTypeAttributesModelFromJson(json);

  final String term;
  final String label;

  Map<String, dynamic> toJson() => _$ContentTypeAttributesModelToJson(this);
}
