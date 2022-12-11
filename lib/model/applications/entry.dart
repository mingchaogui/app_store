import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'artist.dart';
import 'category.dart';
import 'content_type.dart';
import 'id.dart';
import 'image.dart';
import 'name.dart';
import 'summary.dart';

part 'entry.g.dart';

@JsonSerializable()
class EntryModel {
  const EntryModel({
    required this.name,
    required this.image,
    required this.summary,
    required this.contentType,
    required this.id,
    required this.artist,
    required this.category,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) =>
      _$EntryModelFromJson(json);

  factory EntryModel.fromDbJson(Map<String, dynamic> json) {
    final String extras = json['extras'].toString();
    final Map<String, dynamic> object = jsonDecode(extras);
    return EntryModel.fromJson(object);
  }

  @JsonKey(name: 'im:name')
  final NameModel name;
  @JsonKey(name: 'im:image')
  final List<ImageModel> image;
  final SummaryModel summary;
  @JsonKey(name: 'im:contentType')
  final ContentTypeModel contentType;
  final IdModel id;
  @JsonKey(name: 'im:artist')
  final ArtistModel artist;
  final CategoryModel category;

  Map<String, dynamic> toJson() => _$EntryModelToJson(this);

  Map<String, dynamic> toDbJson() {
    return <String, dynamic>{
      'trackId': id.attributes.id,
      'name': name.label,
      'summary': summary.label,
      'artist': artist.label,
      'extras': jsonEncode(toJson()),
    };
  }
}
