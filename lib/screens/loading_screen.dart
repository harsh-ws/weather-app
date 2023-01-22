import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/services/network.dart';
import 'package:clima/services/secrets.dart';

const apiKey = '$secretApiKey';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);

    latitude = location.latitude;
    longitude = location.longitude;

    var apiLink = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    NetworkHelper networkHelper = NetworkHelper(apiLink);

    var weatherData = await networkHelper.getData();
    print(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
// var temperature = decoded['main']['temp'];
// var condition = decoded['weather'][0]['description'];
// var city = decoded['name'];
