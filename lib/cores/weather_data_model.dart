import 'package:flutter/foundation.dart';
import 'config.dart';
import 'weather_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:connectivity/connectivity.dart';

class WeatherDataModel with ChangeNotifier {
  WeatherService _weatherService = WeatherService(openWeatherApiKey);

  bool _isLoading = true;
  bool _isConnected = true;
  Map<String, dynamic> _weatherData = {};

  Future<void> _getWeatherData(String location) async {
    try {
      final weatherData =
          await _weatherService.fetchWeatherDataByLocation(location);
      _weatherData = weatherData;
      print('API Response Body: $_weatherData');
    } catch (e) {
      print('Error fetching weather data: $e');
    }
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;
  Map<String, dynamic> get weatherData => _weatherData;

  WeatherDataModel() {
    _getLocationWeatherData();
    _checkConnectivity();
    // Listen for changes in connectivity
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected = (result != ConnectivityResult.none);
      notifyListeners();
      // If connected, refetch weather data
      if (_isConnected) {
        _getLocationWeatherData();
      }
    });
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _isConnected = (connectivityResult != ConnectivityResult.none);
    notifyListeners();
  }

  Future<void> _getLocationWeatherData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final locationData = await _weatherService.getCurrentLocation();
      print('Latitude: ${locationData['latitude']}');
      print('Longitude: ${locationData['longitude']}');

      // Get the city name and country code from coordinates
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData['latitude']!,
        locationData['longitude']!,
      );

      final cityName = placemarks.first.locality;
      final country = placemarks.first.isoCountryCode;
      final location = '$cityName,$country';

      final weatherData =
          await _weatherService.fetchWeatherDataByLocation(location);
      _weatherData = weatherData;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error in fetching locations: $e");
    }
  }
}
