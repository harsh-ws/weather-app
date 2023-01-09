import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  getData() async {
    String data;
    http.Response response = await http.get(Uri.parse(
        'https://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=6876d62a7721420b46ca8ec09dafdb8a'));
    if (response.statusCode == 200) {
      data = response.body;
    } else {
      print(response.statusCode);
    }
    var temperature = jsonDecode(data)['cod'];
    print(temperature);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
