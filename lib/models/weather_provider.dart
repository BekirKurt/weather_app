import 'package:flutter/material.dart';
import 'package:pro_weather_app/models/weather.dart';
import 'package:pro_weather_app/models/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather(String city) async {
    _weather = await WeatherApiService('2b8e99b0f856f0a3fbffc5cbb39261b3')
        .getWeather(city);
    notifyListeners();
  }
}
