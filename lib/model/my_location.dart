import 'package:flutter/foundation.dart';

abstract class MyLocation {
  static String latitude = '12.9716';
  static String longitude = '77.5946';
  static String cityName = 'Bangalore';
  static bool isLocationResult = false;
  static bool isLoading = true;
  static ValueNotifier<int> selectedDataKey=ValueNotifier(0);
}
