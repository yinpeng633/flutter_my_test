import 'package:equatable/equatable.dart';
import 'package:flutter_app_1/demo/weather/models/WeatherCondition.dart';


class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  Weather(
      {this.condition,
      this.formattedCondition,
      this.minTemp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.created,
      this.lastUpdated,
      this.location})
      : super([
          condition,
          formattedCondition,
          minTemp,
          temp,
          maxTemp,
          locationId,
          created,
          lastUpdated,
          location,
        ]);

  static Weather fromJson(dynamic json) {
    final innerWeather = json['consolidated_weather'][0];
    return Weather(
      condition: mapStringtoWeatherCondition(innerWeather['weather_state_abbr']),
      formattedCondition: innerWeather['weather_state_name'],
      minTemp: innerWeather['min_temp'] as double,
      temp: innerWeather['the_temp'] as double,
      maxTemp: innerWeather['max_temp'] as double,
      locationId: json['woeid'] as int,
      created: innerWeather['created'],
      lastUpdated: DateTime.now(),
      location: json['title'],
    );
  }


  static WeatherCondition mapStringtoWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }
}
