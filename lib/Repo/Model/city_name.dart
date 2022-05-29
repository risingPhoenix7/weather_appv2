import 'package:json_annotation/json_annotation.dart';

part 'city_name.g.dart';

@JsonSerializable()
class CityName {
  CityName({required this.cityName});

  String cityName;

  factory CityName.fromJson(Map<String, dynamic> json) =>
      _$CityNameFromJson(json);

  Map<String, dynamic> toJson() => _$CityNameToJson(this);
}
