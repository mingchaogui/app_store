import 'package:app_store/util/json_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageModel {
  const ImageModel({
    required this.label,
    required this.attributes,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  final String label;
  final ImageAttributesModel attributes;

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

@JsonSerializable()
class ImageAttributesModel {
  const ImageAttributesModel({
    required this.height,
  });

  factory ImageAttributesModel.fromJson(Map<String, dynamic> json) =>
      _$ImageAttributesModelFromJson(json);

  @AnyIntJsonConverter()
  final int height;

  Map<String, dynamic> toJson() => _$ImageAttributesModelToJson(this);
}
