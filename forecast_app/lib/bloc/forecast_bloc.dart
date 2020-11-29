import 'dart:async';

import 'package:forecast_app/models/forecast.dart';
import 'package:forecast_app/rest-api/forecast_api.dart';
import 'package:forecast_app/storage/selected_city.dart';

class ForecastBloc
{
  StreamController _streamController = StreamController<Forecast>();
  Forecast _forecast;

  SelectedCity selected_city = SelectedCity();

  ForecastAPI _forecastApi = ForecastAPI();
  get forecastStream => _streamController.stream;

  ForecastBloc() {
    initForecast();
  }

  updateForecast() {
    initForecast();
    _streamController.sink.add(_forecast);
  }

  initForecast()  async {
    var cityName = await selected_city.fetchSelectedCity();
    _forecast = await _forecastApi.fetchForecast(cityName);
    _streamController.sink.add(_forecast);
  }

  dispose() {
    _streamController.close();
  }

}