import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pro_weather_app/models/weather.dart';

class WeatherApiService {
  final String apiKey;
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  WeatherApiService(this.apiKey);

  Future<Weather> getWeather(String city) async {
    final response =
        await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      double formattedNumber = ((data['list'][0]['main']['temp']) - 273.15);
      String temperature = formattedNumber.toStringAsFixed(0);
      double formattedNumber1 =
          ((data['list'][0]['main']['temp_max']) - 273.15);
      String maxTemperature = formattedNumber1.toStringAsFixed(0);
      double formattedNumber2 =
          ((data['list'][0]['main']['temp_min']) - 273.15);
      String minTemperature = formattedNumber2.toStringAsFixed(0);

      String windValue = (data['list'][0]['wind']['speed']).toString();
      String humidityValue = (data['list'][0]['main']['humidity']).toString();

      //sunrise sunset
      var sunrise = (data['city']['sunrise']);
      var sunset = (data['city']['sunset']);
      var timezone = (data['city']['timezone']);

      var sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000)
          .add(Duration(seconds: timezone))
          .toLocal();

      String formattedSunrise = DateFormat.Hm().format(sunriseDateTime);

      var sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000)
          .add(Duration(seconds: timezone))
          .toLocal();

      String formattedSunset = DateFormat.Hm().format(sunsetDateTime);

      String iconPath = "";
      String areleMain = (data['list'][0]['weather'][0]['main']).toString();

      switch (areleMain) {
        case "Clear":
          iconPath = "assets/weatherIcons/sunny.png";
          break;
        case "Clouds":
          iconPath = "assets/weatherIcons/cloudy.png";
          break;
        case "Rain":
          iconPath = "assets/weatherIcons/rainy-day.png";
          break;
        case "Drizzle":
          iconPath = "assets/weatherIcons/rainy.png";
          break;
        case "Thunderstorm":
          iconPath = "assets/weatherIcons/thunderstorm.png";
          break;
        case "Snow":
          iconPath = "assets/weatherIcons/snow.png";
          break;
        case "Mist":
          iconPath = "assets/weatherIcons/fog.png";
          break;
        case "Smoke":
          iconPath = "assets/weatherIcons/sunny.png";
          break;
        default:
          iconPath = "assets/weatherIcons/wind.png";
          break;
      }

      List<int> hourlyTemp = [];

      List<String> dailyHour = [];
      // daily description
      List<String> dailyDesc = [];
      // week days
      List<String> dates = [];
      DateTime now = DateTime.now();
      //weekly icon
      List<String> weeklyIcons = [];
      String weeklyIconPath = "";

      // formatted date
      String formattedDate = DateFormat('d MMMM yyyy', 'en_US').format(now);

      for (var i = 0; i < 7; i++) {
        double formattedNumber3 = ((data['list'][i]['main']['temp']) - 273.15);
        String temperature3 = formattedNumber3.toStringAsFixed(0);
        int areleFavel = int.parse(temperature3);
        hourlyTemp.add(areleFavel);

        // daily descripiton
        dailyDesc.add((data['list'][i]['weather'][0]['description']));
        //print(dailyDesc);

        // take hours
        String timePeriod = (data['list'][i]['dt_txt']);
        timePeriod = timePeriod.substring(10, 16);
        dailyHour.add(timePeriod);

        //week days
        DateTime date = now.add(Duration(days: i));
        String dayName = DateFormat('EEEE').format(date);
        dates.add(dayName);

        //weekly icons
        String weeklyiconsadd =
            (data['list'][i]['weather'][0]['main']).toString();

        switch (weeklyiconsadd) {
          case "Clear":
            weeklyIconPath = "assets/weatherIcons/sunny.png";
            weeklyIcons.add(weeklyIconPath);
            break;
          case "Clouds":
            weeklyIconPath = "assets/weatherIcons/cloudy.png";
            weeklyIcons.add(weeklyIconPath);
            break;
          case "Rain":
            weeklyIconPath = "assets/weatherIcons/rainy-day.png";
            weeklyIcons.add(weeklyIconPath);
            break;
          case "Drizzle":
            weeklyIconPath = "assets/weatherIcons/rainy.png";
            weeklyIcons.add(weeklyIconPath);
            break;
          case "Thunderstorm":
            weeklyIconPath = "assets/weatherIcons/thunderstorm.png";
            weeklyIcons.add(weeklyIconPath);
            break;
          case "Snow":
            weeklyIconPath = "assets/weatherIcons/snow.png";
            weeklyIcons.add(weeklyIconPath);
            break;
          case "Mist":
            weeklyIconPath = "assets/weatherIcons/fog.png";
            weeklyIcons.add(weeklyIconPath);
            break;
          case "Smoke":
            weeklyIconPath = "assets/weatherIcons/sunny.png";
            weeklyIcons.add(weeklyIconPath);
            break;
          default:
            weeklyIconPath = "assets/weatherIcons/wind.png";
            weeklyIcons.add(weeklyIconPath);
            break;
        }
      }
      // city capitalize first letter
      city = city[0].toUpperCase() + city.substring(1).toLowerCase();

      //print(temperature);
      return Weather(
        cityName: city,
        temperature: int.parse(temperature),
        description: (data['list'][0]['weather'][0]['description']),
        mainWeather: (data['list'][0]['weather'][0]['main']),
        iconPath: iconPath,
        windValue: windValue,
        humidtyValue: humidityValue,
        sunrise: formattedSunrise,
        sunset: formattedSunset,
        maxTemperature: int.parse(maxTemperature),
        minTemperature: int.parse(minTemperature),
        hourlyTemp: hourlyTemp,
        dailyHour: dailyHour,
        dailyDesc: dailyDesc,
        weekDays: dates,
        weeklyIconsPath: weeklyIcons,
        date: formattedDate,
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
