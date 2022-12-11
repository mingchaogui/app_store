import 'package:app_store/model/applications/feed.dart';
import 'package:json_annotation/json_annotation.dart';

part 'applications.g.dart';

@JsonSerializable()
class ApplicationsModel {
  const ApplicationsModel({
    required this.feed,
  });

  factory ApplicationsModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationsModelFromJson(json);

  final FeedModel feed;

  Map<String, dynamic> toJson() => _$ApplicationsModelToJson(this);
}
