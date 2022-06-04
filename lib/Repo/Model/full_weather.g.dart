// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullWeather _$FullWeatherFromJson(Map<String, dynamic> json) => FullWeather(
      current: HourlyData.fromJson(json['current'] as Map<String, dynamic>),
      second: HourlyData.fromJson(json['hourly'][7] as Map<String, dynamic>),
      third: HourlyData.fromJson(json['hourly'][15] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FullWeatherToJson(FullWeather instance) =>
    <String, dynamic>{
      'current': instance.current,
      'second': instance.second,
      'third': instance.third,
    };

HourlyData _$HourlyDataFromJson(Map<String, dynamic> json) => HourlyData(
      dt: json['dt'] as int?,
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      humidity: json['humidity'] as int?,
      uvi: (json['uvi'] as num?)?.toDouble(),
      clouds: json['clouds'] as int?,
      visibility: json['visibility'] as int?,
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
      windDeg: json['windDeg'] as int?,
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HourlyDataToJson(HourlyData instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'uvi': instance.uvi,
      'clouds': instance.clouds,
      'visibility': instance.visibility,
      'windSpeed': instance.windSpeed,
      'windDeg': instance.windDeg,
      'weather': instance.weather,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      id: json['id'] as int?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'icon': instance.icon,
    };
