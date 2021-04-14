import 'package:flutter/material.dart';
import 'package:weather_apk/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_apk/services/weather.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocationData();

    super.initState();
  }

  void getLocationData() async {
    
  WeatherModel weatherModel=WeatherModel();
  var weatherData=await weatherModel.getWeatherData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return LocationScreen(
        weatherdata: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: SpinKitFadingCircle(
        color: Colors.white,
        size: 100,
        duration: Duration(milliseconds: 1000),
      )),
    );
  }
}
