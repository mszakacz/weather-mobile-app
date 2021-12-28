import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/weather_model.dart';
import 'package:path_provider/path_provider.dart';

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

  WeatherParameters fromMap(Map data){
    WeatherParameters response = WeatherParameters(
      cityName: data['cityName'],
      countyName: data['countyName'],
      description: data['description'],
      icon: data['icon'],
      temperature: data['temperature'],
      feelsTemp: data['feelsTemp'],
      windSpeed: data['windSpeed'],
      windDirection: data['windDirection'],
      clouds: data['clouds'],
      pressure: data['pressure'],
      airQuality: data['airQuality'],
      uv: data['uv']
    );
    return response;
  }

  Map toMap(WeatherParameters response){
    Map data = {
      'cityName': response.cityName,
      'countyName': response.countyName,
      'description': response.description,
      'icon': response.icon,
      'temperature': response.temperature,
      'feelsTemp': response.feelsTemp,
      'windSpeed': response.windSpeed,
      'windDirection': response.windDirection,
      'clouds': response.clouds,
      'pressure': response.pressure,
      'airQuality': response.airQuality,
      'uv': response.uv
    };
    return data;
  }

  Future<List<String>> temperatureList(List<String> locations) async {
    final temperatures = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
    for(int i = 0; i < locations.length; i++) {
      final weather = await getWeather(locations[i]);
      String temp = weather.temperature.toString();
      temperatures[i] = temp;
    }
    return temperatures;
  }

  Future<String> get findLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get findLocalFile async {
    final path = await findLocalPath;
    return File('$path/data.txt');
  }

  Future<File> writeMyLocationsFile(List<String> list) async {
    final file = await findLocalFile;
    String s = list.toString();
    print(s);
    return file.writeAsString(s);
  }

  Future<String> readMyLocationsFile() async {
    try {
      final file = await findLocalFile;
      final contents = await file.readAsString();
      print('All saved cities: ${contents}');
      return contents;
    } catch (e) {
      print('error');
      return 'Error';
    }
  }

  Future<File> saveCityName(String? cityName) async {
    String previousCities = await readMyLocationsFile();
    print('Previous cities: ${previousCities}');
    String allSavedCities = '${previousCities}${cityName.toString()}, ';
    final file = await findLocalFile;
    return file.writeAsString(allSavedCities);
  }

  Future<File> deleteMyLocations() async {
    final file = await findLocalFile;
    String s = '';
    return file.writeAsString(s);
  }

  Future<List<String>> locationsList() async {
    String s = await readMyLocationsFile();
    List<String> list = s.split(', ');
    list.removeLast();
    return list;
  }

  Future<List<String>> locationsAndTemps() async {
    List<String> locations = await locationsList();
    List<String> temps = await temperatureList(locations);
    List<String> newTemps = List.filled(locations.length, '');
    for(int i = 0; i < locations.length; i++){
      newTemps[i] = temps[i];
    }
    List<String> locationsAndTempsList = locations + newTemps;
    return locationsAndTempsList;
  }


}