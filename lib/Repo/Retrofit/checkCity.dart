import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../resources/resources.dart';
import '../Model/location.dart';

part 'checkCity.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/weather?appid=$apiKey')
  Future<Location> checkCityName(@Query('&q') String cityName);
}
