

import 'package:flutter/material.dart';
import 'package:flutter_app_1/demo/weather/repositories/repositores.dart';

class WeatherPage extends StatelessWidget {
  final WeatherRepository weatherRepository;


  const WeatherPage({Key key, this.weatherRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: weather_page(),
    );
  }
}


class weather_page extends StatefulWidget {
  weather_page({Key key}) : super(key: key);

  _weather_pageState createState() => _weather_pageState();
}

class _weather_pageState extends State<weather_page> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text('居中'),
       ),
    );
  }
}