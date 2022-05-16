import 'package:flutter/material.dart';
import 'package:weather_forecast/data_controllers/my_location.dart';
import 'package:weather_forecast/data_controllers/useful_data.dart';

class MiniWeatherWidget extends StatelessWidget {
  MiniWeatherWidget({Key? key, required this.usefulDataKey})
      : super(key: key);
  final int usefulDataKey;

  late var dateTime = DateTime.fromMillisecondsSinceEpoch(
      UsefulData.requiredData(usefulDataKey)!.dt! * 1000);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
      ),
      onPressed: (){
        MyLocation.selectedDataKey.value=usefulDataKey;
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0x8FE0C1FF)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: <Text>[
                  Text(
                    UsefulData.requiredData(usefulDataKey) == null
                        ? 'idk'
                        : dateTime.day.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    ' / ',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    UsefulData.requiredData(usefulDataKey) == null
                        ? 'idk'
                        : dateTime.month.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(
                    dateTime.hour.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    dateTime.minute.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(
                    UsefulData.requiredData(usefulDataKey)!
                        .temp!
                        .toStringAsPrecision(2),
                    style: TextStyle(fontSize: 40),
                  ),
                  Text('°', style: TextStyle(fontSize: 40))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
