class SelectedCity{
  static String selectedCity = "";
  Future<String> fetchSelectedCity() async
  {
    return await selectedCity;
  }

  saveSelectedCity(String city) async
  {
    selectedCity = city;
  }
}