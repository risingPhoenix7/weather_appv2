import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_place/google_place.dart';
import 'package:weather_forecast/model/my_location.dart';

import 'main.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _startSearchFieldController = TextEditingController();

  late FocusNode searchFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey = 'pls put places api key here to test';
    googlePlace = GooglePlace(apiKey);
    print(googlePlace.apiKEY);
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    print('test1');
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!);
      setState(() {
        predictions = result.predictions!;
      });
    }
    print('test2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _startSearchFieldController,
              autofocus: false,
              focusNode: searchFocusNode,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'Search Location for weather data',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: _startSearchFieldController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              predictions = [];
                              _startSearchFieldController.clear();
                            });
                          },
                          icon: Icon(Icons.clear_outlined),
                        )
                      : null),
              onChanged: (value) {

                  if (value.isNotEmpty) {
                    //places api
                    autoCompleteSearch(value);
                  } else {
                    //clear out the results
                    setState(() {
                      predictions = [];
                    });
                  }

              },
            ),
            SizedBox(height: 10),
            ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      predictions[index].description.toString(),
                    ),
                    onTap: () async {
                      final placeId = predictions[index].placeId!;
                      final details = await googlePlace.details.get(placeId);
                      if (details != null &&
                          details.result != null &&
                          mounted) {
                        setState(() {
                          MyLocation.longitude = details
                              .result!.geometry!.location!.lng
                              .toString();
                          MyLocation.latitude = details
                              .result!.geometry!.location!.lat
                              .toString();
                          MyLocation.isLocationResult = false;
                          //MyLocation.longitude.value
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        });
                      }
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
