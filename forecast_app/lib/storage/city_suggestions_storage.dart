class CitySuggestionsStorage{
  static List<String> _citiesSuggestions;

  CitySuggestionsStorage(){
    _citiesSuggestions = [
      "Lviv", "London", "Oslo", "Berlin", "Liverpool", "Warsaw", "Paris",
      "Chicago", "Atlanta", "Cincinnati", "Kyiv", "Odesa", "Kryvyi Rih",
      "Zaporizhzhia", "Donetsk", "Dnipro"
    ];
  }

  Future<List<String>> fetchCity() async
  {
    return await _citiesSuggestions;
  }

}