import 'package:forecast_app/models/City.dart';
import 'package:forecast_app/models/weather.dart';

class Forecast
{
  final int _maxCountDays = 16;
  City city;
  List<Weather> weathers = List<Weather>();
  Forecast(this.city, this.weathers);
  Forecast.fromJSON(Map<String, dynamic> json)
  {
    city = City.fromJSON(json);
    int index = 0;
    while(index < _maxCountDays){
      var weather = Weather.fromJSON(json, index++);
      weathers.add(weather);
    }
  }
}