import 'package:flutter/material.dart';
import 'package:pro_weather_app/models/weather.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    weather.cityName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    weather.date.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ]),
                const Icon(
                  Icons.all_inclusive_rounded,
                  color: Colors.white,
                  size: 32,
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "${weather.temperature}°C",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    weather.description,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "H: ${weather.maxTemperature}   L: ${weather.minTemperature}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Image.asset(
                weather.iconPath,
                width: 120,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Weather info", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 360,
            height: 110,
            decoration: BoxDecoration(
                color: const Color(0xFFD2E3C8),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/weatherIcons/wind.png",
                      width: 44,
                    ),
                    Text("${weather.windValue} m/s"),
                    const Text("wind"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/weatherIcons/humidity.png",
                      width: 50,
                    ),
                    Text("${weather.humidtyValue}%"),
                    const Text("humidity"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/weatherIcons/sunrise.png",
                      width: 50,
                    ),
                    Text(weather.sunrise),
                    const Text("sunrise"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/weatherIcons/sunset.png",
                      width: 50,
                    ),
                    Text(weather.sunset),
                    const Text("sunset"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Hourly weather forecast",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < 7; i++)
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(right: 12),
                    width: 80,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                        color: const Color(0xFFD2E3C8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Column(
                      children: [
                        Text(
                          weather.dailyHour[i].toString(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${weather.hourlyTemp[i]}°C",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(weather.dailyDesc[i].toString(),
                            textAlign: TextAlign.center)
                      ],
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Weekly weather forecast",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFFD2E3C8),
                  borderRadius: BorderRadius.circular(22)),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: weather.weekDays.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        // onTap: () {
                        //   print('ListTile tıklandı: $index');
                        // },
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: 88,
                                  child:
                                      Text(weather.weekDays[index].toString())),
                              Image.asset(
                                weather.weeklyIconsPath[index].toString(),
                                width: 42,
                              ),
                              //Text(weather.dailyDesc[index].toString()),
                              SizedBox(
                                width: 55,
                                child: Text("${weather.hourlyTemp[index]}°C"),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
