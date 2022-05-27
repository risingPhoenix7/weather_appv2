import 'hourly_data_class.dart';

class UsefulData {
  static late HourlyData current;
  static late  HourlyData second;
  static late HourlyData third;
static HourlyData? requiredData(int a){
  if(a==0) return current;
  if(a==1) return second;
  if(a==2) return third;
}
}
