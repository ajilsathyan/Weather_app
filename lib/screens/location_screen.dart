import 'package:flutter/material.dart';
import 'package:weather_apk/screens/city_screen.dart';
import 'package:weather_apk/services/weather.dart';
import 'package:weather_apk/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final weatherdata;

  const LocationScreen({Key key, @required this.weatherdata}) : super(key: key);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  var temperature;
  var weatherIcon;
  var cityName;
  var message;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherdata);
  }

  void updateUI(dynamic jsonDecodedData) {
    setState(() {
      if (jsonDecodedData == null) {
        temperature = 0;
        weatherIcon = "";
        cityName = "Error";
        message = "Sorry at the moment";
        return;
      }
      temperature = jsonDecodedData["main"]["temp"];
      var condition = jsonDecodedData["weather"][0]["id"];
      cityName = jsonDecodedData["name"];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(temperature);
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
                    onPressed: () async {
                      var weather = await weatherModel.getWeatherData();
                      updateUI(weather);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var citynameFromCityLocation = await Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      print(citynameFromCityLocation);
                      if (citynameFromCityLocation != null) {
                        var updateWeatherData = await weatherModel
                            .getCityWeather(citynameFromCityLocation);
                        updateUI(updateWeatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      "$message",
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
