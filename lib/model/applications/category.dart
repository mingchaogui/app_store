import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel {
  const CategoryModel({
    required this.attributes,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  final CategoryAttributesModel attributes;

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class CategoryAttributesModel {
  const CategoryAttributesModel({
    required this.id,
    required this.term,
    required this.scheme,
    required this.label,
  });

  factory CategoryAttributesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryAttributesModelFromJson(json);

  @JsonKey(name: 'im:id')
  final String id;
  final String term;
  final String scheme;
  final String label;

  Map<String, dynamic> toJson() => _$CategoryAttributesModelToJson(this);
}
