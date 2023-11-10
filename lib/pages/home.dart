import 'package:flutter/material.dart';
import 'package:pro_weather_app/models/weather_provider.dart';
import 'package:pro_weather_app/pages/weather_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showEmptyTextFieldAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xFF1B1D1F),
          title: const Text('Warning', style: TextStyle(color: Colors.white)),
          content: const Text('Please enter a city.',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final TextEditingController _cityController = TextEditingController();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Weather App'),
      // ),
      backgroundColor: const Color(0xFF1B1D1F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFD2E3C8),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 260,
                        child: TextField(
                          controller: _cityController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              labelText: 'Search a city..',
                              hoverColor: Colors.amber,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 28,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          String text = _cityController.text;
                          if (text.isEmpty) {
                            _showEmptyTextFieldAlert(context);
                          } else {
                            String city = _cityController.text;
                            weatherProvider.fetchWeather(city);
                          }
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Consumer<WeatherProvider>(
                  builder: (context, provider, child) {
                    final weather = provider.weather;
                    if (weather != null) {
                      return WeatherWidget(weather: weather);
                    } else {
                      return Column(
                        children: [
                          const Text(
                            'Enter a city to get weather information',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 28),
                          Image.asset(
                            "assets/weatherIcons/season.png",
                            width: 300,
                          ),
                          const SizedBox(height: 28),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFFD2E3C8),
                                elevation: 10, // Butonun z-elevasyonu
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), // Butonun kenar yuvarlaklığı
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 26,
                                    vertical: 16), // Buton iç içe boşlukları
                              ),
                              onPressed: () {
                                weatherProvider.fetchWeather("Bursa");
                              },
                              child: const Text(
                                "Start with your location",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
