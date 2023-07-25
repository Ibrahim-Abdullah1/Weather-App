import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class WeatherService {
  String apiKey = '31d05dce64b22907562383f25739e81c';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  WeatherService(this.apiKey);

  Future<Map<String, dynamic>> fetchWeatherDataByLocation(
      String location) async {
    try {
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&APPID=$apiKey');

      // Custom IOClient with certificate verification disabled for development/testing
      final client = http.Client();
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData = json.decode(response.body);
        return weatherData;
      } else {
        throw Exception('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }

  Future<Map<String, double>> getCurrentLocation() async {
    final location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData; // Change to nullable LocationData

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission not granted');
      }
    }

    locationData = await location.getLocation();
    // ignore: unnecessary_null_comparison
    if (locationData == null) {
      throw Exception('Failed to get location data');
    }

    return {
      'latitude': locationData.latitude!,
      'longitude': locationData.longitude!,
    };
  }
}
