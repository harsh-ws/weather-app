import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherLocationData;
  //LocationScreen(this.weatherLocationData);
  const LocationScreen(
      {Key key, this.weatherLocationData})
      : super(key: key);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = new WeatherModel();
  int temperature;
  String weatherIcon;
  String weatherMessage;
  String city;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.weatherLocationData);
    updateUi(widget.weatherLocationData);
  }

  void updateUi(dynamic weatherLocationData) {
    setState(() {
      if (weatherLocationData == null){
        temperature = 0;
        city = '';
        weatherMessage = "Unable to fetch user's location";
        weatherIcon = 'Error';
        return;
      }
      double temp = weatherLocationData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherLocationData['weather'][0]['id'];
      city = weatherLocationData['name'];
      weatherMessage = weather.getMessage(temperature);
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData = await weather.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                      if (cityName != null){
                        var weatherData = await weather.getCityWeather(cityName);
                        updateUi(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Text(
                "$weatherMessage in \n $city !",
                textAlign: TextAlign.right,
                style: kMessageTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
