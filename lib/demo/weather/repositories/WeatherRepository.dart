import 'package:flutter/material.dart';
import 'package:flutter_app_1/demo/weather/models/models.dart';
import 'package:flutter_app_1/demo/weather/repositories/Weather_api_client.dart';


class WeatherRepository {

  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient});

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}