import 'package:flutter/material.dart';
import 'package:weather_forecast/controllers/my_location.dart';
import 'package:weather_forecast/services/get_data.dart';
import 'package:weather_forecast/services/get_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var count = 0;

  Future<void> updateTheData() async {
    if (count == 0) {
      await determinePosition();
      //getLocation/lastknownlocation
      //ifnull, navigate to search screen and get location
      GetData(MyLocation.latitude.value, MyLocation.longitude.value).updateData();
      count++;
    } else {
      await determinePosition();
      GetData(MyLocation.latitude, MyLocation.longitude).updateData();
      setState(() {});
    };

  }

  @override
  void initState() async{
    await updateTheData();
    super.initState();
  }
 // var a=MyLocation.latitude.value;
 // var b=MyLocation.longitude.value;
 // var c=UsefulData.currentData.value;
 // var d=UsefulData.secondData.value;
 //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: to change variably
      backgroundColor: Colors.white,
      body:SafeArea(
        child:Text('Latitude =')
      )
    );
  }
}
