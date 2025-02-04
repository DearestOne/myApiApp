
class SimpleWeatherData{
    final String cityName;
    final int aqi;
    final dynamic temperature;

    SimpleWeatherData(this.cityName, this.aqi, this.temperature);

    SimpleWeatherData.fromJson(Map<String, dynamic> json)
      : cityName = json['data']['city']['name'],
        aqi = json['data']['iaqi']['pm25']['v'],
        temperature = json['data']['iaqi']['t']['v'];
}

class WeatherData{
    final String cityName;
    final Map<String, dynamic> other;
    WeatherData.fromJson(Map<String, dynamic> json)
      : cityName = json['data']['city']['name'],
        other = json['data']?['iaqi'] ?? {};
}

// homework2