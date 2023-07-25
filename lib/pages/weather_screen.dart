import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import '../cores/weather_data_model.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          WeatherDataModel(), // Used the model for state management using Providers
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<WeatherDataModel>(
      builder: (context, weatherDataModel, child) {
        if (weatherDataModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (weatherDataModel.isConnected) {
            if (weatherDataModel.weatherData.isNotEmpty) {
              return _buildWeatherInfo(weatherDataModel.weatherData);
            } else {
              return const Center(
                child: Text('No weather data available.'),
              );
            }
          } else {
            return const Center(
              child: Text('No internet connection.'),
            );
          }
        }
      },
    );
  }


  Widget _buildWeatherInfo(Map<String, dynamic> weatherData) {
    if (weatherData.containsKey('name')) {
      final mainWeatherData = weatherData['main'];
      final weather = weatherData['weather'][0];
      final cityName = weatherData['name'];
      final temperature = mainWeatherData['temp'];
      final description = weather['description'];

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$cityName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '$temperature°C',
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 10),
            Text(
              'Weather: $description',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('No weather data available.'),
      );
    }
  }
}
