import 'package:flutter/foundation.dart';

abstract class MyLocation {
  static String latitude = '12.9716';
  static String longitude = '77.5946';
  static String cityName = 'Bangalore';
  static  ValueNotifier<bool> isLocationResult =ValueNotifier(true);
  static  ValueNotifier<bool> shouldSetState =ValueNotifier(false);
  static bool isLoading = true;
  static ValueNotifier<int> selectedDataKey=ValueNotifier(0);
}
