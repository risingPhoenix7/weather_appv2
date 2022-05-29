import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../resources/resources.dart';
import '../Model/city_name.dart';

part 'getCity.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/weather?appid=$apiKey')
  Future<CityName> getCity(@Query("&lat") String lat, @Query("&lon") String lon);
}
