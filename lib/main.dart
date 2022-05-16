import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_forecast/data_controllers/useful_data.dart';
import 'package:weather_forecast/services/get_data.dart';
import 'package:weather_forecast/services/get_location.dart';
import 'package:weather_forecast/search_screen.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'data_controllers/my_location.dart';
import 'mini_weather_widget.dart';

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
  var selectedDataKey = 0;
  late var imageCode;

  Future<void> updateTheData() async {
    print('count=$count');
    if (count == 0) {
      //ifnull, navigate to search screen and get location
      await determinePosition();

      await GetData().updateWeatherData();
      await GetData().getCityName();
      count++;
      print('updated the data count=$count');
      MyLocation.isLoading = false;
      imageCode = UsefulData.requiredData(MyLocation.selectedDataKey.value)!
          .weather![0]
          .icon;

      setState(() {});
    } else {
      if (MyLocation.isLocationResult) await determinePosition();
      await GetData().updateWeatherData();
      await GetData().getCityName();
      imageCode = UsefulData.requiredData(MyLocation.selectedDataKey.value)!
          .weather![0]
          .icon;
      setState(() {});
    }
    ;
  }

  setUsefulDataKey(int i) {
    setState(() {
      selectedDataKey = i;
      print(selectedDataKey);
    });
  }

  @override
  void initState() {
    super.initState();
    updateTheData();
    MyLocation.selectedDataKey.addListener(() {
      imageCode = UsefulData.requiredData(MyLocation.selectedDataKey.value)!
          .weather![0]
          .icon;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO: to change variably
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
            child: (MyLocation.isLoading && count == 0)
                //Basically only the first time,when there's no data whatsoever this should appear.
                ? Text('loading da pls wait')
                : RefreshIndicator(
                    onRefresh: updateTheData,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                MyLocation.isLocationResult
                                    ? Icons.location_on_sharp
                                    : Icons.wrong_location,
                                color: Colors.black,
                                size: 35,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  MyLocation.cityName,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchScreen(),
                                          fullscreenDialog: true),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    size: 35,
                                  ))
                            ],
                          ),
                        ),

                        //Image to display
                        Image.network(
                          'http://openweathermap.org/img/wn/$imageCode@2x.png',
                          height: 300,
                          width: 300,
                          fit: BoxFit.fill,
                        ),

                        //Brief Description
                        Center(
                            child: Text(
                          UsefulData.requiredData(
                                  MyLocation.selectedDataKey.value)!
                              .weather![0]
                              .description!
                              .capitalizeEach(),
                          style: TextStyle(fontSize: 20),
                        )),
                        SizedBox(height: 15),

                        //Temperature
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              UsefulData.requiredData(
                                      MyLocation.selectedDataKey.value)!
                                  .temp!
                                  .toStringAsPrecision(3),
                              style: TextStyle(fontSize: 60),
                            ),
                            Text('°', style: TextStyle(fontSize: 60))
                          ],
                        ),

                        SizedBox(height: 10),

                        //WindSpeed and humidity

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.wind_power_outlined),
                            SizedBox(width: 5),
                            Text(UsefulData.requiredData(
                                    MyLocation.selectedDataKey.value)!
                                .windSpeed!
                                .toStringAsPrecision(2)),
                            Text(' m/s'),
                            SizedBox(width: 15),
                            Icon(Icons.water_drop_outlined),
                            SizedBox(width: 5),
                            Text(UsefulData.requiredData(
                                    MyLocation.selectedDataKey.value)!
                                .humidity!
                                .toStringAsPrecision(2)),
                            Text(' %')
                          ],
                        ),
                        SizedBox(height: 20),

                        //Future data


                        //Can i get a ontap property from here only? or should i make the child a button?
                        SizedBox(
                          height: 175,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return MiniWeatherWidget(
                                usefulDataKey: index,
                              );
                            },
                          ),
                        ),

                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('UV Index: '),
                                    Text(UsefulData.requiredData(
                                        MyLocation.selectedDataKey.value)!
                                            .uvi.toString())

                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Visibility(in m): '),
                                    Text(UsefulData.requiredData(
                                        MyLocation.selectedDataKey.value)!
                                        .visibility.toString())

                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Cloudiness(%):  '),
                                    Text(UsefulData.requiredData(
                                        MyLocation.selectedDataKey.value)!
                                        .clouds.toString())

                                  ],
                                )


                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('humidity(%): '),
                                    Text(UsefulData.requiredData(
                                        MyLocation.selectedDataKey.value)!
                                        .humidity.toString())

                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Windspeed(m/s) '),
                                    Text(UsefulData.requiredData(
                                        MyLocation.selectedDataKey.value)!
                                        .windSpeed.toString())

                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Temp Feels Like:  '),
                                    Text(UsefulData.requiredData(
                                        MyLocation.selectedDataKey.value)!
                                        .feelsLike.toString())

                                  ],
                                )


                              ],
                            ),

                          ],
                        )

                        //Search
                      ],
                    ))));
  }
}
