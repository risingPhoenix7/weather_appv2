// To parse this JSON data, do
//
//     final allData = allDataFromJson(jsonString);

import 'dart:convert';

AllData allDataFromJson(String str) => AllData.fromJson(json.decode(str));


class AllData {
  AllData({
    this.lat,
    this.lon,
    this.current,
    this.hourly,
  });

  int? lat;
  int? lon;
  Current? current;
  List<Current>? hourly;

  factory AllData.fromJson(Map<String, dynamic> json) => AllData(
    lat: json["lat"],
    lon: json["lon"],
    current: Current.fromJson(json["current"]),
    hourly: List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
  );


}

class Current {
  Current({
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
  int ?humidity;
  int ?uvi;
  int? clouds;
  int ?visibility;
  double? windSpeed;
  int ?windDeg;
  List<Weather>? weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    dt: json["dt"],
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    humidity: json["humidity"],
    uvi: json["uvi"],
    clouds: json["clouds"],
    visibility: json["visibility"],
    windSpeed: json["wind_speed"].toDouble(),
    windDeg: json["wind_deg"],
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
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
    id: json["id"],
    description: json["description"],
    icon: json["icon"],
  );


}
