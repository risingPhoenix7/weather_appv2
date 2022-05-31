import 'package:json_annotation/json_annotation.dart';

part 'full_weather.g.dart';

@JsonSerializable()
class FullWeather {
  HourlyData current;
  HourlyData second;
  HourlyData third;

  FullWeather({
    required this.current,
    required this.second,
    required this.third,
  });

  factory FullWeather.fromJson(Map<String, dynamic> json) =>
      _$FullWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$FullWeatherToJson(this);
}

@JsonSerializable()
class HourlyData {
  int? dt;
  double? temp;
  double? feelsLike;
  int? humidity;
  double? uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  List<Weather>? weather;

  HourlyData({
    this.dt,
    this.temp,
    this.feelsLike,
    this.humidity,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
  });

  factory HourlyData.fromJson(Map<String, dynamic> json) =>
      _$HourlyDataFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyDataToJson(this);
}

@JsonSerializable()
class Weather {
  Weather({
    this.id,
    this.description,
    this.icon,
  });

  int? id;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
