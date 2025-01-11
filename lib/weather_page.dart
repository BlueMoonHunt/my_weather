import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/model/weather_model.dart';
import 'package:my_weather/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api Key
  final _weatherService = WeatherService('b2caf3cf3771e41077b5ca9082983072');
  Weather? _weather;

  //fetch Weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    final weather = await _weatherService.getWeather(cityName);
    setState(() {
      _weather = weather;
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  String getWeatherAnimation(String? weatherCondition) {
    if (weatherCondition == null) return "assets/sun.json";

    switch (weatherCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy_night.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/sun.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar:
          AppBar(title: Text("MY WEATHER"), surfaceTintColor: Colors.cyan[100]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(getWeatherAnimation(_weather?.weatherCondition)),
            Text(_weather?.cityName ?? "Loading City"),
            Text('${_weather?.temperature.round()}ºC'),
            Text(_weather?.weatherCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
