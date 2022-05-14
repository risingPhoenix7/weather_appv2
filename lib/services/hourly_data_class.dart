// To parse this JSON data, do
//
//     final hourlyData = hourlyDataFromJson(jsonString);

import 'dart:convert';

List<HourlyData> hourlyDataFromJson(String str) => List<HourlyData>.from(json.decode(str).map((x) => HourlyData.fromJson(x)));

String hourlyDataToJson(List<HourlyData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  double ?temp;
  double ?feelsLike;
  int? humidity;
  double? uvi;
  int ?clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  List<Weather>? weather;


  factory HourlyData.fromJson(Map<String, dynamic> json) => HourlyData(
    dt: json["dt"] == null ? null : json["dt"],
    temp: json["temp"] == null ? null : json["temp"].toDouble(),
    feelsLike: json["feels_like"] == null ? null : json["feels_like"].toDouble(),
    humidity: json["humidity"] == null ? null : json["humidity"],
    uvi: json["uvi"] == null ? null : json["uvi"].toDouble(),
    clouds: json["clouds"] == null ? null : json["clouds"],
    visibility: json["visibility"] == null ? null : json["visibility"],
    windSpeed: json["wind_speed"] == null ? null : json["wind_speed"].toDouble(),
    windDeg: json["wind_deg"] == null ? null : json["wind_deg"], weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "dt": dt == null ? null : dt,
    "temp": temp == null ? null : temp,
    "feels_like": feelsLike == null ? null : feelsLike,
    "humidity": humidity == null ? null : humidity,
    "uvi": uvi == null ? null : uvi,
    "clouds": clouds == null ? null : clouds,
    "visibility": visibility == null ? null : visibility,
    "wind_speed": windSpeed == null ? null : windSpeed,
    "wind_deg": windDeg == null ? null : windDeg,
    "weather": weather == null ? null : List<dynamic>.from(weather!.map((x) => x.toJson())),

  };
}



class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  Main? main;
  Description? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"] == null ? null : json["id"],
    main: json["main"] == null ? null : mainValues.map![json["main"]],
    description: json["description"] == null ? null : descriptionValues.map![json["description"]],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "main": main == null ? null : mainValues.reverse![main],
    "description": description == null ? null : descriptionValues.reverse![description],
    "icon": icon == null ? null : icon,
  };
}

enum Description { OVERCAST_CLOUDS, LIGHT_RAIN, FEW_CLOUDS, CLEAR_SKY, SCATTERED_CLOUDS, BROKEN_CLOUDS }

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "few clouds": Description.FEW_CLOUDS,
  "light rain": Description.LIGHT_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS
});

enum Main { CLOUDS, RAIN, CLEAR }

final mainValues = EnumValues({
  "Clear": Main.CLEAR,
  "Clouds": Main.CLOUDS,
  "Rain": Main.RAIN
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
