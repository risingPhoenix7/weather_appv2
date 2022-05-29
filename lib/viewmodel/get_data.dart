import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_forecast/model/hourly_data_class.dart';
import 'package:weather_forecast/viewmodel/my_location.dart';

import 'useful_data.dart';

class GetData {
  var latitude = MyLocation.latitude;
  var longitude = MyLocation.longitude;
  String city = MyLocation.cityName;
  late AllData allData;

  Future<void> updateWeatherData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&appid=86fb5ee6347a1dd0d1054468963d7a8c&exclude=daily,minutely,alerts'));
      print('hello');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('just before catastrophe');
        allData = allDataFromJson(response.body);
        print('hi');
        UsefulData.current = allData.current;
        UsefulData.second = allData.hourly![0];
        UsefulData.third = allData.hourly![1];
        print('data received correctly');
        //trim hourly data to only the necessary ones.
        return;
      } else {
        print('status code not 200');
        print(response.statusCode);
        return;
      }
    } catch (e) {
      print('this qerror in fetching');
      return;
    }
  }

  Future<void> getCityName() async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=86fb5ee6347a1dd0d1054468963d7a8c'));

      Map data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(data['name']);
        MyLocation.cityName = data['name'];
        //trim hourly data to only the necessary ones.
        return;
      } else {
        print('status code not 200');
        print(response.statusCode);
        return;
      }
    } catch (e) {
      print('error in fetching');
      return;
    }
  }

  Future<bool> checkCity(String city) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=86fb5ee6347a1dd0d1054468963d7a8c'));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print('hi imhere');
        print(data['name']);
        MyLocation.cityName = data['name'];
        print('hii imhere');
        print(data['coord']['lat']);
        print(MyLocation.latitude);
        MyLocation.latitude = data['coord']['lat'].toString();
        print('hiiii imhere');
        MyLocation.longitude = data['coord']['lon'].toString();
        print('hiiiiii imhere');
        print('done assigning, now sending to update weather');
        //trim hourly data to only the necessary ones.
        return false;
      } else {
        print('status code not 200');
        print(response.statusCode);
        return true;
      }
    } catch (e) {
      print('error in fetching');
      return true;
    }
  }
}
