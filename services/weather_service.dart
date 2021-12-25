import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/weather_model.dart';

class WeatherService {
  Future<WeatherParameters> getWeather(String cityName) async {
    // https://api.weatherapi.com/v1/current.json?key=[]&q=London&aqi=no

    final queryParameters = {
      'q': cityName,
      'key': '',
      'aqi': 'yes'};

    final uri = Uri.https('api.weatherapi.com', '/v1/current.json', queryParameters);

    final response = await http.get(uri);

    final data = jsonDecode(response.body);

    return WeatherParameters.fromJson(data);
  }
}
