import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class ArtistModel {
  const ArtistModel({
    required this.label,
    required this.attributes,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);

  final String label;
  final ArtistAttributesModel attributes;

  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);
}

@JsonSerializable()
class ArtistAttributesModel {
  const ArtistAttributesModel({
    required this.href,
  });

  factory ArtistAttributesModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistAttributesModelFromJson(json);

  final String href;

  Map<String, dynamic> toJson() => _$ArtistAttributesModelToJson(this);
}
