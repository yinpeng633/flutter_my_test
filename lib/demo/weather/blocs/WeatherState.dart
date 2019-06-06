import 'package:equatable/equatable.dart';
import 'package:flutter_app_1/demo/weather/models/models.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({this.weather}) : super([weather]);
}

class WeatherError extends WeatherState {}
