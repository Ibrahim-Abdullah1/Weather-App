import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/weather_screen.dart';

import 'cores/config.dart';
import 'cores/weather_data_model.dart';
import 'cores/weather_service.dart';
 // Import the configuration file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<WeatherDataModel>(
            create: (context) => WeatherDataModel(),
          ),
          Provider<WeatherService>(
            create: (context) => WeatherService(openWeatherApiKey),
          ),
        ],
        child: WeatherScreen(),
      ),
    );
  }
}
