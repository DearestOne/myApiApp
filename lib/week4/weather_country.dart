import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapiapp/week4/weather_api_class.dart';

dynamic getAQIColor(int aqi) {
  if (aqi <= 50) {
    return const Color.fromARGB(255, 181, 255, 76);
  } else if (aqi <= 100) {
    return Colors.yellow;
  } else if (aqi <= 150) {
    return Colors.orange;
  } else if (aqi <= 200) {
    return const Color.fromARGB(255, 255, 97, 86);
  } else if (aqi <= 300) {
    return const Color.fromARGB(255, 232, 101, 255);
  } else {
    return Colors.brown;
  }
}

class WeatherCurrentCountry extends StatefulWidget {
  final String country;

  const WeatherCurrentCountry({super.key, required this.country});

  @override
  State<WeatherCurrentCountry> createState() => _WeatherCurrentCountryState();
}

class _WeatherCurrentCountryState extends State<WeatherCurrentCountry> {
  WeatherData? weatherData;
  bool isLoading = true;
  Future<void> getThisWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.waqi.info/feed/${widget.country}/?token=db72103f674a25dee3d6e942e90c4325df4a0b72'));
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        weatherData = WeatherData.fromJson(data);
      });
    } else {
      print('Failed to load weather data');
    }
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    getThisWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${weatherData?.cityName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(20),
                    height: 150,
                    decoration: BoxDecoration(
                      color: getAQIColor(weatherData?.other['pm25']['v'] ?? 0),
                      borderRadius: BorderRadius.circular(
                          30), // Adjust the radius as needed
                    ),
                    child: Center(
                      child: Text(
                        '${weatherData?.other['pm25']['v']}',
                        style: const TextStyle(
                            fontSize: 55, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 214, 200, 252),
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the radius as needed
                    ),
                    child: Center(
                      child: Text(
                        'Temperature : ${weatherData?.other['t']['v']} °C',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 214, 200, 252),
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the radius as needed
                    ),
                    child: Center(
                      child: Text(
                        'Pressure : ${weatherData?.other['p']['v']} hPa',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 214, 200, 252),
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the radius as needed
                    ),
                    child: Center(
                      child: Text(
                        'Wind Speed : ${weatherData?.other['w']['v']} m/s',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 214, 200, 252),
                      borderRadius: BorderRadius.circular(
                          15), // Adjust the radius as needed
                    ),
                    child: Center(
                      child: Text(
                        'Humidity : ${weatherData?.other['h']['v']} %',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            getThisWeather();
          },
          child: const Icon(Icons.refresh),
        ));
  }
}
// homework2
// 19:00:00