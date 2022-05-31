import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../resources/resources.dart';
import '../Model/full_weather.dart';
part 'retrofit.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RetrofitRestClient {
  factory RetrofitRestClient(Dio dio, {String baseUrl}) = _RetrofitRestClient;

  @GET("/onecall?&appid=$apiKey&units=metric&exclude=daily,minutely,alerts")
  Future<FullWeather> getWeather(
      @Query("&lat") String lat, @Query("&lon") String lon);
}
