import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/resources/resources.dart';

import '../Repo/Model/location.dart';
import '../Repo/Model/mygeolocator.dart';

class LocationViewModel {
  Future<Location> getCurrentLocation() async {
    print('Entered current location');
    Position position = await MyGeoLocator().determinePosition();
    print('Got the position');
    print(position);
    Location location =
        Location(lat: position.latitude, lon: position.longitude);
    return location;
  }

  Future<String> getCityName(Location location) async {

    print('entered getCityName');
    try {
      var response = await http.get(Uri.parse(
          "$baseUrl/weather?appid=$apiKey&lat=${location.lat.toString()}&lon=${location.lon.toString()}&"));
      print('but stuck here');
      print(response.statusCode);
      Map data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('hi');
        print(data['name']);
        return data['name'];
      } else {
        print('status code not 200');
        print(response.statusCode);
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
