import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/services/network.dart';
import 'package:clima/services/secrets.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(apiLink);

    var weatherData = await networkHelper.getData();
    Navigator.push(context , MaterialPageRoute(builder: (context) => LocationScreen(weatherLocationData: weatherData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
    decoration: BoxDecoration(
    color: index.isEven ? Colors.red : Colors.green,
    ),
    );
    },
    ),
      ),
    );
  }
}
