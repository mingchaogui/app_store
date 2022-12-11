import 'package:json_annotation/json_annotation.dart';

import 'entry.dart';

part 'feed.g.dart';

@JsonSerializable()
class FeedModel {
  const FeedModel({
    required this.entry,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);

  final List<EntryModel> entry;

  Map<String, dynamic> toJson() => _$FeedModelToJson(this);
}
