import 'package:http/http.dart' as http;
import 'package:forecast_app/models/forecast.dart';
import 'dart:convert';

class ForecastAPI
{
  var _baseURL = 'https://api.weatherbit.io/v2.0/forecast/daily';
  var _MY_API_KEY = '77ee1c4e93e64ca9a61b32c6e95651c8';
  Future<Forecast> fetchForecast(String cityName) async
  {
      var response = await http.get('$_baseURL?city=$cityName&key=$_MY_API_KEY');
      if(response.statusCode == 200)
          return Forecast.fromJSON(jsonDecode(response.body));
      else
          throw Exception('Failed to load forecast');
  }
}