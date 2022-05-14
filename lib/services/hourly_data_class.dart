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
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
    this.rain,
  });

  int? dt;
  double ?temp;
  double ?feelsLike;
  int ?pressure;
  int? humidity;
  double ?dewPoint;
  double? uvi;
  int ?clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  double ?windGust;
  List<Weather>? weather;
  double? pop;
  Rain ?rain;

  factory HourlyData.fromJson(Map<String, dynamic> json) => HourlyData(
    dt: json["dt"] == null ? null : json["dt"],
    temp: json["temp"] == null ? null : json["temp"].toDouble(),
    feelsLike: json["feels_like"] == null ? null : json["feels_like"].toDouble(),
    pressure: json["pressure"] == null ? null : json["pressure"],
    humidity: json["humidity"] == null ? null : json["humidity"],
    dewPoint: json["dew_point"] == null ? null : json["dew_point"].toDouble(),
    uvi: json["uvi"] == null ? null : json["uvi"].toDouble(),
    clouds: json["clouds"] == null ? null : json["clouds"],
    visibility: json["visibility"] == null ? null : json["visibility"],
    windSpeed: json["wind_speed"] == null ? null : json["wind_speed"].toDouble(),
    windDeg: json["wind_deg"] == null ? null : json["wind_deg"],
    windGust: json["wind_gust"] == null ? null : json["wind_gust"].toDouble(),
    weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    pop: json["pop"] == null ? null : json["pop"].toDouble(),
    rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt == null ? null : dt,
    "temp": temp == null ? null : temp,
    "feels_like": feelsLike == null ? null : feelsLike,
    "pressure": pressure == null ? null : pressure,
    "humidity": humidity == null ? null : humidity,
    "dew_point": dewPoint == null ? null : dewPoint,
    "uvi": uvi == null ? null : uvi,
    "clouds": clouds == null ? null : clouds,
    "visibility": visibility == null ? null : visibility,
    "wind_speed": windSpeed == null ? null : windSpeed,
    "wind_deg": windDeg == null ? null : windDeg,
    "wind_gust": windGust == null ? null : windGust,
    "weather": weather == null ? null : List<dynamic>.from(weather!.map((x) => x.toJson())),
    "pop": pop == null ? null : pop,
    "rain": rain == null ? null : rain?.toJson(),
  };
}

class Rain {
  Rain({
    this.the1H,
  });

  double? the1H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    the1H: json["1h"] == null ? null : json["1h"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "1h": the1H == null ? null : the1H,
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
