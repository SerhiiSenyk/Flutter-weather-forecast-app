class City
{
    String cityName;
    double latitude;
    double longitude;
    String timezone;
    String countryCode;

    City(this.cityName, this.latitude, this.longitude,
        this.timezone, this.countryCode);
    City.fromJSON(Map<String, dynamic> json)
    {
      cityName = json['city_name'];
      latitude = double.parse(json['lat']);
      longitude = double.parse(json['lon']);
      timezone = json['timezone'].toString();
      countryCode = json['country_code'];
    }

}