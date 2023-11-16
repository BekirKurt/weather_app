import 'package:flutter/material.dart';
import 'package:pro_weather_app/models/weather.dart';
import 'package:pro_weather_app/models/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather(String city) async {
    _weather = await WeatherApiService('YOUR_API_KEY')
        .getWeather(city);
    notifyListeners();
  }
}
