import 'package:dio/dio.dart';

import '../Repo/Model/location.dart';
import '../Repo/Retrofit/checkCity.dart';

class SearchLocationViewModel {
  Future<Location?> getLatLonFromCityName(String? cityName) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      Location location = await client.checkCityName(cityName!);
      return location;
    } catch (e) {
      return null;
    }
  }
}
