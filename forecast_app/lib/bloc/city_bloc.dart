import 'dart:async';
import 'package:forecast_app/storage/selected_city.dart';
import 'package:forecast_app/storage/city_suggestions_storage.dart';

class CityBloc
{
  StreamController _streamController = StreamController<List<String>>();
  List<String> _city = List<String>();

  CitySuggestionsStorage _suggestions = CitySuggestionsStorage();
  SelectedCity selected_city = SelectedCity();
  get cityStream => _streamController.stream;

  CityBloc() {
    initCities();
  }

  updateCity() {
    initCities();
    _streamController.sink.add(_city);
  }

  initCities()  async {
    _city = await _suggestions.fetchCity();
    _streamController.sink.add(_city);
  }

  save(String selectedCity){
    selected_city.saveSelectedCity(selectedCity);
  }

  dispose() {
    _streamController.close();
  }

}