

import 'package:flutter/foundation.dart';

import '../Repo/Model/location.dart';

abstract class SomeControllers {
  static ValueNotifier<bool> isLocationResult = ValueNotifier(true);
  static ValueNotifier<bool> shouldSetState = ValueNotifier(false);
   static late Location searchLocation ;

  static bool isLoading = true;
  static ValueNotifier<int> selectedDataKey = ValueNotifier(0);
}
