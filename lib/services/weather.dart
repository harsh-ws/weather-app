import 'dart:ui';

import 'package:clima/services/network.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/secrets.dart';

const apiKey = '$secretApiKey';

double latitude;
double longitude;
class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    var apiLink = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = new NetworkHelper(apiLink);
    var cityWeatherData = await networkHelper.getData();
    print(cityWeatherData);
    return cityWeatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    var apiLink = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(apiLink);
    var weatherData = await networkHelper.getData();
    return weatherData;

  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
