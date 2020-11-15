import 'package:forecast_app/models/City.dart';

class Weather
{
    City city;
    int windDirection;
    double pressure;
    int clouds;
    String datetime;
    double minTemp;
    double maxTemp;
    double temp;
    int cloudsMid;
    int cloudsLow;
    Weather(this.city, this.windDirection, this.pressure,
        this.clouds, this.datetime, this.minTemp,
        this.maxTemp, this.temp, this.cloudsLow, this.cloudsMid);

    Weather.fromJSON(Map<String, dynamic> json, int index)
    {
      windDirection = json['data'][index]['wind_dir'];
      pressure = json['data'][index]['pres'].toDouble();
      clouds = json['data'][index]['clouds'];
      datetime = json['data'][index]['datetime'];
      minTemp = json['data'][index]['min_temp'].toDouble();
      maxTemp = json['data'][index]['max_temp'].toDouble();
      temp = json['data'][index]['temp'].toDouble();
      cloudsMid = json['data'][index]['clouds_mid'];
      cloudsLow = json['data'][index]['clouds_low'];
    }
}