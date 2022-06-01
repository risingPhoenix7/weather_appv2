import 'package:flutter/material.dart';
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
  bool isLoading = true;

  late FullWeather fullWeather;
  Location location = Location(lat: 12.9716, lon: 77.5946);
  String cityName = 'Bengaluru';

  Future<void> getWeatherFromLatLon() async {
    var a=(await LocationViewModel().getCurrentLocation());
    if(a==null)
      {
        SomeControllers.isLocationResult.value=false;
      }
    else
      location=a;
    fullWeather = await WeatherViewModel().getWeather(location);

    cityName = await LocationViewModel().getCityName(location);
    count++;
  }

  //
  Future<void> getWeatherFromCity() async {
    location = SomeControllers.searchLocation;
    fullWeather = await WeatherViewModel().getWeather(location);
    cityName = await LocationViewModel().getCityName(location);
  }

  Future<void> updateTheData() async {
    if (count == 0) {
      await getWeatherFromLatLon();
      setState(() {
        isLoading = false;
      });
    } else {
      if (SomeControllers.isLocationResult.value) {
        await getWeatherFromLatLon();
        setState(() {});
      } else {
        getWeatherFromCity();
        setState(() {});
      }
    }
    ;
  }

  setUsefulDataKey(int i) {
    setState(() {
      selectedDataKey = i;
    });
  }

  HourlyData? getRequiredHourlyData(int key) {
    if (key == 0) return fullWeather.current;
    if (key == 1) return fullWeather.second;
    if (key == 2)
      return fullWeather.third;
    else {
      return null;
    }
  }

  @override
  void initState() {
    updateTheData();

    SomeControllers.shouldSetState.addListener(() async {
      await getWeatherFromCity();
      SomeControllers.shouldSetState.value = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent.shade400,
        body: SafeArea(
          child: (isLoading && count == 0)
              //Basically only the first time,when there's no data whatsoever this should appear.
              ? const Center(
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
                  onRefresh: updateTheData,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                SomeControllers.isLocationResult.value = true;
                                updateTheData();
                              },
                              icon: Icon(
                                SomeControllers.isLocationResult.value
                                    ? Icons.location_on_sharp
                                    : Icons.wrong_location,
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                cityName,
                                style: const TextStyle(fontSize: 25),
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
                                icon: const Icon(
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
                                    .description ==
                                null
                            ? 'NA'
                            : getRequiredHourlyData(selectedDataKey)!
                                .weather![0]
                                .description!
                                .capitalizeEach(),
                        style: const TextStyle(fontSize: 20),
                      )),
                      const SizedBox(height: 15),

                      //Temperature
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            getRequiredHourlyData(selectedDataKey)!.temp == null
                                ? 'NA'
                                : getRequiredHourlyData(selectedDataKey)!
                                    .temp!
                                    .toStringAsPrecision(3),
                            style: const TextStyle(fontSize: 60),
                          ),
                          const Text('°', style: TextStyle(fontSize: 60))
                        ],
                      ),

                      const SizedBox(height: 10),

                      //WindSpeed and humidity

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.wind_power_outlined),
                          const SizedBox(width: 5),
                          Text(getRequiredHourlyData(selectedDataKey)!
                                      .windSpeed ==
                                  null
                              ? 'NA'
                              : getRequiredHourlyData(selectedDataKey)!
                                  .windSpeed!
                                  .toStringAsPrecision(2)),
                          const Text(' m/s'),
                          const SizedBox(width: 15),
                          const Icon(Icons.water_drop_outlined),
                          const SizedBox(width: 5),
                          Text(getRequiredHourlyData(selectedDataKey)!
                                      .humidity ==
                                  null
                              ? 'NA'
                              : getRequiredHourlyData(selectedDataKey)!
                                  .humidity!
                                  .toStringAsPrecision(2)),
                          const Text(' %')
                        ],
                      ),
                      const SizedBox(height: 20),

                      //Future data

                      //Can i get a ontap property from here only? or should i make the child a button?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 175,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
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
                                      getRequiredHourlyData(index)!.dt! * 1000),
                                  temperature: getRequiredHourlyData(index)!
                                      .temp!
                                      .toStringAsPrecision(2),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedDataKey = index;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            padding: const EdgeInsets.all(20),
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
                                                    .uvi ==
                                                null
                                            ? 'NA'
                                            : getRequiredHourlyData(
                                                    selectedDataKey)!
                                                .uvi
                                                .toString()),
                                MiniMiniDataWidget(
                                    title: 'Visibility(in m)',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                                    .visibility ==
                                                null
                                            ? 'NA'
                                            : getRequiredHourlyData(
                                                    selectedDataKey)!
                                                .visibility
                                                .toString()),
                                MiniMiniDataWidget(
                                    title: 'Cloudiness(%)',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                                    .clouds ==
                                                null
                                            ? 'NA'
                                            : getRequiredHourlyData(
                                                    selectedDataKey)!
                                                .clouds
                                                .toString()),
                                MiniMiniDataWidget(
                                    title: 'Humidity(%)',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                                    .humidity ==
                                                null
                                            ? 'NA'
                                            : getRequiredHourlyData(
                                                    selectedDataKey)!
                                                .humidity
                                                .toString()),
                                MiniMiniDataWidget(
                                    title: 'Windspeed(m/s)',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                                    .windSpeed ==
                                                null
                                            ? 'NA'
                                            : getRequiredHourlyData(
                                                    selectedDataKey)!
                                                .windSpeed
                                                .toString()),
                                MiniMiniDataWidget(
                                    title: 'Temp Feels Like',
                                    value:
                                        getRequiredHourlyData(selectedDataKey)!
                                                    .feelsLike ==
                                                null
                                            ? 'NA'
                                            : getRequiredHourlyData(
                                                    selectedDataKey)!
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
