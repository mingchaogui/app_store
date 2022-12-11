import 'package:json_annotation/json_annotation.dart';

class AnyIntJsonConverter extends JsonConverter<int, Object> {
  const AnyIntJsonConverter();

  @override
  int fromJson(Object json) => int.parse(json.toString());

  @override
  Object toJson(Object object) => object;
}
