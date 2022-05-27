import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:weather_forecast/model/useful_data.dart';
import 'package:weather_forecast/viewmodel/get_data.dart';
import 'package:weather_forecast/viewmodel/get_location.dart';

import 'mini_weather_widget.dart';
import 'model/my_location.dart';
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
      if (MyLocation.isLocationResult.value) {
        await determinePosition();
        await GetData().updateWeatherData();
        await GetData().getCityName();
      }
      else{
        await GetData().updateWeatherData();
      }
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

    MyLocation.isLocationResult.addListener(() async {
      print('setting state here');
      await updateTheData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO: to change variably
        backgroundColor: Colors.lightBlueAccent.shade400,
        body: SafeArea(
          child: (MyLocation.isLoading && count == 0)
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
                  onRefresh: updateTheData,
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
                            Icon(
                              MyLocation.isLocationResult.value
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
                        'assets/$imageCode.png',
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
                                  usefulDataKey: index,
                                ),
                                onTap: () {
                                  MyLocation.selectedDataKey.value = index;
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
                                    value: UsefulData.requiredData(
                                            MyLocation.selectedDataKey.value)!
                                        .uvi
                                        .toString()),
                                MiniMiniDataWidget(
                                    title: 'Visibility(in m)',
                                    value: UsefulData.requiredData(
                                            MyLocation.selectedDataKey.value)!
                                        .visibility
                                        .toString()),
                                MiniMiniDataWidget(
                                    title: 'Cloudiness(%)',
                                    value: UsefulData.requiredData(
                                            MyLocation.selectedDataKey.value)!
                                        .clouds
                                        .toString()),
                                MiniMiniDataWidget(
                                    title: 'Humidity(%)',
                                    value: UsefulData.requiredData(
                                            MyLocation.selectedDataKey.value)!
                                        .humidity
                                        .toString()),
                                MiniMiniDataWidget(
                                    title: 'Windspeed(m/s)',
                                    value: UsefulData.requiredData(
                                            MyLocation.selectedDataKey.value)!
                                        .windSpeed
                                        .toString()),
                                MiniMiniDataWidget(
                                    title: 'Temp Feels Like',
                                    value: UsefulData.requiredData(
                                            MyLocation.selectedDataKey.value)!
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
