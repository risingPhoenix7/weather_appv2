import 'package:flutter/foundation.dart';

abstract class MyLocation{
  static  ValueNotifier<String> latitude=ValueNotifier('12.9716');
  static  ValueNotifier<String> longitude=ValueNotifier('77.5946');
}