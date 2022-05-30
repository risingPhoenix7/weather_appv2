import 'package:dio/dio.dart';

import '../Repo/Model/full_weather.dart';
import '../Repo/Model/location.dart';
import '../Repo/Retrofit/retrofit.dart';

class WeatherViewModel {
  Future<FullWeather> getWeather(Location location) async {
    final dio = Dio();
    final client = RestClient(dio);
    FullWeather fullWeather;
    print('ia m inside');
    fullWeather = await client.getWeather(
        location.lat.toString(), location.lon.toString());
    print('iam not inside');
    return fullWeather;
  }

  Future<HourlyData?> getRequiredHourlyData(Location location, int i) async {
    FullWeather fullWeather = await getWeather(location);
    if(i==1)
      return fullWeather.current;
    if(i==2)
      return fullWeather.second;
    if(i==3)
      return fullWeather.third;

  }
}
