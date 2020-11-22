import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weatherData.dart';

SharedPreferences prefs;

class ApiService {
  final String apiKey = "40bb52e19ff5ceb29886d814e341cb8c";
  final String baseUrl = "https://api.openweathermap.org/data/2.5/onecall";

  Future<WeatherData> getEventDetails(
      String location, double lat, double lng) async {
   final String url =
        "$baseUrl?lat=$lat&lon=$lng&units=metric&exclude=minutely,hourly&appid=$apiKey";
    final response = await http.get(url);

    print(url);

    var responseJson = json.decode(response.body);
    WeatherData weatherData = WeatherData.fromJson(responseJson);

    return weatherData;
  }
}
