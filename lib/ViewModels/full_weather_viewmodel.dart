import 'package:dio/dio.dart';

import '../Repo/Model/full_weather.dart';
import '../Repo/Model/location.dart';
import '../Repo/Retrofit/retrofit.dart';

class WeatherViewModel {
  Future<FullWeather> getWeather(Location location) async {
    final dio = Dio();
    final client = RetrofitRestClient(dio);
    FullWeather fullWeather;
    fullWeather = await client.getWeather(
        location.lat.toString(), location.lon.toString());
    return fullWeather;
  }
}
