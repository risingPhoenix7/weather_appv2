import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/resources/resources.dart';

import '../Repo/Model/location.dart';
import '../Repo/Model/mygeolocator.dart';

class LocationViewModel {
  Future<Location?> getCurrentLocation() async {
    Position position;
    try {
      position = await MyGeoLocator().determinePosition();
      Location location =
          Location(lat: position.latitude, lon: position.longitude);
      return location;
    } catch (e) {
      return null;
    }
  }

  Future<String> getCityName(Location location) async {
    try {
      var response = await http.get(Uri.parse(
          "$baseUrl/weather?appid=$apiKey&lat=${location.lat.toString()}&lon=${location.lon.toString()}&"));

      Map data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data['name'];
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
