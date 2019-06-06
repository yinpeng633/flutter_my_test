import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WeatherEvent extends Equatable{
  WeatherEvent([List pros = const []]) : super(pros);
}

class FetchWeatherEvent extends WeatherEvent {
  final String city;

  FetchWeatherEvent({@required this.city}) : super([city]);
}