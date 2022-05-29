import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../Repo/Model/city_name.dart';
import '../Repo/Model/location.dart';
import '../Repo/Model/mygeolocator.dart';
import '../Repo/Retrofit/getCity.dart';

class LocationViewModel {
  getCurrentLocation() async {
    Position position = await MyGeoLocator().determinePosition();
    Location location =
    Location(lat: position.latitude, lon: position.longitude);
    return location;
  }

  getCityName(Location location) async {
    final dio = Dio();
    final client = RestClient(dio);
    CityName cityName =
    await client.getCity(location.lat.toString(), location.lon.toString());
    return cityName;
  }


}
