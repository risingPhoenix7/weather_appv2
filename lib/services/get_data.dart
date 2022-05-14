import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/services/hourly_data_class.dart';

class GetData {
  GetData(this.latitude, this.longitude);

  var latitude, longitude;

  Future<List<HourlyData>?> getData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=86fb5ee6347a1dd0d1054468963d7a8c&exclude=daily,minutely,alerts'));
      Map data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('hi hello');
        var a = jsonEncode(data['current']);
        print(jsonEncode(data['hourly']).replaceFirst('[', '[$a,'));
        List<HourlyData> hourlyData = hourlyDataFromJson(
            jsonEncode(data['hourly']).replaceFirst('[', '[$a'));

        List<HourlyData> wantedlist = [
          hourlyData[7],
          hourlyData[15],
          hourlyData[23],
          hourlyData[31],
          hourlyData[39]
        ];
        //trim hourly data to only the necessary ones.
        print('hi hello');
        return wantedlist;
      } else {
        print('status code not 200');
        return <HourlyData>[];
      }
    } catch (e) {
      print('error in fetching');
      return <HourlyData>[];
    }

    // print(data['main']['temp']);
    // print(data['main']['humidity']);
    // print(data['name']);
    // print(data['sys']['country']);
    // print(data['main']['feels_like']);
    // print(data['weather'][0]['description']);
    // print(data['wind']['speed']);
    // print(data['wind']['deg']);

    // print(DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000));
    // print(DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000));
    // //icon : http://openweathermap.org/img/wn/$data['weather'][0]['icon']@2x.png

    //hourly, now, 1 am 2am... and then onclicked show full data
    //next day too, sem , next to next day onwards only weather for 7 days
  }
}
