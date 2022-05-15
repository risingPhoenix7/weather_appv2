import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/controllers/data_class/hourly_data_class.dart';
import 'package:weather_forecast/controllers/useful_data.dart';

class GetData {
  GetData(this.latitude, this.longitude);

  var latitude, longitude;

  void updateData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=86fb5ee6347a1dd0d1054468963d7a8c&exclude=daily,minutely,alerts'));
      Map data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<HourlyData> hourlyData =
            hourlyDataFromJson(jsonEncode(data['hourly']));

        UsefulData.currentData.value =
            currentDataFromJson(jsonEncode(data['current']));
        UsefulData.secondData.value = hourlyData[7];
        UsefulData.thirdData.value = hourlyData[15];
        UsefulData.fourthData.value = hourlyData[23];
        UsefulData.fifthData.value = hourlyData[31];
        UsefulData.sixthData.value = hourlyData[39];

        //trim hourly data to only the necessary ones.
        return;
      } else {
        print('status code not 200');
        return;
      }
    } catch (e) {
      print('error in fetching');
      return;
    }
  }
}
