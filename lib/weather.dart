import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapiapp/weather_api_class.dart';
import 'package:myapiapp/weather_country.dart';
// https://api.waqi.info/feed/here/?token=db72103f674a25dee3d6e942e90c4325df4a0b72

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

class SumnationWeather extends StatefulWidget {
  const SumnationWeather({super.key});
  @override
  State<SumnationWeather> createState() => _SumnationWeatherState();
}

class _SumnationWeatherState extends State<SumnationWeather> {
  bool isLoading = true;
  final List<String> position = [
    'bangkok',
    'chiangmai',
    'tokyo',
    'new york',
    'london',
    'paris',
    'berlin',
    'pakistan',
    'rome',
    'beijing',
    'seoul',
  ];
  List<SimpleWeatherData> weatherData = [];

  Future<void> getWeather() async {
    weatherData.clear();
    for (var i = 0; i < position.length; i++) {
      final response = await http.get(Uri.parse(
          'https://api.waqi.info/feed/${position[i]}/?token=db72103f674a25dee3d6e942e90c4325df4a0b72'));
      if (response.statusCode == 200) {
        setState(() {
          final data = jsonDecode(response.body);
          final weather = SimpleWeatherData.fromJson(data);
          weatherData.add(weather);
        });
      } else {
        print('Failed to load weather data');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        itemCount: weatherData.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return isLoading
                ? Container(margin: const EdgeInsets.all(15),child: const Center(child: CircularProgressIndicator()),)
                : ElevatedButton(
                    onPressed: () {
                      isLoading = true;
                      getWeather();
                    },
                    child: const Text('Refresh'));
          }
          return ListTile(
            leading: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: getAQIColor(weatherData[index - 1].aqi)),
                alignment: Alignment.center,
                width: 60,
                height: 45,
                child: Text(
                  weatherData[index - 1].aqi.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                )),
            title: Text(weatherData[index - 1].cityName),
            subtitle:
                Text('Temperature: ${weatherData[index - 1].temperature} °C'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WeatherCurrentCountry(country: position[index - 1]),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
// homework2