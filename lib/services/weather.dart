import 'package:weather_apk/services/location.dart';
import 'package:weather_apk/services/networking.dart';

const apiKey = "878c296b9515f555d08cb1b85c0a7956";
const http = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$http?q=$cityName&appid=$apiKey&units=metric';
    NetWorkData netWorkData = NetWorkData(url: url);
    var cityWeather = await netWorkData.getData();
    print(cityWeather);
    return cityWeather;
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location();

    await location.getLocation();

    NetWorkData netWorkData = NetWorkData(
        url:
            '$http?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await netWorkData.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(var temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need Jacket and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
