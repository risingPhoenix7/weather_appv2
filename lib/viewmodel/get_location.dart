import 'package:geolocator/geolocator.dart';

import '../model/my_location.dart';

/// Determine the current position of the device.
///
/// When the location viewmodel are not enabled or permissions
/// are denied the `Future` will return an error.

Future<void> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location viewmodel are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    //Tell them to turn on location

    // Location viewmodel are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location viewmodel.
    return;
    // return Future.error('Location viewmodel are disabled.');
  }

  permission = await Geolocator.checkPermission();
  print('hi');
  print(permission.name);
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
    print(permission.name);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      var a = await Geolocator.getLastKnownPosition();
      print("last known position is ");

      if (a != null) {
        print(a.longitude);
        MyLocation.latitude = a.latitude.toString();
        MyLocation.longitude = a.longitude.toString();
        return;
      }
      return;
    }
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  var a = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium);
  print('yay location fetched correctly');
  MyLocation.isLocationResult = true;
  MyLocation.latitude = a.latitude.toString();
  MyLocation.longitude = a.longitude.toString();
  print(MyLocation.latitude);
  print(MyLocation.longitude);
  return;
}
