

import 'package:flutter/foundation.dart';

import '../Repo/Model/location.dart';

abstract class SomeControllers {
  static ValueNotifier<bool> isLocationResult = ValueNotifier(true);
  static ValueNotifier<bool> shouldSetState = ValueNotifier(false);
   static late Location searchLocation ;
   //used searchLocation as a global variable instaed of returning as a parameter through navigator, makes things much easier.
}
