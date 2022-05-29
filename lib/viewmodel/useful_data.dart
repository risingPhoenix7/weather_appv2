import '../model/hourly_data_class.dart';

class UsefulData {
  static late Current? current;
  static late  Current? second;
  static late Current? third;
static Current? requiredData(int a){
  if(a==0) return current;
  if(a==1) return second;
  if(a==2) return third;
}
}
