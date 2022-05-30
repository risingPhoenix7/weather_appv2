import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:weather_forecast/Repo/Model/full_weather.dart';
import 'package:weather_forecast/ViewModels/location_viewmodel.dart';

import 'Controllers/some_controllers.dart';
import 'Repo/Model/location.dart';
import 'ViewModels/full_weather_viewmodel.dart';
import 'mini_weather_widget.dart';
import 'my_search.dart';

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

  late FullWeather fullWeather;
  Location location = Location(lat: 12.9716, lon: 77.5946);
  String cityName = 'Bengaluru';

  Future<void> getWeatherFromLatLon() async {
    location = await LocationViewModel().getCurrentLocation();
    cityName = await LocationViewModel().getCityName(location);
    fullWeather = await WeatherViewModel().getWeather(location);
    setState(() {});
  }

  Future<void> getWeatherFromCity() async {
    location =SomeControllers.searchLocation;
    fullWeather = await WeatherViewModel().getWeather(location);
    setState(() {});
  }

  setUsefulDataKey(int i) {
    setState(() {
      selectedDataKey = i;
      print(selectedDataKey);
    });
  }

  HourlyData? getRequiredHourlyData(int key) {
    if (key == 1) return fullWeather.current;
    if (key == 2) return fullWeather.second;
    if (key == 3) return fullWeather.third;
  }

  @override
  void initState() {
    super.initState();
    getWeatherFromLatLon();
    SomeControllers.selectedDataKey.addListener(() {
      setState(() {});
    });
    SomeControllers.shouldSetState.addListener(() async {
      print('should set state was called after returing from search');
      print(SomeControllers.shouldSetState.value);
      await getWeatherFromCity();
      SomeControllers.shouldSetState.value = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent.shade400,
        body: SafeArea(
          child: (SomeControllers.isLoading && count == 0)
              //Basically only the first time,when there's no data whatsoever this should appear.
              ? Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: SomeControllers.isLocationResult.value
                      ? getWeatherFromLatLon
                      : getWeatherFromCity,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                SomeControllers.isLocationResult.value =
                                    true;
                                getWeatherFromLatLon();
                              },
                              icon: Icon(
                                SomeControllers.isLocationResult.value
                                    ? Icons.location_on_sharp
                                    : Icons.wrong_location,
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                cityName,
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MySearchScreen(),
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
                      Image.asset(
                        'assets/${getRequiredHourlyData(selectedDataKey)!.weather![0].icon}.png',
                        height: 300,
                        width: 300,
                        fit: BoxFit.fill,
                      ),

                      //Brief Description
                      Center(
                          child: Text(
                        getRequiredHourlyData(selectedDataKey)!
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
                            getRequiredHourlyData(selectedDataKey)!
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
                          Text(getRequiredHourlyData(selectedDataKey)!
                              .windSpeed!
                              .toStringAsPrecision(2)),
                          Text(' m/s'),
                          SizedBox(width: 15),
                          Icon(Icons.water_drop_outlined),
                          SizedBox(width: 5),
                          Text(getRequiredHourlyData(selectedDataKey)!
                              .humidity!
                              .toStringAsPrecision(2)),
                          Text(' %')
                        ],
                      ),
                      SizedBox(height: 20),

                      //Future data

                      //Can i get a ontap property from here only? or should i make the child a button?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 175,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              width: 20,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: MiniWeatherWidget(
                                  dateTime: DateTime.fromMillisecondsSinceEpoch(
                                      getRequiredHourlyData(selectedDataKey)!
                                              .dt! *
                                          1000),
                                  temperature:
                                      getRequiredHourlyData(selectedDataKey)!
                                          .temp!
                                          .toStringAsPrecision(2),
                                ),
                                onTap: () {
                                  SomeControllers.selectedDataKey.value =
                                      index;
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.lightBlueAccent.shade200),
                            child: GridView.count(
                              childAspectRatio: 1.8,
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              children: <Widget>[
                                MiniMiniDataWidget(
                                    title: 'UV Index',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                            .uvi
                                            .toString()),
                                MiniMiniDataWidget(
                                    title: 'Visibility(in m)',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                            .visibility
                                            .toString()),
                                MiniMiniDataWidget(
                                    title: 'Cloudiness(%)',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                            .clouds
                                            .toString()),
                                MiniMiniDataWidget(
                                    title: 'Humidity(%)',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                            .humidity
                                            .toString()),
                                MiniMiniDataWidget(
                                    title: 'Windspeed(m/s)',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                            .windSpeed
                                            .toString()),
                                MiniMiniDataWidget(
                                    title: 'Temp Feels Like',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                            .feelsLike
                                            .toString()),
                              ],
                            )),
                      )

                      //Search
                    ],
                  )),
        ));
  }
}
