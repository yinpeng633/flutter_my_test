import 'dart:convert';

import 'package:flutter_app_1/demo/weather/models/models.dart';
import 'package:http/http.dart';


class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final Client httpClient;

  WeatherApiClient({this.httpClient}) : assert(httpClient != null);



  /**
   * 根据城市string获取 locationid
   */
  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await this.httpClient.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception('获取locationId失败');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  /**
   * 根据locationId获取 Weather
   */
  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('获取weather失败');
    }

    return Weather.fromJson(jsonDecode(weatherResponse.body));
  }
}
