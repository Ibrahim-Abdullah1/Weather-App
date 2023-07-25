# Weather-App
The Weather App is a mobile application developed using Flutter that allows users to fetch and display real-time weather data based on their current location or a user-specified location. The app utilizes the OpenWeatherMap API to fetch weather data, including information such as temperature, humidity, wind speed, and weather conditions.

# Architecture:

The app follows a simple architecture pattern with the following components:

WeatherService: This class handles API calls to the OpenWeatherMap API. It fetches weather data based on the user's location or a specified location. The class is responsible for constructing the API URL, making HTTP requests, and parsing the API response.

WeatherDataModel: This class serves as the state management solution for the app. It manages the app's state related to weather data, loading status, internet connectivity, and error handling. The class uses the ChangeNotifier to notify the UI of state changes.

WeatherScreen: This is the main user interface of the app. It displays weather data fetched from the API and includes options for searching for weather data for a specific location.


# How to Run

To run the Weather App, follow these steps:

Clone the repository to your local machine.

Replace 'YOUR_API_KEY' in lib/weather_service.dart with your actual OpenWeatherMap API key.

Ensure that you have Flutter installed and set up for your preferred platform (Android, iOS, or web).

Connect a physical device or use an emulator/simulator for testing.

Run the app using the following command in the project directory:
                 flutter run

# Rationale Behind Technical Choices:

Flutter: Flutter is chosen as the development framework due to its cross-platform capabilities, allowing the app to be built for Android, iOS, and web platforms using a single codebase. It also provides a rich set of widgets and tools for building beautiful and performant user interfaces.

State Management with ChangeNotifier: For simple state management needs in the app, ChangeNotifier and Provider have been used. This approach allows for a straightforward and reactive way to manage and update the app's state.

OpenWeatherMap API: The OpenWeatherMap API is selected for fetching weather data due to its extensive coverage, providing accurate and real-time weather information for various locations worldwide.

Geolocation and Geocoding: The app uses the geolocator package to access the user's current location and the geocoding package to convert coordinates into human-readable location names (city and country).

# Challenges Faced:

During development, some challenges were encountered:

SSL Certificate Verification: The OpenWeatherMap API server's SSL certificate validation caused issues during development. To overcome this, the http package was used with custom HTTP clients to disable certificate verification temporarily for development purposes only.

API Data Availability: At times, the API may not provide data for certain locations or return incomplete information. Proper error handling has been implemented in the app to handle such scenarios and inform the user accordingly.

Emulator/Device Location Settings: Some issues may arise related to geolocation on the emulator or physical device, such as incorrect location data. It's essential to ensure that the emulator or device settings are correctly configured for location access.
