// To parse this JSON data, do
//
//     final hourlyData = hourlyDataFromJson(jsonString);

import 'dart:convert';

List<HourlyData> hourlyDataFromJson(String str) =>
    List<HourlyData>.from(json.decode(str).map((x) => HourlyData.fromJson(x)));

HourlyData currentDataFromJson(String str) =>
    HourlyData.fromJson(json.decode(str));

class HourlyData {
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

  factory HourlyData.fromJson(Map<String, dynamic> json) => HourlyData(
        dt: json["dt"],
        temp: json["temp"] == null ? 0 : json["temp"].toDouble(),
        feelsLike:
            json["feels_like"] == null ? 0 : json["feels_like"].toDouble(),
        humidity: json["humidity"],
        uvi: json["uvi"] == null ? null : json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed:
            json["wind_speed"] == null ? null : json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"] ?? null,
        weather: json["weather"] == null
            ? null
            : List<Weather>.from(
                json["weather"].map((x) => Weather.fromJson(x))),
      );
}

class Weather {
  Weather({
    this.id,
    this.description,
    this.icon,
  });

  int? id;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] ?? null,
        description: json["description"] ?? null,
        icon: json["icon"] ?? null,
      );
}
