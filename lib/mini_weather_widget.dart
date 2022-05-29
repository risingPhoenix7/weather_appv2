import 'package:flutter/material.dart';
import 'package:weather_forecast/viewmodel/useful_data.dart';

class MiniWeatherWidget extends StatelessWidget {
  MiniWeatherWidget({Key? key, required this.usefulDataKey}) : super(key: key);
  final int usefulDataKey;

  late var dateTime = DateTime.fromMillisecondsSinceEpoch(
      UsefulData.requiredData(usefulDataKey)!.dt! * 1000);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.lightBlueAccent.shade200),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }
}

class MiniMiniDataWidget extends StatelessWidget {
  MiniMiniDataWidget({Key? key, required this.title, required this.value})
      : super(key: key);
  String value;
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold),
        )
      ],
    );
  }
}
