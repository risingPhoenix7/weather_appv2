import 'package:dio/dio.dart';

import '../Repo/Model/location.dart';
import '../Repo/Retrofit/checkCity.dart';

class SearchLocationViewModel {
  Future<Location?> getLatLonFromCityName(String? cityName) async {
    print('entered getlatLonfromcityname');
    final dio = Dio();
    final client = CheckCityRestClient(dio);
    try {
      Location location = await client.checkCityName(cityName!);
      return location;
    } catch (e) {

      return null;
    }
  }
}
