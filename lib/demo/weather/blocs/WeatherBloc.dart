import 'package:bloc/bloc.dart';
import 'package:flutter_app_1/demo/weather/blocs/WeatherEvent.dart';
import 'package:flutter_app_1/demo/weather/blocs/WeatherState.dart';
import 'package:flutter_app_1/demo/weather/models/models.dart';
import 'package:flutter_app_1/demo/weather/repositories/repositores.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({this.weatherRepository});

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
      WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoading();

      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        yield WeatherError();
      }
    }
  }
}
