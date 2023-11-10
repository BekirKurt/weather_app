class Weather {
  final String cityName;
  final int temperature;
  final int maxTemperature;
  final int minTemperature;
  final String description;
  final String mainWeather;
  final String iconPath;
  final String windValue;
  final String humidtyValue;
  final String sunrise;
  final String sunset;
  List<int> hourlyTemp;
  List<String> dailyHour;
  List<String> dailyDesc;
  List<String> weekDays;
  List<String> weeklyIconsPath;
  final String date;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.description,
      required this.mainWeather,
      required this.iconPath,
      required this.windValue,
      required this.humidtyValue,
      required this.sunrise,
      required this.sunset,
      required this.maxTemperature,
      required this.minTemperature,
      required this.hourlyTemp,
      required this.dailyHour,
      required this.dailyDesc,
      required this.weekDays,
      required this.weeklyIconsPath,
      required this.date});
}
