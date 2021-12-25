import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/weather_model.dart';

class WeatherService {
  Future<WeatherParameters> getWeather(String cityName) async {
    // https://api.weatherapi.com/v1/current.json?key=f9879428e69f4903b97132941212412&q=London&aqi=no

    final queryParameters = {
      'q': cityName,
      'key': 'f9879428e69f4903b97132941212412',
      'aqi': 'yes'};

    final uri = Uri.https('api.weatherapi.com', '/v1/current.json', queryParameters);

    final response = await http.get(uri);

    final data = jsonDecode(response.body);

    return WeatherParameters.fromJson(data);
  }
}