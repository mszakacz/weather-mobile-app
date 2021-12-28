import 'package:flutter/material.dart';

String doubleToString(double d){
  String s;
  s = d.toString();
  s = s.substring(0, s.length - 2);
  return s;
}

class WeatherParameters {

  String? cityName;
  String? countyName;
  String? description;
  String? icon;
  int? windDirection;
  String? windSpeed;
  String? temperature;
  String? feelsTemp;
  int? clouds;
  String? pressure;
  int? airQuality;
  double? uv;

  WeatherParameters({this.cityName,
    this.countyName,
    this.description,
    this.icon,
    this.temperature,
    this.feelsTemp,
    this.windSpeed,
    this.windDirection,
    this.clouds,
    this.pressure,
    this.airQuality,
    this.uv
    });

  factory WeatherParameters.fromJson(Map < String, dynamic> data){
    final dataCurrent = data['current'];
    final dataLocation = data['location'];
    final dataAirQuality = dataCurrent['air_quality'];
    final dataCondition = dataCurrent['condition'];

    String cityName = dataLocation['name'];
    String countyName = dataLocation['country'];
    String description = dataCondition['text'];
    String icon = dataCondition['icon'];
    double temperatureD = dataCurrent['temp_c'];
    double feelsTempD = dataCurrent['feelslike_c'];
    double windSpeedD = dataCurrent['wind_kph'];
    int windDirection = dataCurrent['wind_degree'];
    int clouds = dataCurrent['cloud'];
    double pressureD = dataCurrent['pressure_mb'];
    int airQuality = dataAirQuality['gb-defra-index'];
    double uv = dataCurrent['uv'];

    String temperature = doubleToString(temperatureD);
    String feelsTemp = doubleToString(feelsTempD);
    String windSpeed = doubleToString(windSpeedD);
    String pressure = doubleToString(pressureD);


    WeatherParameters weather = WeatherParameters(
        cityName: cityName,
        countyName: countyName,
        description: description,
        icon: icon,
        temperature: temperature,
        feelsTemp: feelsTemp,
        windSpeed: windSpeed,
        windDirection: windDirection,
        clouds: clouds,
        pressure: pressure,
        airQuality: airQuality,
        uv: uv
    );

    return weather;
  }
}


// REFERENCE
/* {
    "location": {
        "name": "London",
        "region": "City of London, Greater London",
        "country": "United Kingdom",
        "lat": 51.52,
        "lon": -0.11,
        "tz_id": "Europe/London",
        "localtime_epoch": 1640353966,
        "localtime": "2021-12-24 13:52"
    },
    "current": {
        "last_updated_epoch": 1640353500,
        "temp_c": 10.0,
        "temp_f": 50.0,
        "is_day": 1,
        "condition": {
            "text": "Light rain",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/296.png",
            "code": 1183
        },
        "wind_mph": 6.9,
        "wind_kph": 11.2,
        "wind_degree": 180,
        "wind_dir": "S",
        "pressure_mb": 1003.0,
        "pressure_in": 29.62,
        "precip_mm": 0.0,
        "precip_in": 0.0,
        "humidity": 94,
        "cloud": 75,
        "feelslike_c": 10.1,
        "feelslike_f": 50.2,
        "vis_km": 10.0,
        "vis_miles": 6.0,
        "uv": 2.0,
        "gust_mph": 3.8,
        "gust_kph": 6.1,
        "air_quality": {
            "co": 500.70001220703125,
            "no2": 39.400001525878906,
            "o3": 0.20000000298023224,
            "so2": 31.5,
            "pm2_5": 22.200000762939453,
            "pm10": 25.899999618530273,
            "us-epa-index": 2,
            "gb-defra-index": 2
        }
    }
}
*/