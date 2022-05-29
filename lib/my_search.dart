import 'package:flutter/material.dart';
import 'package:weather_forecast/viewmodel/my_location.dart';
import 'package:weather_forecast/viewmodel/get_data.dart';

import 'main.dart';

class MySearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<MySearchScreen> {
  final _searchFieldController = TextEditingController();
  bool error = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent.shade400,
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchFieldController,
            style: TextStyle(
              fontSize: 24,
            ),
            decoration: InputDecoration(
              hintText: 'Search Location for weather',
              hintStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              filled: true,
              fillColor: Colors.lightBlueAccent,
              border: InputBorder.none,
              suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    error =
                        await GetData().checkCity(_searchFieldController.text);
                    print(error);
                    if (error) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return MyDialog(errorMessage: 'Location not found');
                          });
                    } else {
                      MyLocation.isLocationResult.value = false;
                      MyLocation.shouldSetState.value = true;
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    }
                  }),
            ),
          ),
        ));
  }
}

class MyDialog extends StatelessWidget {
  MyDialog({Key? key, required this.errorMessage}) : super(key: key);
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      backgroundColor: const Color(0xFF232535),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        height: 100,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
